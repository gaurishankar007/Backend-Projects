import express from "express";
import authMiddleWare from "../core/middleware/auth.middleware.js";
import reactionController from "../controllers/reaction.controller.js";

const reactionRouter = express.Router();

reactionRouter.put("/add", authMiddleWare, reactionController.add);
reactionRouter.delete("/remove", authMiddleWare, reactionController.remove);

export default reactionRouter;
