import { NextFunction, Request, Response } from "express";
import { errorResponse } from "../utils/response.js";

const urlNotFound = (req: Request, res: Response, next: NextFunction) => {
  errorResponse(res, `Url '${req.originalUrl}' not found`, undefined, 404);
};

const errorHandler = (
  error: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  errorResponse(res, error.message || "Internal Server Error", undefined, 500);
};

export { errorHandler, urlNotFound };
