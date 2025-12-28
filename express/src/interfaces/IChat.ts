import mongoose, { Document } from "mongoose";

export interface IChat extends Document {
  members: Array<{
    user: mongoose.Types.ObjectId;
    nickName: string;
    addedBy: mongoose.Types.ObjectId;
    admin: boolean;
    seenMessage: mongoose.Types.ObjectId;
  }>;
  name: string;
  profile: string;
  lastMessage: mongoose.Types.ObjectId;
  group: boolean;
  creator: mongoose.Types.ObjectId;
  theme: string;
  createdAt: Date;
  updatedAt: Date;
}
