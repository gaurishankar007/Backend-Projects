import asyncHandler from "express-async-handler";
import MessageModel from "../models/message.model.js";
import ReactionModel from "../models/reaction.model.js";
import UserModel from "../models/user.model.js";
import reactionValidator from "../core/validators/reaction.validator.js";
import { errorRes, successRes } from "../core/utils/response.js";

const reactionController = {
  add: asyncHandler(async (req, res) => {
    const error = reactionValidator.add(req.body);
    if (error) return errorRes(res, error);

    const { reaction, messageId } = req.body;
    const user = req.user;

    const reactionModel = await ReactionModel.create({
      reaction: reaction,
      user: user._id,
      message: messageId,
    });

    let message = await MessageModel.findOneAndUpdate(
      { _id: messageId },
      { $push: { reactions: reactionModel } }
    );

    if (message === null) {
      await ReactionModel.deleteOne({ _id: reactionModel._id });
      return errorRes(res, "Invalid message id");
    }

    let updatedMessage = await MessageModel.findOne({
      _id: messageId,
    })
      .populate("repliedTo")
      .populate("reactions");

    updatedMessage = await UserModel.populate(updatedMessage, {
      path: "reactions.user",
      select: "-password",
    });

    successRes(res, updatedMessage);
  }),
  remove: asyncHandler(async (req, res) => {
    const error = reactionValidator.remove(req.body);
    if (error) return errorRes(res, error);

    const { reactionId, messageId } = req.body;
    const user = req.user;

    const reaction = await ReactionModel.findOneAndDelete({
      _id: reactionId,
      user: user._id,
      message: messageId,
    });
    if (reaction === null)
      return errorRes(res, "Invalid reaction data is provided");

    const message = await MessageModel.findOneAndUpdate(
      { _id: messageId },
      { $pull: { reactions: reactionId } }
    );
    if (message === null) return errorRes(res, "Invalid message id");

    let updatedMessage = await MessageModel.findOne({
      _id: messageId,
    })
      .populate("repliedTo")
      .populate("reactions");

    updatedMessage = await UserModel.populate(updatedMessage, {
      path: "reactions.user",
      select: "-password",
    });

    successRes(res, updatedMessage);
  }),
};

export default reactionController;
