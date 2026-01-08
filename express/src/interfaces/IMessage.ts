import mongoose, { Document } from "mongoose";

export interface IMessage extends Document {
  chat: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  content: string;
  contentType: string;
  createdAt: Date;
  updatedAt: Date;
}
