import express from "express";
import userController from "../controllers/user.controller.js";
import profileUpload from "../core/uploads/profile.upload.js";
import registerValidator from "../core/validators/auth.validator.js";

const userRouter = express.Router();

userRouter.post("/register", userController.register);
userRouter.post("/login", userController.login);

export default userRouter;
