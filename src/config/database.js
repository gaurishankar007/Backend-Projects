import mongoose from "mongoose";
import { mongoURL } from "../core/constants/variables.js";

mongoose
  .connect(mongoURL)
  .then(() => console.log("MongoDB Connected"))
  .catch((error) => console.log(error));
