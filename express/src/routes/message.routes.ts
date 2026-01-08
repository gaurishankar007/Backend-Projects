import { Router } from "express";
import { container } from "tsyringe";
import { MessageController } from "../controllers/message.controller.js";
import authMiddleWare from "../middleware/auth.middleware.js";
import { validate } from "../middleware/validate.middleware.js";
import audioMiddleware from "../uploads/audio.upload.js";
import imageMiddleware from "../uploads/image.upload.js";
import videoMiddleware from "../uploads/video.upload.js";
import {
  fetchMessageSchema,
  sendFileSchema,
  sendMessageSchema,
} from "../utils/validators/message.schema.js";

class MessageRoute {
  public readonly router: Router;

  constructor() {
    this.router = Router();
    this.initRoutes();
  }

  private initRoutes() {
    const messageController = container.resolve(MessageController);

    this.router.post(
      "/text",
      authMiddleWare,
      validate(sendMessageSchema),
      messageController.text.bind(messageController)
    );

    this.router.post(
      "/image",
      authMiddleWare,
      imageMiddleware,
      validate(sendFileSchema),
      messageController.file.bind(messageController)
    );

    this.router.post(
      "/audio",
      authMiddleWare,
      audioMiddleware,
      validate(sendFileSchema),
      messageController.file.bind(messageController)
    );

    this.router.post(
      "/video",
      authMiddleWare,
      videoMiddleware,
      validate(sendFileSchema),
      messageController.file.bind(messageController)
    );

    this.router.post(
      "/fetch",
      authMiddleWare,
      validate(fetchMessageSchema),
      messageController.fetch.bind(messageController)
    );
  }
}

export default new MessageRoute().router;
