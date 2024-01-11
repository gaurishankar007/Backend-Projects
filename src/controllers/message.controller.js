import asyncHandler from "express-async-handler";
import MessageModel from "../models/message.model.js";
import ChatModel from "../models/chat.model.js";
import messageValidator from "../core/validators/message.validator.js";
import { errorRes, successRes } from "../core/utils/response.js";

const MessageController = {
  text: asyncHandler(async (req, res) => {
    const error = messageValidator.text(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, content, contentType } = req.body;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      sender: user._id,
      content: content,
      contentType: contentType,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );

    const data = { message, chat };
    successRes(res, data);
  }),
  replyText: asyncHandler(async (req, res) => {
    const error = messageValidator.replyText(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, messageId, content, contentType } = req.body;
    const user = req.user;

    await MessageModel.deleteMany();

    const message = await MessageModel.create({
      chat: chatId,
      sender: user._id,
      content: content,
      contentType: contentType,
      repliedTo: messageId,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );

    const data = { message, chat };
    successRes(res, data);
  }),
  file: asyncHandler(async (req, res) => {
    const file = req.file;
    const error = messageValidator.file(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, contentType } = req.body;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      sender: user._id,
      content: file.filename,
      contentType: contentType,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );

    const data = { message, chat };
    successRes(res, data);
  }),
  replyFile: asyncHandler(async (req, res) => {
    const error = messageValidator.replyFile(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { chatId, messageId, contentType } = req.body;
    const file = req.file;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      sender: user._id,
      content: file.filename,
      contentType: contentType,
      repliedTo: messageId,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );

    const data = { message, chat };
    successRes(res, data);
  }),
};

export default MessageController;
