import { NextFunction, Request, Response } from "express";
import { ZodError, ZodObject } from "zod";
import { errorResponse } from "../utils/response.js";

export const validate =
  (schema: ZodObject<any>) =>
  async (req: Request, res: Response, next: NextFunction) => {
    try {
      await schema.parseAsync({
        body: req.body,
        query: req.query,
        params: req.params,
      });
      return next();
    } catch (error: any) {
      if (error instanceof ZodError) {
        // Zod v4 uses .issues? Or .errors? 'errors' was alias in v3.
        // If errors missing, try issues.
        const zodError = error as any;
        const msg =
          zodError.issues?.[0]?.message ||
          zodError.errors?.[0]?.message ||
          "Validation Error";
        return errorResponse(res, msg, undefined, 400);
      }
      return errorResponse(res, "Validation Error", undefined, 400);
    }
  };
