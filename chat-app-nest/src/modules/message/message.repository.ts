import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { AbstractRepository } from '../../database/abstract.repository';
import { Message, MessageDocument } from './schemas/message.schema';

@Injectable()
export class MessageRepository extends AbstractRepository<MessageDocument> {
  constructor(@InjectModel(Message.name) messageModel: Model<MessageDocument>) {
    super(messageModel);
  }

  async findByChatId(chatId: string): Promise<MessageDocument[]> {
    return (await this.model
      .find({ chat: chatId })
      .populate('sender', 'name pic email')
      .populate('chat')) as unknown as MessageDocument[];
  }

  async findChatMessages(
    chatId: string,
    page: number,
  ): Promise<MessageDocument[]> {
    const limit = 20;
    return (await this.model
      .find({ chat: chatId })
      .populate('sender', 'name pic email')
      .populate('chat')
      .sort({ createdAt: -1 })
      .skip((page - 1) * limit)
      .limit(limit)) as unknown as MessageDocument[];
  }
}
