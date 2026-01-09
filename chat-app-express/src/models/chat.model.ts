import mongoose from "mongoose";
import { IChat } from "../interfaces/IChat.js";

const ChatScheme = new mongoose.Schema(
  {
    members: [{ type: mongoose.Types.ObjectId, ref: "User" }],
    name: { type: String, default: null },
    profile: { type: String, default: null },
    lastMessage: {
      type: mongoose.Types.ObjectId,
      ref: "Message",
      default: null,
    },
    group: { type: Boolean, default: false },
    creator: {
      type: mongoose.Types.ObjectId,
      ref: "User",
      default: null,
    },
  },
  { timestamps: true }
);

const ChatModel = mongoose.model<IChat>("Chat", ChatScheme);

export default ChatModel;
