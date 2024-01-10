import express from "express";
import authMiddleware from "../core/middleware/auth.middleware.js";
import chatController from "../controllers/chat.controller.js";

const chatRouter = express.Router();

chatRouter.get("/fetch", authMiddleware, chatController.fetch);
chatRouter.post("/create", authMiddleware, chatController.create);

export default chatRouter;
