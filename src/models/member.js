import mongoose from "mongoose";
import MessageModel from "./message.model.js";
import UserModel from "./user.model.js";
import ChatModel from "./chat.model.js";

const MemberSchema = new mongoose.Schema(
  {
    chat: { type: mongoose.Types.ObjectId, ref: ChatModel },
    user: { type: mongoose.Types.ObjectId, ref: UserModel },
    addedBy: { type: mongoose.Types.ObjectId, ref: UserModel },
    admin: { type: Boolean, default: false },
    groupCreator: { type: Boolean, default: false },
    lastSeenMessage: { type: mongoose.Types.ObjectId, ref: MessageModel },
  },
  { timestamps: true }
);
 
const MemberModel = mongoose.model("Member", MemberSchema);

export default MemberModel;
