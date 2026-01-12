import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

export type UserDocument = HydratedDocument<User>;

@Schema({ timestamps: true })
export class User {
  @Prop({ required: true, index: true })
  name: string;

  @Prop({ required: true, unique: true })
  email: string;

  @Prop({ required: true, select: false }) // Hide password by default
  password: string;

  @Prop({
    default:
      'https://icon-library.com/images/anonymous-avatar-icon/anonymous-avatar-icon-25.jpg',
  })
  pic: string;
}

export const UserSchema = SchemaFactory.createForClass(User);
