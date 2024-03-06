import asyncHandler from "express-async-handler";
import UserModel from "../models/user.model.js";
import authValidator from "../core/validators/auth.validator.js";
import { errorRes, successRes } from "../core/utils/response.js";
import hashHandler from "../core/utils/hash.handler.js";
import tokenHandler from "../core/utils/token.handler.js";

const userController = {
  register: asyncHandler(async (req, res) => {
    const error = authValidator.register(req.body);
    if (error) return errorRes(res, error);

    const { name, email, password } = req.body;
    const hashedPW = await hashHandler.has(password);

    const user = await UserModel.findOne({ email: email });
    if (user != null) {
      return errorRes(res, "User already exist with that email");
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

    successRes(res, data);
  }),
  login: asyncHandler(async (req, res) => {
    const error = authValidator.login(req.body);
    if (error) return errorRes(res, error);

    const { email, password } = req.body;
    const user = await UserModel.findOne({ email: email });
    const errorMsg = "User credential did not match";
    if (user === null) return errorRes(res, errorMsg, undefined, 401);

    const pWValid = await hashHandler.compare(password, user.password);
    if (!pWValid) return errorRes(res, errorMsg, undefined, 401);
    user.password = undefined;

    const token = tokenHandler.generateToken({ id: user._id });
    const refresh = tokenHandler.generateRefreshToken({ id: user._id });
    const data = { user: user, accessToken: token, refreshToken: refresh };

    successRes(res, data);
  }),
  refreshToken: asyncHandler(async (req, res) => {
    const refreshToken = req.body.refreshToken;
    if (!refreshToken || refreshToken === "")
      return errorRes(res, "Refresh token is required");

    try {
      const { id, type } = tokenHandler.verifyToken(refreshToken);
      const errorMsg = "Invalid refresh token";
      if (type !== "refresh") return errorRes(res, errorMsg, undefined, 401);

      const user = await UserModel.findOne({ _id: id }, "-password");
      if (user === null) return errorRes(res, errorMsg, undefined, 401);

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
      { profile: file.filename }
    );

    successRes(res, user);
  }),
  changePassword: asyncHandler(async (req, res) => {
    const error = authValidator.changePassword(req.body);
    if (error) return errorRes(res, error);

    const { oldPassword, password } = req.body;
    const user = await UserModel.findOne({ _id: req.user._id });
    const isValidPW = await hashHandler.compare(oldPassword, user.password);
    if (!isValidPW) return errorRes(res, "Old password did not matched");
    if (oldPassword === password)
      return errorRes(res, "Same password can not be used");

    const hashedPW = await hashHandler.has(password);
    await UserModel.updateOne({ _id: req.user._id }, { password: hashedPW });

    successRes(res, "Password changed");
  }),
  changeName: asyncHandler(async (req, res) => {
    const user = req.user;
    const name = req.body.name;
    if (!name || name.trim() === "") return errorRes(res, "Name is required");

    await UserModel.updateOne({ _id: user._id }, { name: name });

    successRes(res, "Name changed");
  }),
  search: asyncHandler(async (req, res) => {
    const name = req.body.name;
    if (!name || name.trim() === "") return errorRes(res, "Name is required");

    const user = req.user;
    const users = await UserModel.find({
      _id: { $ne: user._id },
      name: { $regex: name, $options: "i" },
    });

    return successRes(res, users);
  }),
};

export default userController;
