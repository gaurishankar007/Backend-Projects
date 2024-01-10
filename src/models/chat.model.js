import mongoose from "mongoose";

const ChatScheme = new mongoose.Schema(
  {
    members: [{ type: mongoose.Types.ObjectId, ref: "Member" }],
    name: { type: String, default: null },
    profilePic: { type: String, default: null },
    lastMessage: {
      type: mongoose.Types.ObjectId,
      ref: "Message",
      default: null,
    },
    group: { type: Boolean, default: false },
    theme: { type: String, default: null },
  },
  { timestamps: true }
);

const ChatModel = mongoose.model("Chat", ChatScheme);

export default ChatModel;
