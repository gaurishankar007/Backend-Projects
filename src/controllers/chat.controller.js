import asyncHandler from "express-async-handler";
import { errorRes, successRes } from "../core/utils/response.js";
import ChatModel from "../models/chat.model.js";
import chatVdr from "../core/validators/chat.validator.js";
import "../models/message.model.js";
import MessageModel from "../models/message.model.js";

const chatController = {
  create: asyncHandler(async (req, res) => {
    const userId = req.body.userId;
    if (!userId || userId.trim() === "")
      return errorRes(res, "User id is required");

    const user = req.user;
    const members = [{ user: `${user._id}` }, { user: userId }];

    const chat = await ChatModel.create({ members: members });

    successRes(res, chat);
  }),
  createGroup: asyncHandler(async (req, res) => {
    const { userIds, name } = req.body;
    if (!userIds || userIds.length <= 1)
      return errorRes(res, "At least 2 users' id are required");

    const user = req.user;
    const members = [
      { user: `${user._id}`, admin: true },
      ...userIds.map(function (id) {
        return { user: id, addedBy: user };
      }),
    ];

    const chat = await ChatModel.create({
      members: members,
      name: name,
      group: true,
      creator: user,
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
    const user = req.user;
    const members = userIds.map(function (id) {
      return { user: id, addedBy: user.id };
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
