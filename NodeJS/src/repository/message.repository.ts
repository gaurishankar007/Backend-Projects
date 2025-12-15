import { singleton } from "tsyringe";
import { IMessage } from "../interfaces/IMessage.js";
import MessageModel from "../models/message.model.js";
import { GenericRepository } from "./generic.repository.js";

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
      .populate("repliedTo")
      .exec();
  }

  async addReaction(
    messageId: string,
    reaction: any
  ): Promise<IMessage | null> {
    return this.model
      .findByIdAndUpdate(
        messageId,
        { $push: { reactions: reaction } },
        { new: true }
      )
      .exec();
  }

  async removeReaction(
    messageId: string,
    reactionId: string
  ): Promise<IMessage | null> {
    return this.model
      .findByIdAndUpdate(
        messageId,
        { $pull: { reactions: { _id: reactionId } } },
        { new: true }
      )
      .exec();
  }
}
