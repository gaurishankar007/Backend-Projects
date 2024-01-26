import multer from "multer";
import { errorRes } from "../utils/response.js";
import { publicDirectory } from "../utils/directory.js";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, publicDirectory("/profiles"));
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req, file, cb) => {
  const types = ["image/jpg", "image/jpeg", "image/png"];
  const fileSize = parseInt(req.headers["content-length"]);

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
}).single("profilePic");

const profileUpload = (req, res, next) =>
  profileMulter(req, res, (error) => {
    if (error instanceof multer.MulterError) {
      if (error.code === "LIMIT_UNEXPECTED_FILE") {
        return errorRes(res, "Unsupported image");
      } else if (error.code === "LIMIT_FILE_SIZE") {
        return errorRes(res, "Unsupported image size");
      }
    }

    if (error) return errorRes(res, error.message);
    if (!req.file) return errorRes(res, "Image not provided");

    next();
  });

export default profileUpload;
