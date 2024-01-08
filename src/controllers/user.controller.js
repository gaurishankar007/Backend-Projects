import asyncHandler from "express-async-handler";
import authValidator from "../core/validators/auth.validator.js";
import UserModel from "../models/user.model.js";
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

    const token = tokenHandler.generateToken({ id: newUser._id });
    const refresh = tokenHandler.generateRefreshToken({ id: newUser._id });
    const data = { user: newUser, accessToken: token, refreshToken: refresh };

    successRes(res, data, "User created", 201);
  }),
  login: asyncHandler(async (req, res) => {
    const error = authValidator.login(req.body);
    if (error) return errorRes(res, error, "Validation Error");

    const { email, password } = req.body;
    const user = await UserModel.findOne({ email: email });
    if (user == null) {
      return errorRes(res, "User credential did not matched");
    }

    const pWValid = await hashHandler.compare(password, user.password);
    if (!pWValid) {
      return errorRes(res, "User credential did not matched");
    }

    successRes(res, user);
  }),
};

export default userController;
