import multer from "multer";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const pictureStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../../../public/pictures"));
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

const filter = (req, file, cb) => {
  const isValidImage =
    file.mimetype == "image/jpg" ||
    file.mimetype == "image/jpeg" ||
    file.mimetype == "image/png";

  if (isValidImage) {
    cb(null, true);
  } else {
    cb(null, false);
  }
};

const pictureUpload = multer({ storage: pictureStorage, fileFilter: filter });

export default pictureUpload;
