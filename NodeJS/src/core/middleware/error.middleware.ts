import { NextFunction, Request, Response } from "express";
import { errorResponse } from "../utils/response.js";

const urlNotFound = (req: Request, res: Response, next: NextFunction) => {
  const error = Error(`Url Not Found: ${req.originalUrl}`);
  res.status(404);
  next(error);
};

const errorHandler = (
  error: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  console.log(error);

  const statusCode = res.statusCode == 200 ? 500 : res.statusCode;
  errorResponse(res, error.message, undefined, statusCode);
};

export { errorHandler, urlNotFound };
