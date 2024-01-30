import asyncHandler from "express-async-handler";
import { errorRes, successRes } from "../core/utils/response.js";
import ChatModel from "../models/chat.model.js";
import MemberModel from "../models/member.model.js";
import UserModel from "../models/user.model.js";
import chatVdr from "../core/validators/chat.validator.js";
import "../models/message.model.js";

const chatController = {
  create: asyncHandler(async (req, res) => {
    const { userIds, name, group } = req.body;
    if (!userIds || userIds.length === 0)
      return errorRes(res, "Users id are required");

    const user = req.user;
    const members = [
      { user: `${user._id}`, superAdmin: true, admin: true },
      ...userIds.map(function (id) {
        return { user: id };
      }),
    ];

    let chat = await ChatModel.create({
      members: members,
      name: name,
      group: group,
    });

    successRes(res, chat);
  }),
  fetch: asyncHandler(async (req, res) => {
    const user = req.user;
    const page = req.body.page;
    if (!page) return errorRes(res, "Page is required");
    if (!Number.isInteger(page)) return errorRes(res, "Page must be integer");

    let chats = await ChatModel.find({
      members: { $elemMatch: { user: user._id } },
    })
      .sort({ createdAt: -1 })
      .skip((page - 1) * 10)
      .limit(10)
      .populate("members.user", "-password")
      .populate("lastMessage");

    successRes(res, chats);
  }),
  addMember: asyncHandler(async (req, res) => {
    const error = chatVdr.addMbr(req.body);
    if (error) return errorRes(res, error);

    const { chatId, userIds } = req.body;
    const members = userIds.map(function (id) {
      return { user: id };
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $push: { members: members } }
    );
    if (chat === null) return errorRes(res, "Invalid chat id");

    successRes(res, members);
  }),
  removeMember: asyncHandler(async (req, res) => {
    const error = chatVdr.removeMbr(req.body);
    if (error) return errorRes(res, error);

    const { chatId, userId } = req.body;

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $pull: { members: { user: userId } } }
    );
    if (chat === null) return errorRes(res, "Invalid chat id");

    successRes(res, "Member removed");
  }),
};

export default chatController;
