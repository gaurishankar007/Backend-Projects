import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as MongooseSchema, Types } from 'mongoose';
import { Chat } from '../../chat/schemas/chat.schema';
import { User } from '../../user/schemas/user.schema';

export type MessageDocument = HydratedDocument<Message>;

@Schema({ timestamps: true })
export class Message {
  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'User', index: true })
  sender: User | Types.ObjectId;

  @Prop({ trim: true })
  content: string;

  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'Chat', index: true })
  chat: Chat | Types.ObjectId;

  @Prop({ default: 'text' })
  contentType: string;
}

export const MessageSchema = SchemaFactory.createForClass(Message);
