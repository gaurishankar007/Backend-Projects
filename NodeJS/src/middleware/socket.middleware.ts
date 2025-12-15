import { Socket } from "socket.io";
import { verifyToken } from "../utils/token.js";

const socketMiddleware = (socket: Socket, next: (err?: any) => void) => {
  try {
    const token = socket.handshake.auth.token; // Assuming token is still from auth.token, as 'header' is undefined in the context.
    if (!token) return next(new Error("Authentication error"));

    const decoded = verifyToken(token);
    if (!decoded) return next(new Error("Authentication error"));

    socket.data.user = decoded;
    next();
  } catch (error) {
    next(Error(`${error}`));
  }
};

export default socketMiddleware;
