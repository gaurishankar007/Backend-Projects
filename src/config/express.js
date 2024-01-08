import express from "express";
import cors from "cors";
import path from "path";
import { fileURLToPath } from "url";
import routes from "./routes.js";
import {
  urlNotFound,
  errorHandler,
} from "../core/middleware/errorMiddleware.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const corsOption = { origin: [] };

app.use(cors(corsOption));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/public/", express.static(path.join(__dirname, "../../public/")));
app.use("/api", routes);
app.use(urlNotFound);
app.use(errorHandler);

export default app;
