import { inject, injectable } from "tsyringe";
import { IChat } from "../interfaces/IChat.js";
import { IUser } from "../interfaces/IUser.js";
import { ChatRepository } from "../repository/chat.repository.js";

@injectable()
export class ChatService {
  constructor(
    @inject(ChatRepository) private readonly chatRepository: ChatRepository
  ) {}

  async create(userId: string, currentUser: IUser): Promise<IChat> {
    const members = [currentUser._id, userId];
    // Mongoose will handle string-to-ObjectId conversion and apply defaults for missing fields
    return this.chatRepository.create({ members } as any);
  }

  async createGroup(
    userIds: string[],
    name: string,
    currentUser: IUser
  ): Promise<IChat> {
    const members = [currentUser._id, ...userIds];
    // Mongoose will handle string-to-ObjectId conversion and apply defaults for missing fields
    return this.chatRepository.create({
      members,
      name,
      group: true,
      creator: currentUser._id,
    } as any);
  }

  async fetch(userId: string, page: number): Promise<IChat[]> {
    return this.chatRepository.findUserChats(userId, page);
  }

  async addMember(
    chatId: string,
    userIds: string[],
    currentUser: IUser
  ): Promise<IChat | null> {
    const members = userIds; // Just the IDs now
    return this.chatRepository.addMember(chatId, members);
  }

  async removeMember(chatId: string, userId: string): Promise<IChat | null> {
    return this.chatRepository.removeMember(chatId, userId);
  }
}
