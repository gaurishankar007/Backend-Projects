import mongoose from "mongoose";
import { IChat } from "../interfaces/IChat.js";

const ChatScheme = new mongoose.Schema(
  {
    members: [
      {
        type: new mongoose.Schema(
          {
            user: { type: mongoose.Types.ObjectId, ref: "User" },
            nickName: { type: String, default: "" },
            addedBy: {
              type: mongoose.Types.ObjectId,
              ref: "User",
              default: null,
            },
            admin: { type: Boolean, default: false },
            seenMessage: {
              type: mongoose.Types.ObjectId,
              ref: "Message",
              default: null,
            },
          },
          { timestamps: true }
        ),
      },
    ],
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
    theme: { type: String, default: null },
  },
  { timestamps: true }
);

const ChatModel = mongoose.model<IChat>("Chat", ChatScheme);

export default ChatModel;
