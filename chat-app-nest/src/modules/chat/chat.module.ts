import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ChatController } from './chat.controller';
import { ChatRepository } from './chat.repository';
import { ChatService } from './chat.service';
import { Chat, ChatSchema } from './schemas/chat.schema';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: Chat.name, schema: ChatSchema }]),
  ],
  controllers: [ChatController],
  providers: [ChatService, ChatRepository],
  exports: [ChatService, ChatRepository],
})
export class ChatModule {}
