import { inject, injectable } from "tsyringe";
import { IMessage } from "../interfaces/IMessage.js";
import { IUser } from "../interfaces/IUser.js";
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
    user: IUser
  ): Promise<IMessage> {
    // Mongoose will handle string-to-ObjectId conversion and apply defaults
    const message = await this.messageRepository.create({
      chat: chatId,
      user: user._id,
      content,
      contentType,
    } as any);

    await this.chatRepository.updateLastMessage(chatId, message._id as string);
    return message;
  }

  async fetch(chatId: string, page: number): Promise<IMessage[]> {
    return this.messageRepository.findChatMessages(chatId, page);
  }

  async deleteMessage(
    messageId: string,
    userId: string
  ): Promise<IMessage | null> {
    const message = await this.messageRepository.findById(messageId);
    if (!message) throw new Error("Invalid message id");
    if (message.user.toString() !== userId)
      throw new Error("You are not allowed to delete this message");
    return this.messageRepository.delete(messageId);
  }
}
