import { inject, injectable } from "tsyringe";
import { IMessage } from "../interfaces/IMessage.js";
import { ChatRepository } from "../repository/chat.repository.js";
import { MessageRepository } from "../repository/message.repository.js";

@injectable()
export class MessageService {
  constructor(
    @inject(MessageRepository)
    private readonly messageRepository: MessageRepository,
    @inject(ChatRepository) private readonly chatRepository: ChatRepository
  ) {}

  async create(data: Partial<IMessage>): Promise<IMessage> {
    // This is a rough create, but we have specific methods below
    return this.messageRepository.create(data as IMessage);
  }

  async sendMessage(
    chatId: string,
    content: string,
    contentType: string,
    user: any
  ): Promise<IMessage> {
    const message = await this.messageRepository.create({
      chat: chatId,
      user: user._id,
      content,
      contentType,
    } as any);

    await this.chatRepository.updateLastMessage(chatId, message._id as string);
    return message;
  }

  async replyMessage(
    chatId: string,
    messageId: string,
    content: string,
    contentType: string,
    user: any
  ): Promise<IMessage> {
    const message = await this.messageRepository.create({
      chat: chatId,
      user: user._id,
      content,
      contentType,
      repliedTo: messageId,
    } as any);

    await this.chatRepository.updateLastMessage(chatId, message._id as string);
    return message;
  }

  async addReaction(
    messageId: string,
    reaction: string,
    user: any
  ): Promise<IMessage | null> {
    return this.messageRepository.addReaction(messageId, {
      reaction,
      user: user._id,
    });
  }

  async removeReaction(
    messageId: string,
    reactionId: string
  ): Promise<IMessage | null> {
    return this.messageRepository.removeReaction(messageId, reactionId);
  }

  async fetch(chatId: string, page: number): Promise<IMessage[]> {
    return this.messageRepository.findChatMessages(chatId, page);
  }
}
