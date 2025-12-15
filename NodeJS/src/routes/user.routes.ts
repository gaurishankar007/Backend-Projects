import { Router } from "express";
import { container } from "tsyringe";
import { UserController } from "../controllers/user.controller.js";
import authMiddleware from "../middleware/auth.middleware.js";
import { validate } from "../middleware/validate.middleware.js";
import profileMiddleware from "../uploads/profile.upload.js";
import {
  changeNameSchema,
  changePasswordSchema,
  loginSchema,
  registerSchema,
  requestRefreshTokenSchema,
  searchUserSchema,
} from "../validators/auth.schema.js";

class UserRoute {
  public readonly router: Router;

  constructor() {
    this.router = Router();
    this.initRoutes();
  }

  private initRoutes() {
    const userController = container.resolve(UserController);

    this.router.post(
      "/register",
      validate(registerSchema),
      userController.register.bind(userController)
    );
    this.router.post(
      "/login",
      validate(loginSchema),
      userController.login.bind(userController)
    );
    this.router.post(
      "/refreshToken",
      validate(requestRefreshTokenSchema),
      userController.refreshToken.bind(userController)
    );
    this.router.put(
      "/updateProfile",
      authMiddleware,
      profileMiddleware,
      userController.changeProfile.bind(userController)
    );
    this.router.put(
      "/changePassword",
      authMiddleware,
      validate(changePasswordSchema),
      userController.changePassword.bind(userController)
    );
    this.router.put(
      "/changeName",
      authMiddleware,
      validate(changeNameSchema),
      userController.changeName.bind(userController)
    );
    this.router.post(
      "/searchUser",
      authMiddleware,
      validate(searchUserSchema),
      userController.search.bind(userController)
    );
  }
}

export default new UserRoute().router;
