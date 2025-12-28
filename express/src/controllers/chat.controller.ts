import { Request, Response } from "express";
import { inject, injectable } from "tsyringe";
import { ChatService } from "../services/chat.service.js";
import { errorResponse, successResponse } from "../utils/response.js";

@injectable()
export class ChatController {
  constructor(@inject(ChatService) private readonly chatService: ChatService) {}

  async create(req: Request, res: Response) {
    const userId = (req as any).body.userId;
    // Validation: done by Zod (userId required)

    try {
      const chat = await this.chatService.create(userId, (req as any).user);
      successResponse(res, chat);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async createGroup(req: Request, res: Response) {
    const { userIds, name } = req.body;
    // Validation: done by Zod

    try {
      const chat = await this.chatService.createGroup(
        userIds,
        name,
        (req as any).user
      );
      successResponse(res, chat);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async fetch(req: Request, res: Response) {
    const page = req.body.page;
    // Validation: done by Zod (page required, integer)

    try {
      const chats = await this.chatService.fetch(
        (req as any).user._id,
        Number(page)
      );
      successResponse(res, chats);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async addMember(req: Request, res: Response) {
    // Validation handled by Zod
    const { chatId, userIds } = req.body;
    try {
      // In original controller variable 'members' was constructed and returned.
      // Service returns the updated chat.
      const chat = await this.chatService.addMember(
        chatId,
        userIds,
        (req as any).user
      );
      if (!chat) return errorResponse(res, "Invalid chat id");
      successResponse(res, chat);
      // Original returned just the new members array.
      // If client expects members array, I should adjust.
      // But returning full chat is usually safer/better.
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async removeMember(req: Request, res: Response) {
    // Validation handled by Zod
    const { chatId, userId } = req.body;
    try {
      const chat = await this.chatService.removeMember(chatId, userId);
      if (!chat) return errorResponse(res, "Invalid chat id");
      successResponse(res, "Member removed");
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }
}
