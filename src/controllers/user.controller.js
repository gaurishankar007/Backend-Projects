import asyncHandler from "express-async-handler";
import hashHandler from "../core/utils/hash.handler.js";
import { errorResponse, successResponse } from "../core/utils/response.js";
import tokenHandler from "../core/utils/token.handler.js";
import authValidator from "../core/validators/auth.validator.js";
import UserModel from "../models/user.model.js";

const userController = {
  register: asyncHandler(async (req, res) => {
    const error = authValidator.register(req.body);
    if (error) return errorResponse(res, error);

    const { name, email, password } = req.body;
    const hashedPW = await hashHandler.has(password);

    const user = await UserModel.findOne({ email: email });
    if (user != null) {
      return errorResponse(res, "User already exist with that email");
    }

    const newUser = await UserModel.create({
      name: name,
      email: email,
      password: hashedPW,
    });

    newUser.password = undefined;

    const token = tokenHandler.generateToken({ id: newUser._id });
    const refresh = tokenHandler.generateRefreshToken({ id: newUser._id });
    const data = { user: newUser, accessToken: token, refreshToken: refresh };

    successResponse(res, data);
  }),
  login: asyncHandler(async (req, res) => {
    const error = authValidator.login(req.body);
    if (error) return errorResponse(res, error);

    const { email, password } = req.body;
    const user = await UserModel.findOne({ email: email });
    const errorMsg = "User credential did not match";
    if (user === null) return errorResponse(res, errorMsg, undefined, 401);

    const pWValid = await hashHandler.compare(password, user.password);
    if (!pWValid) return errorResponse(res, errorMsg, undefined, 401);
    user.password = undefined;

    const token = tokenHandler.generateToken({ id: user._id });
    const refresh = tokenHandler.generateRefreshToken({ id: user._id });
    const data = { user: user, accessToken: token, refreshToken: refresh };

    successResponse(res, data);
  }),
  refreshToken: asyncHandler(async (req, res) => {
    const refreshToken = req.body.refreshToken;
    if (!refreshToken || refreshToken === "")
      return errorResponse(res, "Refresh token is required");

    try {
      const { id, type } = tokenHandler.verifyToken(refreshToken);
      const errorMsg = "Invalid refresh token";
      if (type !== "refresh") return errorResponse(res, errorMsg, undefined, 401);

      const user = await UserModel.findOne({ _id: id }, "-password");
      if (user === null) return errorResponse(res, errorMsg, undefined, 401);

      const accessToken = tokenHandler.generateToken({ id: id });
      const newRefreshToken = tokenHandler.generateRefreshToken({ id: id });
      const data = { accessToken, refreshToken: newRefreshToken };

      successResponse(res, data);
    } catch (error) {
      errorResponse(res, "Refresh token has been expired", undefined, 401);
    }
  }),
  changeProfile: asyncHandler(async (req, res) => {
    const file = req.file;

    const user = await UserModel.findOneAndUpdate(
      { _id: req.user._id },
      { profile: file.filename }
    );

    successResponse(res, user);
  }),
  changePassword: asyncHandler(async (req, res) => {
    const error = authValidator.changePassword(req.body);
    if (error) return errorResponse(res, error);

    const { oldPassword, password } = req.body;
    const user = await UserModel.findOne({ _id: req.user._id });
    const isValidPW = await hashHandler.compare(oldPassword, user.password);
    if (!isValidPW) return errorResponse(res, "Old password did not matched");
    if (oldPassword === password)
      return errorResponse(res, "Same password can not be used");

    const hashedPW = await hashHandler.has(password);
    await UserModel.updateOne({ _id: req.user._id }, { password: hashedPW });

    successResponse(res, "Password changed");
  }),
  changeName: asyncHandler(async (req, res) => {
    const user = req.user;
    const name = req.body.name;
    if (!name || name.trim() === "") return errorResponse(res, "Name is required");

    await UserModel.updateOne({ _id: user._id }, { name: name });

    successResponse(res, "Name changed");
  }),
  search: asyncHandler(async (req, res) => {
    const name = req.body.name;
    if (!name || name.trim() === "") return errorResponse(res, "Name is required");

    const user = req.user;
    const users = await UserModel.find({
      _id: { $ne: user._id },
      name: { $regex: name, $options: "i" },
    });

    return successResponse(res, users);
  }),
};

export default userController;
