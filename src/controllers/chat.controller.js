import asyncHandler from "express-async-handler";
import { errorRes, successRes } from "../core/utils/response.js";
import ChatModel from "../models/chat.model.js";
import MemberModel from "../models/member.model.js";
import UserModel from "../models/user.model.js";
import "../models/message.model.js";

const chatController = {
  fetch: asyncHandler(async (req, res) => {
    const user = req.user;

    const members = await MemberModel.find({ user: user._id });
    let chats = await ChatModel.find({
      members: { $elemMatch: { $in: members } },
    })
      .populate("members")
      .populate("lastMessage");

    chats = await UserModel.populate(chats, [
      { path: "members.user", select: "-password" },
      { path: "lastMessage.sender", select: "-password" },
    ]);

    successRes(res, chats);
  }),
  create: asyncHandler(async (req, res) => {
    const { userIds, group } = req.body;
    if (!userIds || userIds.length === 0) {
      return errorRes(res, "Users id are required");
    }

    const user = req.user;
    const users = [
      { user: `${user._id}`, groupCreator: true, admin: true },
      ...userIds.map(function (id) {
        return { user: id };
      }),
    ];

    const members = await MemberModel.create(users);
    let chat = await ChatModel.create({
      members: members,
      group: group,
      creator: user._id,
    });

    chat = await UserModel.populate(chat, [
      { path: "members.user", select: "-password" },
      { path: "lastMessage.sender", select: "-password" },
    ]);

    successRes(res, chat);
  }),
};

export default chatController;
