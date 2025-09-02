const socketMiddleware = (socket, next) => {
  try {
    const token = socket.handshake.auth.token;
    if (!token) throw Error("Authentication is not provided");

    const { id, type } = tokenHandler.verifyToken(token);
    if (type !== "token") return errorResponse(res, "Invalid token", undefined, 401);

    next();
  } catch (error) {
    next(Error(`${error}`));
  }
};

export default socketMiddleware;
