import asyncHandler from "express-async-handler";
import fs from "fs";
import { filePath } from "../core/utils/directory.js";
import { errorResponse, successResponse } from "../core/utils/response.js";
import msgVdr from "../core/validators/message.validator.js";
import ChatModel from "../models/chat.model.js";
import MessageModel from "../models/message.model.js";

const messageController = {
  text: asyncHandler(async (req, res) => {
    const error = msgVdr.text(req.body);
    if (error) return errorResponse(res, error);

    const { chatId, content, contentType } = req.body;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      user: user,
      content: content,
      contentType: contentType,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, message);
  }),
  replyText: asyncHandler(async (req, res) => {
    const error = msgVdr.replyText(req.body);
    if (error) return errorResponse(res, error);

    const { chatId, messageId, content, contentType } = req.body;
    const user = req.user;

    let message = await MessageModel.create({
      chat: chatId,
      user: user,
      content: content,
      contentType: contentType,
      repliedTo: messageId,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, message);
  }),
  file: asyncHandler(async (req, res) => {
    const file = req.file;
    const error = msgVdr.file(req.body);
    if (error) {
      if (file) fs.unlinkSync(filePath(file));
      return errorResponse(res, error);
    }

    const { chatId, contentType } = req.body;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      user: user,
      content: file.filename,
      contentType: contentType,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, message);
  }),
  replyFile: asyncHandler(async (req, res) => {
    const file = req.file;
    const error = msgVdr.replyFile(req.body);
    if (error) {
      if (file) fs.unlinkSync(filePath(file));
      return errorResponse(res, error);
    }

    const { chatId, messageId, contentType } = req.body;
    const user = req.user;

    let message = await MessageModel.create({
      chat: chatId,
      user: user._id,
      content: file.filename,
      contentType: contentType,
      repliedTo: messageId,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );
    if (chat === null) return errorResponse(res, "Invalid chat id");

    successResponse(res, message);
  }),
  react: asyncHandler(async (req, res) => {
    const error = msgVdr.react(req.body);
    if (error) return errorResponse(res, error);

    const { reaction, messageId } = req.body;
    const user = req.user;
    const reactionScheme = { reaction: reaction, user: user };

    const message = await MessageModel.findOneAndUpdate(
      { _id: messageId },
      { $push: { reactions: reactionScheme } }
    );
    if (message === null) return errorResponse(res, "Invalid message id");

    successResponse(res, message);
  }),
  removeReaction: asyncHandler(async (req, res) => {
    const error = msgVdr.removeReaction(req.body);
    if (error) return errorResponse(res, error);

    const { reactionId, messageId } = req.body;

    const message = await MessageModel.findOneAndUpdate(
      { _id: messageId },
      { $pull: { reactions: { _id: reactionId } } }
    );
    if (message === null) return errorResponse(res, "Invalid message id");

    successResponse(res, message);
  }),
  fetch: asyncHandler(async (req, res) => {
    const error = msgVdr.fetch(req.body);
    if (error) return errorResponse(res, error);

    const { chatId, page } = req.body;
    const messages = await MessageModel.find({ chat: chatId })
      .sort({ createdAt: -1 })
      .skip((page - 1) * 10)
      .limit(10)
      .populate("repliedTo");

    return successResponse(res, messages);
  }),
};

export default messageController;
