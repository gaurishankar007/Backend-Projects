import express from "express";
import userRouter from "../routes/user.routes.js";

const routes = express.Router();

routes.use("/auth", userRouter);

export default routes;
