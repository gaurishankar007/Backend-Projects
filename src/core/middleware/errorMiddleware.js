import { errorRes } from "../utils/response.js";

const urlNotFound = (req, res, next) => {
  const error = Error(`Url Not Found: ${req.originalUrl}`);
  res.status(404);
  next(error);
};

const errorHandler = (error, req, res, next) => {
  const statusCode = res.statusCode;
  if (res.statusCode == 200) statusCode = 500;
  res.status(res, error.stack, error.message, statusCode);
};

export { urlNotFound, errorHandler };
