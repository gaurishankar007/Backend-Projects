import express from "express";
import memberController from "../controllers/member.controller.js";
import authMiddleware from "../core/middleware/auth.middleware.js";

const memberRouter = express.Router();

memberRouter.put("/add", authMiddleware, memberController.add);
memberRouter.delete("/remove", authMiddleware, memberController.remove);

export default memberRouter;
