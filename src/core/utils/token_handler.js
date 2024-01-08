import jwt from "jsonwebtoken";
import { jwtSecret } from "../constants/variables.js";

const tokenHandler = {
  generateToken: (data, options = { expiresIn: "1h" }) => {
    const json = { ...data, type: "token" };
    const token = jwt.sign(json, jwtSecret, options);
    return token;
  },
  verifyToken: (token) => {
    const data = jwt.verify(token, jwtSecret);
    return data;
  },
  generateRefreshToken: (data, options = { expiresIn: "1d" }) => {
    const json = { ...data, type: "refresh" };
    const refresh = jwt.sign(json, jwtSecret, options);
    return refresh;
  },
};

export default tokenHandler;
