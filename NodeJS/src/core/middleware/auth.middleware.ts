import { NextFunction, Request, Response } from "express";
import UserModel from "../../models/user.model.js";
import { errorResponse } from "../utils/response.js";
import tokenHandler from "../utils/token.handler.js";

interface AuthenticatedRequest extends Request {
  user?: any;
}

const authMiddleware = async (
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
) => {
  try {
    const authorization = req.headers.authorization;
    if (!authorization)
      return errorResponse(res, "Bearer token is not provided", undefined, 401);

    const [bearer, token] = authorization.split(" ");
    if (bearer !== "Bearer")
      return errorResponse(res, "Invalid bearer token", undefined, 401);

    const { id, type } = tokenHandler.verifyToken(token) as any;
    if (type !== "token")
      return errorResponse(res, "Invalid token", undefined, 401);

    const user = await UserModel.findOne({ _id: id }, "-password");
    if (user === null)
      return errorResponse(res, "Invalid token", undefined, 401);

    req.user = user;
    next();
  } catch (error) {
    errorResponse(res, "Token has been expired", undefined, 401);
  }
};

export default authMiddleware;
