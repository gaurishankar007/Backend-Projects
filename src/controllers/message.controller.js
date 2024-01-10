import asyncHandler from "express-async-handler";
import MessageModel from "../models/message.model.js";
import ChatModel from "../models/chat.model.js";
import messageValidator from "../core/validators/message.validator.js";
import { errorRes, successRes } from "../core/utils/response.js";

const MessageController = {
  sendText: asyncHandler(async (req, res) => {
    const error = messageValidator.sendText(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    
    const { chatId, content } = req.body;
    const user = req.user;

    const message = await MessageModel.create({
      chat: chatId,
      sender: user._id,
      content: content,
    });

    const chat = await ChatModel.findOneAndUpdate(
      { _id: chatId },
      { lastMessage: message }
    );

    if (chat === null) {
      await MessageModel.deleteOne({ _id: message._id });
      return errorRes(res, "Chat with that id does not exist");
    }

    const data = { message, chat };
    successRes(res, data);
  }),
};

export default MessageController;
