import asyncHandler from "express-async-handler";
import { errorRes, successRes } from "../core/utils/response.js";
import ChatModel from "../models/chat.model.js";
import MemberModel from "../models/member.model.js";
import UserModel from "../models/user.model.js";
import memberValidator from "../core/validators/member.validator.js";

const memberController = {
  add: asyncHandler(async (req, res) => {
    const error = memberValidator.add(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, userIds } = req.body;
    const user = req.user;
    const users = userIds.map(function (id) {
      return { user: id, addedBy: `${user._id}` };
    });

    let members = await MemberModel.create(users);
    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $push: { members: members } }
    );

    if (chat === null) {
      const memberIds = members.map((member) => member._id);
      await MemberModel.deleteMany({ _id: { $in: memberIds } });
      return errorRes(res, "Invalid chat id");
    }

    members = await UserModel.populate(members, {
      path: "user",
      select: "-password",
    });

    successRes(res, members);
  }),
  remove: asyncHandler(async (req, res) => {
    const error = memberValidator.remove(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, memberId } = req.body;

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $pull: { members: memberId } }
    );
    if (chat === null) return errorRes(res, "Invalid chat id");

    const member = await MemberModel.findOneAndDelete({ _id: memberId });
    if (member === null) return errorRes(res, "Invalid member id");

    successRes(res, "Member removed");
  }),
};

export default memberController;
