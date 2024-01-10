import express from "express";
import userRouter from "../routes/user.routes.js";
import chatRouter from "../routes/chat.routes.js";
import messageRouter from "../routes/message.routes.js";
import reactionRouter from "../routes/reaction.routes.js";
import memberRouter from "../routes/member.routes.js";

const routes = express.Router();

routes.use("/auth", userRouter);
routes.use("/chat", chatRouter);
routes.use("/message", messageRouter);
routes.use("/reaction", reactionRouter);
routes.use("/member", memberRouter);

export default routes;
