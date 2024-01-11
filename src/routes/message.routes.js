import express from "express";
import authMiddleWare from "../core/middleware/auth.middleware.js";
import MessageController from "../controllers/message.controller.js";
import imageUpload from "../core/uploads/image.upload.js";
import audioUpload from "../core/uploads/audio.upload.js";
import videoUpload from "../core/uploads/video.upload.js";

const messageRouter = express.Router();

messageRouter.post("/text", authMiddleWare, MessageController.text);
messageRouter.post("/replyText", authMiddleWare, MessageController.replyText);
messageRouter.post(
  "/image",
  authMiddleWare,
  imageUpload,
  MessageController.file
);
messageRouter.post(
  "/replyImage",
  authMiddleWare,
  imageUpload,
  MessageController.replyFile
);
messageRouter.post(
  "/audio",
  authMiddleWare,
  audioUpload,
  MessageController.file
);
messageRouter.post(
  "/replyAudio",
  authMiddleWare,
  audioUpload,
  MessageController.replyFile
);
messageRouter.post(
  "/video",
  authMiddleWare,
  videoUpload,
  MessageController.file
);
messageRouter.post(
  "/replyVideo",
  authMiddleWare,
  videoUpload,
  MessageController.replyFile
);

export default messageRouter;
