import { MulterError } from "multer";
import { errorRes } from "../utils/response.js";

const urlNotFound = (req, res, next) => {
  const error = Error(`Url Not Found: ${req.originalUrl}`);
  res.status(404);
  next(error);
};

const errorHandler = (error, req, res, next) => {
  console.log(error);

  const statusCode = res.statusCode == 200 ? 500 : res.statusCode;
  errorRes(res, error.message, undefined, statusCode);
};

export { urlNotFound, errorHandler };
