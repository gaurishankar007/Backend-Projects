import mongoose from "mongoose";

const ChatScheme = new mongoose.Schema(
  {
    members: [
      {
        type: new mongoose.Schema(
          {
            user: { type: mongoose.Types.ObjectId, ref: "User" },
            admin: { type: Boolean, default: false },
            superAdmin: { type: Boolean, default: false },
            lastSeenMessage: {
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
