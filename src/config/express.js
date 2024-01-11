import express from "express";
import cors from "cors";
import routes from "./routes.js";
import {
  urlNotFound,
  errorHandler,
} from "../core/middleware/error.middleware.js";
import getDirectory from "../core/utils/directory.js";

const app = express();
const corsOption = { origin: [] };

app.use(cors(corsOption));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/public/", express.static(getDirectory("/")));
app.use("/api", routes);
app.use(urlNotFound);
app.use(errorHandler);

export default app;
