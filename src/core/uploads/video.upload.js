import multer from "multer";
import { publicDirectory } from "../utils/directory.js";
import { errorResponse } from "../utils/response.js";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, publicDirectory("/videos"));
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req, file, cb) => {
  const types = ["video/mp4", "video/mkv"];
  const fileSize = parseInt(req.headers["content-length"]);

  if (!types.includes(file.mimetype)) {
    cb(new multer.MulterError("LIMIT_UNEXPECTED_FILE"), false);
  } else if (fileSize > 100 * 1e6) {
    cb(new multer.MulterError("LIMIT_FILE_SIZE"), false);
  } else {
    cb(null, true);
  }
};

const videoMulter = multer({
  storage: storage,
  fileFilter: filter,
  limits: { fileSize: 100 * 1e6 },
}).single("video");

const videoUpload = (req, res, next) => {
  videoMulter(req, res, (error) => {
    if (error instanceof multer.MulterError) {
      if (error.code === "LIMIT_UNEXPECTED_FILE") {
        return errorResponse(res, "Unsupported video");
      } else if (error.code === "LIMIT_FILE_SIZE") {
        return errorResponse(res, "Unsupported video size");
      }
    }

    if (error) return errorResponse(res, error.message);
    if (!req.file) return errorResponse(res, "Video not provided");

    next();
  });
};

export default videoUpload;
