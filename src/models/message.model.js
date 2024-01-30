import mongoose from "mongoose";

const MessageSchema = new mongoose.Schema(
  {
    chat: { type: mongoose.Types.ObjectId, ref: "Chat", required: true },
    sender: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    content: { type: String, required: true },
    contentType: {
      type: String,
      enum: ["text", "image", "audio", "video", "link"],
      default: "text",
    },
    reactions: [
      {
        type: new mongoose.Schema(
          {
            reaction: { type: String, required: true },
            user: {
              type: mongoose.Types.ObjectId,
              ref: "User",
              required: true,
            },
          },
          { timestamps: true }
        ),
      },
    ],
    repliedTo: {
      type: mongoose.Types.ObjectId,
      ref: "Message",
      default: null,
    },
    pinned: { type: Boolean, default: false },
  },
  { timestamps: true }
);

const MessageModel = mongoose.model("Message", MessageSchema);

export default MessageModel;
