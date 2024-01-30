import express from "express";
import authMiddleWare from "../core/middleware/auth.middleware.js";
import messageController from "../controllers/message.controller.js";
import imageUpload from "../core/uploads/image.upload.js";
import audioUpload from "../core/uploads/audio.upload.js";
import videoUpload from "../core/uploads/video.upload.js";

const messageRouter = express.Router();

messageRouter.post("/text", authMiddleWare, messageController.text);
messageRouter.post("/replyText", authMiddleWare, messageController.replyText);
messageRouter.post(
  "/image",
  authMiddleWare,
  imageUpload,
  messageController.file
);
messageRouter.post(
  "/replyImage",
  authMiddleWare,
  imageUpload,
  messageController.replyFile
);
messageRouter.post(
  "/audio",
  authMiddleWare,
  audioUpload,
  messageController.file
);
messageRouter.post(
  "/replyAudio",
  authMiddleWare,
  audioUpload,
  messageController.replyFile
);
messageRouter.post(
  "/video",
  authMiddleWare,
  videoUpload,
  messageController.file
);
messageRouter.post(
  "/replyVideo",
  authMiddleWare,
  videoUpload,
  messageController.replyFile
);
messageRouter.put("/react", authMiddleWare, messageController.react);
messageRouter.delete(
  "/removeReaction",
  authMiddleWare,
  messageController.removeReaction
);
messageRouter.post("/fetch", authMiddleWare, messageController.fetch);

export default messageRouter;
