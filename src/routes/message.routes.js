import express from "express";
import authMiddleWare from "../core/middleware/auth.middleware.js";
import MessageController from "../controllers/message.controller.js";

const messageRouter = express.Router();

messageRouter.post("/sendText", authMiddleWare, MessageController.sendText);

export default messageRouter;
