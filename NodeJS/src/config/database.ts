import mongoose from "mongoose";
import { mongoURL } from "../constants/variables.js";

export class Database {
  constructor() {
    this.connect();
  }

  private connect() {
    mongoose
      .connect(mongoURL)
      .then(() => console.log("MongoDB Connected"))
      .catch((error) => console.log(error));
  }
}
