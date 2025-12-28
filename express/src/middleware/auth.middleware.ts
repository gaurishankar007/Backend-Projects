import { NextFunction, Request, Response } from "express";
import UserModel from "../models/user.model.js";
import { errorResponse } from "../utils/response.js";
import { verifyToken } from "../utils/token.js";

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

    const decoded = verifyToken(token);
    // @ts-ignore
    const user = await UserModel.findById(decoded._id).select("-password -__v");

    if (!user) return errorResponse(res, "Unauthorized", undefined, 401);

    // @ts-ignore
    req.user = user;
    next();
  } catch (error) {
    return errorResponse(res, "Unauthorized", undefined, 401);
  }
};

export default authMiddleware;
