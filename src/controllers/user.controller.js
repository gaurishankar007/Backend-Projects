import asyncHandler from "express-async-handler";
import requireValidator from "../core/validator/required.validator.js";
import { errorRes } from "../core/utils/response.js";
import UserModel from "../models/user.model.js";

const userController = {
  register: asyncHandler(async (req, res) => {
    console.log(req.body.length);
    const { firstName, lastName, email, password } = req.body;
    var map = { firstName, lastName, email, password };
   

    // if (validationError != undefined) {
    //   return errorRes(res, "Failure", validationError);
    // }

    // const user = UserModel.create();
    res.json({});
  }),
  login: asyncHandler(async (req, res) => {}),
};

export default userController;
