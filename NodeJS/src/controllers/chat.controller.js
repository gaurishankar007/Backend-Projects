import asyncHandler from "express-async-handler";
import { errorResponse, successResponse } from "../core/utils/response.js";
import chatValidator from "../core/validators/chat.validator.js";
import ChatModel from "../models/chat.model.js";
import "../models/message.model.js";

const chatController = {
  create: asyncHandler(async (req, res) => {
    const userId = req.body.userId;
    if (!userId || userId.trim() === "")
      return errorResponse(res, "User id is required");

    const user = req.user;
    const members = [{ user: `${user._id}` }, { user: userId }];

    const chat = await ChatModel.create({ members: members });

    successResponse(res, chat);
  }),
  createGroup: asyncHandler(async (req, res) => {
    const { userIds, name } = req.body;
    if (!userIds || userIds.length <= 1)
      return errorResponse(res, "At least 2 users' id are required");

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
    
    successResponse(res, chat);
  }),
  fetch: asyncHandler(async (req, res) => {
    const user = req.user;
    const page = req.body.page;
    if (!page) return errorResponse(res, "Page is required");
    if (!Number.isInteger(page)) return errorResponse(res, "Page must be integer");

    let chats = await ChatModel.find({
      members: { $elemMatch: { user: user._id } },
    })
      .sort({ createdAt: -1 })
      .skip((page - 1) * 10)
      .limit(10)
      .populate("members.user", "-password")
      .populate("lastMessage");

    successResponse(res, chats);
  }),
  addMember: asyncHandler(async (req, res) => {
    const error = chatValidator.addMember(req.body);
    if (error) return errorResponse(res, error);

    const { chatId, userIds } = req.body;
    const user = req.user;
    const members = userIds.map(function (id) {
      return { user: id, addedBy: user.id };
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $push: { members: members } }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, members);
  }),
  removeMember: asyncHandler(async (req, res) => {
    const error = chatValidator.removeMember(req.body);
    if (error) return errorResponse(res, error);

    const { chatId, userId } = req.body;

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { $pull: { members: { user: userId } } }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, "Member removed");
  }),
};

export default chatController;
