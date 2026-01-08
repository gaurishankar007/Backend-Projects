import cors from "cors";
import express, { Application } from "express";
import { Server } from "socket.io"; // Import Server for type
import { Database } from "./config/database.js";
import ErrorHandler from "./middleware/error.middleware.js"; // Path updated
import { SocketService } from "./services/socket.service.js";
import { publicDirectory } from "./utils/directory.js";

import chatRouter from "./routes/chat.routes.js";
import messageRouter from "./routes/message.routes.js";
import userRouter from "./routes/user.routes.js";

export class App {
  public app: Application;
  public socketService: SocketService;
  public io?: Server;

  constructor() {
    this.app = express();
    this.socketService = new SocketService();
    this.initializeConfig();
    this.initializeMiddlewares();
    this.initializeRoutes();
    this.initializeErrorHandling();
  }

  public initializeSocket(io: Server) {
    this.io = io;
    this.socketService.initialize(io);
  }

  private initializeConfig() {
    new Database();
  }

  private initializeMiddlewares() {
    const corsOption = { origin: [] };
    this.app.use(cors(corsOption));
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));
    this.app.use("/public/", express.static(publicDirectory("/")));
  }

  private initializeRoutes() {
    this.app.use("/api/auth", userRouter);
    this.app.use("/api/chat", chatRouter);
    this.app.use("/api/message", messageRouter);
  }

  private initializeErrorHandling() {
    this.app.use(ErrorHandler.notFound);
    this.app.use(ErrorHandler.serverError);
  }
}
