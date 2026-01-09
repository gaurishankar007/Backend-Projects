import { Server, Socket } from "socket.io";
import { inject, singleton } from "tsyringe";
import socketMiddleware from "../middleware/socket.middleware.js";
import { ChatService } from "./chat.service.js";
import { MessageService } from "./message.service.js";

@singleton()
export class SocketService {
  private io?: Server;

  constructor(
    @inject(ChatService) private readonly chatService: ChatService,
    @inject(MessageService) private readonly messageService: MessageService
  ) {}

  initialize(io: Server) {
    this.io = io;
    this.io.use(socketMiddleware);
    this.io.on("connection", (socket) => this.handleConnection(socket));
  }

  /**
   * Main connection handler for authenticated users.
   * Sets up event listeners and manages online status.
   */
  private async handleConnection(socket: Socket) {
    const userId = socket.data.user?._id;
    if (!userId) {
      socket.disconnect(true);
      return;
    }

    console.log(`User connected: ${userId}`);
    // Join a personal room named after the userId.
    // This allows sending messages specifically to only this user (e.g. notifications).
    socket.join(userId);

    // Notify friends I'm online and get their status
    await this.handleOnlineStatus(socket, userId);

    // Event: User opens a specific chat window
    socket.on("join-chat", (chatId: string) => {
      console.log(`User ${userId} joined chat: ${chatId}`);
      socket.join(chatId);
    });

    // Event: User closes a specific chat window
    socket.on("leave-chat", (chatId: string) => {
      console.log(`User ${userId} left chat: ${chatId}`);
      socket.leave(chatId);
    });

    // Event: User starts typing
    // broadcast to everyone in the chat room EXCEPT the sender
    socket.on("typing", ({ chatId }: { chatId: string }) => {
      socket.to(chatId).emit("typing", { chatId, userId });
    });

    // Event: User stops typing
    socket.on("stop-typing", ({ chatId }: { chatId: string }) => {
      socket.to(chatId).emit("stop-typing", { chatId, userId });
    });

    // Event: User sends a message
    // 1. Save to DB
    // 2. Broadcast to chat room (Optimistic UI: exclude sender)
    // 3. Acknowledge success/failure to client callback
    socket.on(
      "send-message",
      async (
        {
          chatId,
          content,
          contentType,
        }: {
          chatId: string;
          content: string;
          contentType: string;
        },
        callback?: (response: any) => void
      ) => {
        try {
          const message = await this.messageService.sendMessage(
            chatId,
            content,
            contentType,
            socket.data.user
          );
          socket.to(chatId).emit("new-message", message);
          if (callback) callback({ status: "ok", message });
        } catch (error: any) {
          if (callback) callback({ status: "error", message: error.message });
          else socket.emit("error", { message: error.message });
        }
      }
    );

    // Event: User disconnects
    // Notify friends that this user is now offline
    socket.on("disconnect", async () => {
      console.log(`User disconnected: ${userId}`);
      socket.leave(userId);
      await this.broadcastOffline(userId);
    });
  }

  /**
   * 1. Finds all potential "friends" (members of user's active chats).
   * 2. Notifies them that THIS user is now online.
   * 3. Sends THIS user the list of friends who are currently online.
   */
  private async handleOnlineStatus(socket: Socket, userId: string) {
    try {
      const chats = await this.chatService.fetch(userId, 1);
      const memberIds = new Set<string>();
      chats.forEach((chat) => {
        chat.members.forEach((member: any) => {
          const mId = member._id ? member._id.toString() : member.toString();
          if (mId !== userId) {
            memberIds.add(mId);
          }
        });
      });

      memberIds.forEach((mId) => {
        socket.to(mId).emit("user-online", { userId });
      });

      const onlineFriends: string[] = [];
      memberIds.forEach((mId) => {
        const room = this.io?.sockets.adapter.rooms.get(mId);
        if (room && room.size > 0) {
          onlineFriends.push(mId);
        }
      });

      socket.emit("online-users", onlineFriends);
    } catch (e) {
      console.error("Error handling online status", e);
    }
  }

  /**
   * Notifies all "friends" (members of user's chats) that this user has gone offline.
   */
  private async broadcastOffline(userId: string) {
    try {
      const chats = await this.chatService.fetch(userId, 1);
      const memberIds = new Set<string>();
      chats.forEach((chat) => {
        chat.members.forEach((member: any) => {
          const mId = member._id ? member._id.toString() : member.toString();
          if (mId !== userId) {
            memberIds.add(mId);
          }
        });
      });

      memberIds.forEach((mId) => {
        this.io?.to(mId).emit("user-offline", { userId });
      });
    } catch (e) {
      console.error(e);
    }
  }

  /**
   * Called when a new chat is created via REST API.
   * Notifies all members so they can update their chat list in real-time.
   */
  public emitNewChat(chat: any) {
    chat.members.forEach((member: any) => {
      const id = member._id ? member._id.toString() : member.toString();
      this.io?.to(id).emit("new-chat", chat);
    });
  }

  /**
   * Called when group metadata changes (member added/removed).
   * 1. Notifies the chat room (active participants).
   * 2. Notifies the specific target user (who might not be in the room yet).
   */
  public emitGroupUpdate(
    chat: any,
    action: "added" | "removed" | "updated",
    targetUserId?: string | string[]
  ) {
    // Notify the room
    const chatId = chat._id ? chat._id.toString() : chat.toString();
    this.io?.to(chatId).emit("group-update", { chat, action, targetUserId });

    // Handle specific notifications for users who might not be in the room
    if (targetUserId) {
      const targets = Array.isArray(targetUserId)
        ? targetUserId
        : [targetUserId];

      if (action === "added") {
        targets.forEach((id) => this.io?.to(id).emit("new-chat", chat));
      } else if (action === "removed") {
        targets.forEach((id) =>
          this.io?.to(id).emit("group-update", { chat, action, targetUserId })
        );
      }
    }
  }
}
