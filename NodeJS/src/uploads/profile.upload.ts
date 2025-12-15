import multer from "multer";
import { publicDirectory } from "../utils/directory.js";
import { errorResponse } from "../utils/response.js";

const storage = multer.diskStorage({
  destination: (req: any, file: any, cb: any) => {
    cb(null, publicDirectory("/profiles"));
  },
  filename: (req: any, file: any, cb: any) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req: any, file: any, cb: any) => {
  const types = ["image/jpg", "image/jpeg", "image/png"];
  const fileSize = parseInt(req.headers["content-length"] as string);

  if (!types.includes(file.mimetype)) {
    cb(new multer.MulterError("LIMIT_UNEXPECTED_FILE"), false);
  } else if (fileSize > 10 * 1e6) {
    cb(new multer.MulterError("LIMIT_FILE_SIZE"), false);
  } else {
    cb(null, true);
  }
};

const profileMulter = multer({
  storage: storage,
  fileFilter: filter,
  limits: { fileSize: 10 * 1e6 },
}).single("profile");

const profileMiddleware = (req: any, res: any, next: any) =>
  profileMulter(req, res, (error: any) => {
    if (error instanceof multer.MulterError) {
      if (error.code === "LIMIT_UNEXPECTED_FILE") {
        return errorResponse(res, "Unsupported image");
      } else if (error.code === "LIMIT_FILE_SIZE") {
        return errorResponse(res, "Unsupported image size");
      }
    }

    if (error) return errorResponse(res, error.message);
    if (!req.file) return errorResponse(res, "Image not provided");

    next();
  });

export default profileMiddleware;
