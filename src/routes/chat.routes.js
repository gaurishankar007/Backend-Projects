import express from "express";
import authMiddleware from "../core/middleware/auth.middleware.js";
import chatController from "../controllers/chat.controller.js";

const chatRouter = express.Router();

chatRouter.post("/create", authMiddleware, chatController.create);
chatRouter.post("/createGroup", authMiddleware, chatController.createGroup);
chatRouter.get("/fetch", authMiddleware, chatController.fetch);
chatRouter.put("/addMember", authMiddleware, chatController.addMember);
chatRouter.delete("/removeMember", authMiddleware, chatController.removeMember);

export default chatRouter;
