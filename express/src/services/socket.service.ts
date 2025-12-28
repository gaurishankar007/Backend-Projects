import { Server, Socket } from "socket.io";
import socketMiddleware from "../middleware/socket.middleware.js";

export class SocketService {
  private io?: Server;

  initialize(io: Server) {
    this.io = io;
    this.io.use(socketMiddleware);
    this.io.on("connection", (socket) => this.handleConnection(socket));
  }

  private handleConnection(socket: Socket) {
    socket.on("setup", (userData: any) => {
      const userId = userData.userId;
      const friends = userData.friends;

      socket.join(userId);
      for (const friend in friends) {
        socket.to(friend).emit("online", userData.userId);
      }
    });

    socket.on("join-chat", (chatId: any) => socket.join(chatId));

    socket.on("typing", (typeData: any) =>
      socket.to(typeData.chatId).emit("typing", typeData.typist)
    );

    socket.on("stop-typing", (typeData: any) =>
      socket.to(typeData.chatId).emit("stop-typing", typeData.typist)
    );

    socket.on("message", (messageData: any) => {
      socket
        .in(messageData.chatId)
        .emit("message-received", messageData.message);
    });

    socket.on("message-seen", (seenData: any) =>
      socket.to(seenData.chatId).emit("message-seen", seenData.member)
    );

    socket.on("set-theme", (themeData: any) =>
      socket.to(themeData.chatId).emit("new-theme", themeData.theme)
    );

    socket.off("setup", () => {
      // console.log(userData);
      // socket.leave(userData.userId);
    });
  }
}
