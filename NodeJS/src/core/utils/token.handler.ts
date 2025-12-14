import jwt from "jsonwebtoken";
import { jwtSecret } from "../constants/variables.js";

const tokenHandler = {
  generateToken: (
    data: any,
    options: jwt.SignOptions = { expiresIn: "1h" }
  ) => {
    const json = { ...data, type: "token" };
    // @ts-ignore
    const token = jwt.sign(json, jwtSecret, options);
    return token;
  },
  verifyToken: (token: string) => {
    const data = jwt.verify(token, jwtSecret);
    return data;
  },
  generateRefreshToken: (
    data: any,
    options: jwt.SignOptions = { expiresIn: "100d" }
  ) => {
    const json = { ...data, type: "refresh" };
    // @ts-ignore
    const refresh = jwt.sign(json, jwtSecret, options);
    return refresh;
  },
};

export default tokenHandler;
