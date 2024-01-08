import mongoose from "mongoose";
import MessageModel from "./message.model.js";
import MemberModel from "./member.js";

const ChatScheme = new mongoose.Schema(
  {
    name: { type: String, required: true },
    profile: { type: String, default: null },
    members: [{ type: mongoose.Types.ObjectId, ref: MemberModel }],
    lastMessage: {
      type: mongoose.Types.ObjectId,
      ref: MessageModel,
      default: null,
    },
    group: { type: Boolean, default: false },
    theme: { type: String, default: null },
  },
  { timestamps: true }
);

const ChatModel = mongoose.model("Chat", ChatScheme);

export default ChatModel;
