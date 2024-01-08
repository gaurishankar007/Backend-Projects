import mongoose from "mongoose";
import UserModel from "./user.model.js";
import MessageModel from "./message.model.js";

const ReactionSchema = new mongoose.Schema(
  {
    reaction: { type: String, required: true },
    message: {
      type: mongoose.Types.ObjectId,
      ref: MessageModel,
      required: true,
    },
    user: { type: mongoose.Types.ObjectId, ref: UserModel, required: true },
  },
  { timestamps: true }
);

const ReactionModel = mongoose.model("Reaction", ReactionSchema);

export default ReactionModel;
