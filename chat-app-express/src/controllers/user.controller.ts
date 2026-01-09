import { inject, injectable } from "tsyringe";
import { UserService } from "../services/user.service.js";
import { errorResponse, successResponse } from "../utils/response.js";
import {
  generateRefreshToken,
  generateToken,
  verifyToken,
} from "../utils/token.js";

@injectable()
export class UserController {
  constructor(@inject(UserService) private readonly userService: UserService) {}

  async register(req: any, res: any) {
    try {
      const user = await this.userService.register(req.body);
      successResponse(res, user);
    } catch (err: any) {
      if (err.code === 11000) {
        errorResponse(res, "Email already exists", undefined, 409);
      } else {
        errorResponse(res, err.message);
      }
    }
  }

  async login(req: any, res: any) {
    const { email, password } = req.body;
    try {
      const user = await this.userService.login(email, password);

      const accessToken = generateToken({ _id: user._id });
      const refreshToken = generateRefreshToken({ _id: user._id });

      user.refreshToken = refreshToken;
      await user.save();

      successResponse(res, { user, accessToken, refreshToken });
    } catch (err: any) {
      errorResponse(res, err.message, undefined, 401);
    }
  }

  async refreshToken(req: any, res: any) {
    const { refreshToken } = req.body;
    try {
      const decoded = verifyToken(refreshToken);
      const user = await this.userService.findById(decoded._id);
      if (!user) return errorResponse(res, "User not found");

      const accessToken = generateToken({ _id: user._id });
      successResponse(res, { accessToken });
    } catch (err: any) {
      errorResponse(res, "Invalid refresh token");
    }
  }

  async changeProfile(req: any, res: any) {
    const file = req.file;
    if (!file) return errorResponse(res, "Profile image required");

    try {
      const user = await this.userService.update(req.user._id, {
        profile: file.filename,
      });
      successResponse(res, user);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async changePassword(req: any, res: any) {
    const { oldPassword, password } = req.body;
    try {
      const user = await this.userService.changePassword(
        req.user._id,
        oldPassword,
        password
      );
      successResponse(res, user);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async changeName(req: any, res: any) {
    const { name } = req.body;

    try {
      const user = await this.userService.update(req.user._id, { name });
      successResponse(res, user);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }

  async search(req: any, res: any) {
    // Validation handled by Zod on body.name or query.query
    const query = (req.query.query as string) || req.body.name;

    try {
      const users = await this.userService.searchUsers(
        query as string,
        req.user._id
      );
      successResponse(res, users);
    } catch (err: any) {
      errorResponse(res, err.message);
    }
  }
}
