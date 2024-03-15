import { errorResponse } from "../utils/response.js";

const urlNotFound = (req, res, next) => {
  const error = Error(`Url Not Found: ${req.originalUrl}`);
  res.status(404);
  next(error);
};

const errorHandler = (error, req, res, next) => {
  console.log(error);

  const statusCode = res.statusCode == 200 ? 500 : res.statusCode;
  errorResponse(res, error.message, undefined, statusCode);
};

export { errorHandler, urlNotFound };

