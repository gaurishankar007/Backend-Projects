import { Socket } from "socket.io";
import tokenHandler from "../utils/token.handler.js";

const socketMiddleware = (socket: Socket, next: (err?: any) => void) => {
  try {
    const token = socket.handshake.auth.token;
    if (!token) throw Error("Authentication is not provided");

    const { id, type } = tokenHandler.verifyToken(token) as any;
    if (type !== "token") throw Error("Invalid token");

    next();
  } catch (error) {
    next(Error(`${error}`));
  }
};

export default socketMiddleware;
