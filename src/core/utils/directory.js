import { fileURLToPath } from "url";
import path from "path";

const getDirectory = (pathInsidePublic) => {
  const __filename = fileURLToPath(import.meta.url);
  const __dirname = path.dirname(__filename);

  return path.join(__dirname, `../../../public${pathInsidePublic}`);
};

export default getDirectory;
