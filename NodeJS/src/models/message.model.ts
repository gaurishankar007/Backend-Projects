import mongoose, { Document } from "mongoose";

export interface IMessage extends Document {
  chat: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  content: string;
  contentType: string;
  reactions: Array<{
    reaction: string;
    user: mongoose.Types.ObjectId;
  }>;
  repliedTo: mongoose.Types.ObjectId;
  pinned: boolean;
  createdAt: Date;
  updatedAt: Date;
}

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

const MessageModel = mongoose.model<IMessage>("Message", MessageSchema);

export default MessageModel;
