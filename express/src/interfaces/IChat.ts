import mongoose, { Document } from "mongoose";

export interface IChat extends Document {
  members: Array<mongoose.Types.ObjectId>;
  name: string;
  profile: string;
  lastMessage: mongoose.Types.ObjectId;
  group: boolean;
  creator: mongoose.Types.ObjectId;
  createdAt: Date;
  updatedAt: Date;
}
