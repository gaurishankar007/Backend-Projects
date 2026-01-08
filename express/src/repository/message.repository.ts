import { singleton } from "tsyringe";
import { IMessage } from "../interfaces/IMessage.js";
import MessageModel from "../models/message.model.js";
import { GenericRepository } from "./base/generic.repository.js";

@singleton()
export class MessageRepository extends GenericRepository<IMessage> {
  constructor() {
    super(MessageModel);
  }

  async findChatMessages(chatId: string, page: number): Promise<IMessage[]> {
    return this.model
      .find({ chat: chatId })
      .sort({ createdAt: -1 })
      .skip((page - 1) * 10)
      .limit(10)
      .exec();
  }
}
