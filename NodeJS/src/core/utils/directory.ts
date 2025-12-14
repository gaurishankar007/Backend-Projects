import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const publicDirectory = (folderPath: any) =>
  path.join(__dirname, `../../../public${folderPath}`);

const filePath = (file: any) => {
  const fileType = file.mimetype.split("/")[0];
  let folder = "";

  if (fileType === "image") {
    folder = "images";
  } else if (fileType === "audio") {
    folder = "audios";
  } else if (fileType === "video") {
    folder = "videos";
  }

  const filePath = path.join(
    __dirname,
    `../../../public/${folder}/${file.filename}`
  );

  return filePath;
};

export { filePath, publicDirectory };
