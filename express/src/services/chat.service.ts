import { inject, injectable } from "tsyringe";
import { IChat } from "../interfaces/IChat.js";
import { ChatRepository } from "../repository/chat.repository.js";

@injectable()
export class ChatService {
  constructor(
    @inject(ChatRepository) private readonly chatRepository: ChatRepository
  ) {}

  async create(userId: string, currentUser: any): Promise<IChat> {
    const members = [{ user: `${currentUser._id}` }, { user: userId }];
    return this.chatRepository.create({ members } as any);
  }

  async createGroup(
    userIds: string[],
    name: string,
    currentUser: any
  ): Promise<IChat> {
    const members = [
      { user: `${currentUser._id}`, admin: true },
      ...userIds.map((id) => ({ user: id, addedBy: currentUser._id })),
    ];
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
    currentUser: any
  ): Promise<IChat | null> {
    const members = userIds.map((id) => ({
      user: id,
      addedBy: currentUser.id,
    }));
    return this.chatRepository.addMember(chatId, members);
  }

  async removeMember(chatId: string, userId: string): Promise<IChat | null> {
    return this.chatRepository.removeMember(chatId, userId);
  }
}
