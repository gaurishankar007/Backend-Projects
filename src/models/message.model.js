import mongoose from "mongoose";
import UserModel from "./user.model.js";
import ChatModel from "./chat.model.js";
import ReactionModel from "./reaction.model.js";

const MessageSchema = new mongoose.Schema(
  {
    content: { type: String, required: true },
    sender: { type: mongoose.Types.ObjectId, ref: UserModel, required: true },
    chat: { type: mongoose.Types.ObjectId, ref: ChatModel, required: true },
    contentType: {
      type: String,
      enum: ["text", "image", "audio", "video", "link", "activity"],
      default: "text",
      required: true,
    },
    reaction: [{ type: mongoose.Types.ObjectId, ref: ReactionModel }],
    repliedTo: {
      type: mongoose.Types.ObjectId,
      ref: MessageModel,
      default: null,
    },
    pinned: { type: Boolean, default: false },
  },
  { timestamps: true }
);

const MessageModel = mongoose.model("Message", MessageSchema);

export default MessageModel;
