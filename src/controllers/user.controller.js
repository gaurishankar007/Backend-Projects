import asyncHandler from "express-async-handler";
import UserModel from "../models/user.model.js";
import authValidator from "../core/validators/auth.validator.js";
import { errorRes, successRes } from "../core/utils/response.js";
import hashHandler from "../core/utils/hash_handler.js";
import tokenHandler from "../core/utils/token_handler.js";

const userController = {
  register: asyncHandler(async (req, res) => {
    const error = authValidator.register(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { firstName, lastName, email, password } = req.body;
    const hashedPW = await hashHandler.has(password);

    const user = await UserModel.findOne({ email: email });
    if (user != null) {
      return errorRes(res, "User already exist with that email");
    }

    const newUser = await UserModel.create({
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: hashedPW,
    });

    newUser.password = undefined;

    const token = tokenHandler.generateToken({ id: newUser._id });
    const refresh = tokenHandler.generateRefreshToken({ id: newUser._id });
    const data = { user: newUser, accessToken: token, refreshToken: refresh };

    successRes(res, data, "User created");
  }),
  login: asyncHandler(async (req, res) => {
    const error = authValidator.login(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { email, password } = req.body;
    const user = await UserModel.findOne({ email: email });
    const errorMsg = "User credential did not matched";
    if (user == null) return errorRes(res, errorMsg);

    const pWValid = await hashHandler.compare(password, user.password);
    if (!pWValid) return errorRes(res, errorMsg);
    user.password = undefined;

    const token = tokenHandler.generateToken({ id: user._id });
    const refresh = tokenHandler.generateRefreshToken({ id: user._id });
    const data = { user: user, accessToken: token, refreshToken: refresh };

    successRes(res, data);
  }),
  refreshToken: asyncHandler(async (req, res) => {
    const refreshToken = req.body.refreshToken;
    if (!refreshToken || refreshToken === "") {
      return errorRes(res, "Refresh token is required");
    }

    try {
      const { id, type } = tokenHandler.verifyToken(refreshToken);
      if (type !== "refresh") {
        return errorRes(res, "Invalid refresh token", undefined, 401);
      }

      const user = await UserModel.findOne({ _id: id }, "-password");
      if (user == null) {
        return errorRes(res, "Invalid refresh token", undefined, 401);
      }

      const accessToken = tokenHandler.generateToken({ id: id });
      const newRefreshToken = tokenHandler.generateRefreshToken({ id: id });
      const data = { accessToken, refreshToken: newRefreshToken };

      successRes(res, data);
    } catch (error) {
      errorRes(res, "Refresh token has been expired", undefined, 401);
    }
  }),
  changeProfile: asyncHandler(async (req, res) => {
    const file = req.file;

    const user = await UserModel.findOneAndUpdate(
      { _id: req.user._id },
      { profilePic: file.filename }
    );
    successRes(res, user);
  }),
};

export default userController;
