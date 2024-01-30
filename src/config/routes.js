import express from "express";
import userRouter from "../routes/user.routes.js";
import chatRouter from "../routes/chat.routes.js";
import messageRouter from "../routes/message.routes.js";

const routes = express.Router();

routes.use("/auth", userRouter);
routes.use("/chat", chatRouter);
routes.use("/message", messageRouter);

export default routes;
