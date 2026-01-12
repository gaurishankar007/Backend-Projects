import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Types } from 'mongoose';
import { Server, Socket } from 'socket.io';
import { ChatService } from '../modules/chat/chat.service';
import { Chat } from '../modules/chat/schemas/chat.schema';
import { MessageService } from '../modules/message/message.service';
import { User } from '../modules/user/schemas/user.schema';

@WebSocketGateway({
  cors: {
    origin: '*',
  },
})
export class EventsGateway implements OnGatewayConnection, OnGatewayDisconnect {
  @WebSocketServer()
  server: Server;

  constructor(
    private readonly chatService: ChatService,
    private readonly messageService: MessageService,
  ) {}

  /**
   * Helper to get string ID from User or ObjectId
   * Specifically avoids 'any' to satisfy strict lint rules.
   */
  private getUserId(user: User | Types.ObjectId): string {
    if (user instanceof Types.ObjectId) {
      return user.toHexString();
    }

    // Cast to an object that definitely has _id of a known type
    const userObj = user as { _id?: Types.ObjectId | string };

    if (userObj._id) {
      return typeof userObj._id === 'string'
        ? userObj._id
        : userObj._id.toHexString();
    }

    return '';
  }

  handleConnection(client: Socket) {
    console.log(`Client connected: ${client.id}`);
  }

  async handleDisconnect(client: Socket) {
    const userId = Array.from(client.rooms).find((r) => r !== client.id);
    if (userId) {
      console.log(`User ${userId} disconnected`);
      await this.broadcastOffline(userId);
    }
  }

  @SubscribeMessage('setup')
  async handleSetup(
    @MessageBody() userData: { _id: string },
    @ConnectedSocket() client: Socket,
  ) {
    const userId = userData._id;
    await client.join(userId);
    console.log(`User ${userId} setup completed`);
    client.emit('connected');

    // Notify friends I'm online and get their status
    await this.handleOnlineStatus(client, userId);
  }

  @SubscribeMessage('join-chat')
  async handleJoinChat(
    @MessageBody() chatId: string,
    @ConnectedSocket() client: Socket,
  ) {
    await client.join(chatId);
    console.log(`User joined chat room: ${chatId}`);
  }

  @SubscribeMessage('leave-chat')
  async handleLeaveChat(
    @MessageBody() chatId: string,
    @ConnectedSocket() client: Socket,
  ) {
    await client.leave(chatId);
    console.log(`User left chat room: ${chatId}`);
  }

  @SubscribeMessage('typing')
  handleTyping(
    @MessageBody() data: { chatId: string; userId: string },
    @ConnectedSocket() client: Socket,
  ) {
    client.to(data.chatId).emit('typing', data);
  }

  @SubscribeMessage('stop-typing')
  handleStopTyping(
    @MessageBody() data: { chatId: string; userId: string },
    @ConnectedSocket() client: Socket,
  ) {
    client.to(data.chatId).emit('stop-typing', data);
  }

  @SubscribeMessage('new-message')
  async handleSendMessage(
    @MessageBody()
    data: {
      chatId: string;
      content: string;
      contentType: string;
      userId: string;
    },
    @ConnectedSocket() client: Socket,
  ) {
    try {
      const message = await this.messageService.sendMessage(
        data.userId,
        data.content,
        data.chatId,
        data.contentType,
      );

      if (!message) {
        return { status: 'error', message: 'Failed to send message' };
      }

      // Broadcast to everyone in the room except the sender
      client.to(data.chatId).emit('message-received', message);

      // Acknowledge to sender
      return { status: 'ok', message };
    } catch (error: unknown) {
      const errorMessage =
        error instanceof Error ? error.message : String(error);
      return { status: 'error', message: errorMessage };
    }
  }

  private async handleOnlineStatus(client: Socket, userId: string) {
    try {
      const chats = await this.chatService.fetchChats(userId);
      const memberIds = new Set<string>();

      chats.forEach((chat: Chat) => {
        if (chat.users) {
          chat.users.forEach((user: User | Types.ObjectId) => {
            const mId = this.getUserId(user);
            if (mId !== userId) memberIds.add(mId);
          });
        }
      });

      // Notify friends I'm online
      memberIds.forEach((mId) => {
        this.server.to(mId).emit('user-online', { userId });
      });

      // Find which friends are currently online
      const onlineFriends: string[] = [];
      for (const mId of memberIds) {
        const sockets = await this.server.in(mId).fetchSockets();
        if (sockets.length > 0) onlineFriends.push(mId);
      }

      client.emit('online-users', onlineFriends);
    } catch (e) {
      console.error('Error handling online status', e);
    }
  }

  private async broadcastOffline(userId: string) {
    try {
      const chats = await this.chatService.fetchChats(userId);
      const memberIds = new Set<string>();

      chats.forEach((chat: Chat) => {
        if (chat.users) {
          chat.users.forEach((user: User | Types.ObjectId) => {
            const mId = this.getUserId(user);
            if (mId !== userId) memberIds.add(mId);
          });
        }
      });

      memberIds.forEach((mId) => {
        this.server.to(mId).emit('user-offline', { userId });
      });
    } catch (e) {
      console.error('Error broadcasting offline status', e);
    }
  }

  // Helper methods to be called from services (like emitNewChat in Express)
  // You would inject this gateway into your ChatService to use these.
  emitNewChat(chat: Chat) {
    if (chat.users) {
      chat.users.forEach((user: User | Types.ObjectId) => {
        const id = this.getUserId(user);
        this.server.to(id).emit('new-chat', chat);
      });
    }
  }
}
