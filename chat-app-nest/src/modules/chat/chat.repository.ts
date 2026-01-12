import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AbstractRepository } from '../../database/abstract.repository';
import { Chat, ChatDocument } from './schemas/chat.schema';

@Injectable()
export class ChatRepository extends AbstractRepository<ChatDocument> {
  constructor(@InjectModel(Chat.name) chatModel: Model<ChatDocument>) {
    super(chatModel);
  }

  async findChatsByUser(userId: string): Promise<ChatDocument[]> {
    return (await this.model
      .find({ users: { $elemMatch: { $eq: userId } } })
      .populate('users', '-password')
      .populate('groupAdmin', '-password')
      .populate('latestMessage')
      .sort({ updatedAt: -1 })) as unknown as ChatDocument[];
  }

  async addMember(
    chatId: string,
    userIds: string[],
  ): Promise<ChatDocument | null> {
    return (await this.model
      .findByIdAndUpdate(
        chatId,
        { $push: { users: { $each: userIds } } },
        { new: true },
      )
      .populate('users', '-password')
      .populate('groupAdmin', '-password')) as unknown as ChatDocument | null;
  }

  async removeMember(
    chatId: string,
    userId: string,
  ): Promise<ChatDocument | null> {
    return (await this.model
      .findByIdAndUpdate(chatId, { $pull: { users: userId } }, { new: true })
      .populate('users', '-password')
      .populate('groupAdmin', '-password')) as unknown as ChatDocument | null;
  }
}
