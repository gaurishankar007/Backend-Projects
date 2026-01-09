import { Router } from "express";
import { container } from "tsyringe";
import { ChatController } from "../controllers/chat.controller.js";
import authMiddleware from "../middleware/auth.middleware.js";
import { validate } from "../middleware/validate.middleware.js";
import {
  addMemberSchema,
  createChatSchema,
  createGroupSchema,
  deleteChatSchema,
  fetchChatSchema,
  removeMemberSchema,
} from "../utils/validators/chat.schema.js";

class ChatRoute {
  public readonly router: Router;

  constructor() {
    this.router = Router();
    this.initRoutes();
  }

  private initRoutes() {
    const chatController = container.resolve(ChatController);

    this.router.post(
      "/create",
      authMiddleware,
      validate(createChatSchema),
      chatController.create.bind(chatController)
    );
    this.router.post(
      "/createGroup",
      authMiddleware,
      validate(createGroupSchema),
      chatController.createGroup.bind(chatController)
    );
    this.router.get(
      "/fetch",
      authMiddleware,
      validate(fetchChatSchema),
      chatController.fetch.bind(chatController)
    );
    this.router.put(
      "/addMember",
      authMiddleware,
      validate(addMemberSchema),
      chatController.addMember.bind(chatController)
    );
    this.router.delete(
      "/removeMember",
      authMiddleware,
      validate(removeMemberSchema),
      chatController.removeMember.bind(chatController)
    );
    this.router.delete(
      "/deleteGroup",
      authMiddleware,
      validate(deleteChatSchema),
      chatController.deleteGroupChat.bind(chatController)
    );
  }
}

export default new ChatRoute().router;
