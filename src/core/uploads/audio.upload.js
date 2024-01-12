import multer from "multer";
import { errorRes } from "../utils/response.js";
import { publicDirectory } from "../utils/directory.js";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, publicDirectory("/audios"));
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req, file, cb) => {
  const types = ["audio/mp3", "audio/mp4", "audio/m4A", "audio/mpeg"];
  const fileSize = parseInt(req.headers["content-length"]);

  if (!types.includes(file.mimetype)) {
    cb(new multer.MulterError("LIMIT_UNEXPECTED_FILE"), false);
  } else if (fileSize > 25 * 1e6) {
    cb(new multer.MulterError("LIMIT_FILE_SIZE"), false);
  } else {
    cb(null, true);
  }
};

const audioMulter = multer({
  storage: storage,
  fileFilter: filter,
  limits: { fileSize: 25 * 1e6 },
}).single("audio");

const audioUpload = (req, res, next) => {
  audioMulter(req, res, (error) => {
    if (error instanceof multer.MulterError) {
      if (error.code === "LIMIT_UNEXPECTED_FILE") {
        return errorRes(res, "Unsupported audio");
      } else if (error.code === "LIMIT_FILE_SIZE") {
        return errorRes(res, "Unsupported audio size");
      }
    }

    if (error) return errorRes(res, error.message);
    if (!req.file) return errorRes(res, "Audio is not provided");

    next();
  });
};

export default audioUpload;
