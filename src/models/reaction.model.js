import mongoose from "mongoose";

const ReactionSchema = new mongoose.Schema(
  {
    reaction: { type: String, required: true },
    user: { type: mongoose.Types.ObjectId, ref: "User", required: true },
    message: { type: mongoose.Types.ObjectId, ref: "Message", required: true },
  },
  { timestamps: true }
);

const ReactionModel = mongoose.model("Reaction", ReactionSchema);

export default ReactionModel;
