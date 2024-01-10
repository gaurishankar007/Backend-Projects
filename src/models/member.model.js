import mongoose from "mongoose";

const MemberSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Types.ObjectId, ref: "User" },
    admin: { type: Boolean, default: false },
    groupCreator: { type: Boolean, default: false },
    lastSeenMessage: {
      type: mongoose.Types.ObjectId,
      ref: "Message",
      default: null,
    },
  },
  { timestamps: true }
);

const MemberModel = mongoose.model("Member", MemberSchema);

export default MemberModel;
