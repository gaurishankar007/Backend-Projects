import multer from "multer";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../../../public/audios"));
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req, file, cb) => {
  const isValidImage =
    file.mimetype == "audio/mp3" ||
    file.mimetype == "audio/mp4" ||
    file.mimetype == "audio/m4A";

  if (isValidImage) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const audioUpload = multer({ storage: storage, fileFilter: filter });

export default audioUpload;
