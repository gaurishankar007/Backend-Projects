import express from "express";
import userController from "../controllers/user.controller.js";
import profileMiddleware from "../core/uploads/profile.upload.js";
import verifyUser from "../core/middleware/auth.middleware.js";

const userRouter = express.Router();

userRouter.post("/register", userController.register);
userRouter.post("/login", userController.login);
userRouter.put(
  "/changeProfile",
  verifyUser,
  profileMiddleware,
  userController.changeProfile
);

export default userRouter;
