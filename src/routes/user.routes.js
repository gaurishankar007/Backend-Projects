import express from "express";
import userController from "../controllers/user.controller.js";
import profileUpload from "../core/uploads/profile.upload.js";

const userRouter = express.Router();

userRouter.post(
  "/register",
  profileUpload.single("profilePic"),
  userController.register
);

export default userRouter;
