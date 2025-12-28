import cors from "cors";
import express, { Application } from "express";
import { Server } from "socket.io"; // Import Server for type
import { Database } from "./config/database.js";
import { errorHandler, urlNotFound } from "./middleware/error.middleware.js"; // Path updated
import { SocketService } from "./services/socket.service.js";
import { publicDirectory } from "./utils/directory.js";

// Import Controllers and Routes
// Since I haven't refactored Routes to accept Controller instances yet, I will do it incrementally.
// But to support DI, I really should instantiated controllers in App or a Container and pass them.
// For now, I will instantiate SocketService and use it.
// I will also move the route definitions to use the new Validator classes?
// No, the validators are utilized inside Controllers?
// The controllers rely on static validators currently (before my refactor).
// I need to update Controllers to use the injected (or instantiated) Validator classes.

// Current Controllers export an instance `new Controller()`.
// I should update them to export the Class, or keep singleton instance but set dependencies.

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
    this.app.use(urlNotFound);
    this.app.use(errorHandler);
  }
}
