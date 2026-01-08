import { NextFunction, Request, Response } from "express";
import { errorResponse } from "../utils/response.js";

class ErrorHandler {
  static notFound(_: Request, res: Response, __: NextFunction) {
    errorResponse(res, `Resources not found`, undefined, 404);
  }

  static serverError(error: any, _: Request, res: Response, __: NextFunction) {
    errorResponse(
      res,
      error.message || "Internal Server Error",
      undefined,
      500
    );
  }
}

export default ErrorHandler;
