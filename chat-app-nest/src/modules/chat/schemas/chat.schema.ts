import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument, Schema as MongooseSchema, Types } from 'mongoose';
import { Message } from '../../message/schemas/message.schema';
import { User } from '../../user/schemas/user.schema';

export type ChatDocument = HydratedDocument<Chat>;

@Schema({ timestamps: true })
export class Chat {
  @Prop({ trim: true })
  chatName: string;

  @Prop({ default: false })
  isGroupChat: boolean;

  @Prop({
    type: [{ type: MongooseSchema.Types.ObjectId, ref: 'User' }],
    index: true,
  })
  users: (User | Types.ObjectId)[];

  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'Message', index: true })
  latestMessage: Message | Types.ObjectId;

  @Prop({ type: MongooseSchema.Types.ObjectId, ref: 'User' })
  groupAdmin: User | Types.ObjectId;

  @Prop({
    default:
      'https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg',
  })
  groupPic: string;
}

export const ChatSchema = SchemaFactory.createForClass(Chat);
