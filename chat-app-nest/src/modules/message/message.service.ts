import { Injectable } from '@nestjs/common';
import { Types } from 'mongoose';
import { ChatRepository } from '../chat/chat.repository';
import { MessageRepository } from './message.repository';

@Injectable()
export class MessageService {
  constructor(
    private readonly messageRepository: MessageRepository,
    private readonly chatRepository: ChatRepository,
  ) {}

  async sendMessage(
    senderId: string,
    content: string,
    chatId: string,
    contentType: string = 'text',
  ) {
    const newMessage = await this.messageRepository.create({
      sender: new Types.ObjectId(senderId),
      content,
      chat: new Types.ObjectId(chatId),
      contentType,
    });

    // Update latest message in chat
    await this.chatRepository.update(chatId, { latestMessage: newMessage._id });

    // Populate sender and chat
    return await this.messageRepository.findById(newMessage._id.toString());
  }

  async getMessagesByChatId(chatId: string) {
    return await this.messageRepository.findByChatId(chatId);
  }

  async fetch(chatId: string, page: number) {
    return await this.messageRepository.findChatMessages(chatId, page);
  }

  async deleteMessage(messageId: string, userId: string) {
    const message = await this.messageRepository.findById(messageId);
    if (!message) {
      throw new Error('Invalid message id');
    }
    if (`${message.sender as any}` !== userId) {
      throw new Error('You are not allowed to delete this message');
    }
    return await this.messageRepository.delete(messageId);
  }
}
