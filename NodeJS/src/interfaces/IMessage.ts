import mongoose, { Document } from "mongoose";

export interface IMessage extends Document {
  chat: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  content: string;
  contentType: string;
  reactions: Array<{
    reaction: string;
    user: mongoose.Types.ObjectId;
  }>;
  repliedTo: mongoose.Types.ObjectId;
  pinned: boolean;
  createdAt: Date;
  updatedAt: Date;
}
