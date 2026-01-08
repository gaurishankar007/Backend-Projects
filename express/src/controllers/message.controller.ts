import { inject, injectable } from "tsyringe";
import { MessageService } from "../services/message.service.js";
import { errorResponse, successResponse } from "../utils/response.js";

@injectable()
export class MessageController {
  constructor(
    @inject(MessageService) private readonly messageService: MessageService
  ) {}

  async text(req: any, res: any) {
    // Validation done by Zod
    const { chatId, content, contentType } = req.body;
    try {
      const message = await this.messageService.sendMessage(
        chatId,
        content,
        contentType,
        (req as any).user
      );
      successResponse(res, message);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async file(req: any, res: any) {
    const file = req.file;
    const { chatId, contentType } = req.body;
    try {
      const message = await this.messageService.sendMessage(
        chatId,
        file.filename,
        contentType,
        req.user
      );
      successResponse(res, message);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async fetch(req: any, res: any) {
    // Validation done by Zod
    const { chatId, page } = req.body;
    try {
      const messages = await this.messageService.fetch(chatId, page);
      successResponse(res, messages);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }
}
