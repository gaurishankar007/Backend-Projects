import { singleton } from "tsyringe";
import { IChat } from "../interfaces/IChat.js";
import ChatModel from "../models/chat.model.js";
import { GenericRepository } from "./base/generic.repository.js";

@singleton()
export class ChatRepository extends GenericRepository<IChat> {
  constructor() {
    super(ChatModel);
  }

  async findUserChats(userId: string, page: number): Promise<IChat[]> {
    return this.model
      .find({
        members: userId,
      })
      .sort({ createdAt: -1 })
      .skip((page - 1) * 10)
      .limit(10)
      .populate("members", "-password")
      .populate("lastMessage")
      .exec();
  }

  async addMember(chatId: string, members: any[]): Promise<IChat | null> {
    return this.model
      .findByIdAndUpdate(
        chatId,
        { $push: { members: { $each: members } } },
        { new: true }
      )
      .exec();
  }

  async removeMember(chatId: string, userId: string): Promise<IChat | null> {
    return this.model
      .findByIdAndUpdate(chatId, { $pull: { members: userId } }, { new: true })
      .exec();
  }

  async updateLastMessage(
    chatId: string,
    messageId: string
  ): Promise<IChat | null> {
    return this.model
      .findByIdAndUpdate(chatId, { lastMessage: messageId }, { new: true })
      .exec();
  }
}
