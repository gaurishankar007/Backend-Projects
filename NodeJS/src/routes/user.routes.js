import express from "express";
import userController from "../controllers/user.controller.js";
import authMiddleware from "../core/middleware/auth.middleware.js";
import profileMiddleware from "../core/uploads/profile.upload.js";

const userRouter = express.Router();

userRouter.post("/register", userController.register);
userRouter.post("/login", userController.login);
userRouter.post("/refreshToken", userController.refreshToken);
userRouter.put(
  "/updateProfile",
  authMiddleware,
  profileMiddleware,
  userController.changeProfile
);
userRouter.put(
  "/changePassword",
  authMiddleware,
  userController.changePassword
);
userRouter.put("/changeName", authMiddleware, userController.changeName);
userRouter.post("/searchUser", authMiddleware, userController.search);

export default userRouter;
