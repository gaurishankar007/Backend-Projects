import { Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  email: string;
  profile: string;
  password?: string;
  refreshToken?: string;
  createdAt: Date;
  updatedAt: Date;
}
