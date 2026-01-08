import mongoose from "mongoose";
import { IMessage } from "../interfaces/IMessage.js";

const MessageSchema = new mongoose.Schema(
  {
    chat: { type: mongoose.Types.ObjectId, ref: "Chat", required: true },
    user: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    content: { type: String, required: true },
    contentType: {
      type: String,
      enum: ["text", "url", "image", "audio", "video", "activity"],
      default: "text",
    },
  },
  { timestamps: true }
);

const MessageModel = mongoose.model<IMessage>("Message", MessageSchema);

export default MessageModel;
