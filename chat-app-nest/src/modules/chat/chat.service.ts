import { BadRequestException, Injectable } from '@nestjs/common';
import { Types } from 'mongoose';
import { ChatRepository } from './chat.repository';
import { Chat } from './schemas/chat.schema';

@Injectable()
export class ChatService {
  constructor(private readonly chatRepository: ChatRepository) {}

  async accessChat(userId: string, currentUserId: string) {
    // Check if chat exists
    const isChat = await this.chatRepository.findOne({
      isGroupChat: false,
      $and: [
        { users: { $elemMatch: { $eq: currentUserId } } },
        { users: { $elemMatch: { $eq: userId } } },
      ],
    });

    if (isChat) {
      return isChat;
    } else {
      const chatData = {
        chatName: 'sender',
        isGroupChat: false,
        users: [currentUserId, userId] as unknown as Chat['users'],
      };
      return await this.chatRepository.create(chatData);
    }
  }

  async fetchChats(userId: string) {
    return await this.chatRepository.findChatsByUser(userId);
  }

  async createGroupChat(name: string, users: string[], admin: string) {
    if (users.length < 2) {
      throw new BadRequestException('Group chat requires at least 2 users');
    }

    const allUsers = [...users, admin];

    return await this.chatRepository.create({
      chatName: name,
      users: allUsers as unknown as Chat['users'],
      isGroupChat: true,
      groupAdmin: admin as unknown as Chat['groupAdmin'],
    });
  }

  async addMembers(chatId: string, userIds: string[]) {
    return await this.chatRepository.addMember(chatId, userIds);
  }

  async removeMember(chatId: string, userId: string) {
    return await this.chatRepository.removeMember(chatId, userId);
  }

  async deleteGroupChat(chatId: string, currentUserId: string) {
    const chat = await this.chatRepository.findById(chatId);
    if (!chat) throw new BadRequestException('Invalid chat id');
    if (!chat.isGroupChat) throw new BadRequestException('Chat is not a group');
    const adminId = (chat.groupAdmin as unknown as Types.ObjectId).toString();
    if (adminId !== currentUserId)
      throw new BadRequestException('You are not allowed to delete this chat');

    return await this.chatRepository.delete(chatId);
  }
}
