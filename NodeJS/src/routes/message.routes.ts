import express from "express";
import messageController from "../controllers/message.controller.js";
import authMiddleWare from "../core/middleware/auth.middleware.js";
import audioMiddleware from "../core/uploads/audio.upload.js";
import imageMiddleware from "../core/uploads/image.upload.js";
import videoMiddleware from "../core/uploads/video.upload.js";

const messageRouter = express.Router();

messageRouter.post("/text", authMiddleWare, messageController.text);
messageRouter.post("/replyText", authMiddleWare, messageController.replyText);
messageRouter.post(
  "/image",
  authMiddleWare,
  imageMiddleware,
  messageController.file
);
messageRouter.post(
  "/replyImage",
  authMiddleWare,
  imageMiddleware,
  messageController.replyFile
);
messageRouter.post(
  "/audio",
  authMiddleWare,
  audioMiddleware,
  messageController.file
);
messageRouter.post(
  "/replyAudio",
  authMiddleWare,
  audioMiddleware,
  messageController.replyFile
);
messageRouter.post(
  "/video",
  authMiddleWare,
  videoMiddleware,
  messageController.file
);
messageRouter.post(
  "/replyVideo",
  authMiddleWare,
  videoMiddleware,
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
