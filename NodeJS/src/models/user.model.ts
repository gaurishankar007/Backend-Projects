import mongoose, { Document } from "mongoose";

export interface IUser extends Document {
  name: string;
  email: string;
  profile: string;
  password?: string;
  createdAt: Date;
  updatedAt: Date;
}

const UserSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    email: { type: String, required: true },
    profile: { type: String, default: "user.png" },
    password: { type: String, required: true },
  },
  { timestamps: true }
);

const UserModel = mongoose.model<IUser>("User", UserSchema);

export default UserModel;
