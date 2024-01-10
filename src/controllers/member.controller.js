import asyncHandler from "express-async-handler";
import { errorRes, successRes } from "../core/utils/response.js";
import ChatModel from "../models/chat.model.js";
import MemberModel from "../models/member.model.js";
import UserModel from "../models/user.model.js";

const memberController = {
  add: asyncHandler(async (req, res) => {
    const { chatId, userIds } = req.body;
    if (!chatId || chatId === "") return errorRes(res, "Chat id is required");
    if (!userIds || userIds.length === 0) {
      return errorRes(res, "Users id are required");
    }

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
      return errorRes(res, "Chat with that id does not exist");
    }

    members = await UserModel.populate(members, {
      path: "user",
      select: "-password",
    });

    successRes(res, members);
  }),
  remove: asyncHandler(async (req, res) => {
    const memberId = req.body.memberId;
    if (!memberId || memberId === "") {
      return errorRes(res, "Member id is required");
    }

    const member = await MemberModel.findOneAndDelete({ _id: memberId });
    if (member === null) {
      errorRes(res, "Member with that id does not exist");
    }

    successRes(res, "Member removed");
  }),
};

export default memberController;
