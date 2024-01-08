import jwt from "jsonwebtoken";
import { jwtSecret } from "../constants/variables";

const tokenHandler = {
  generateToken: (data, options = { expiresIn: "1h" }) => {
    const token = jwt.sign(data, jwtSecret, { ...options });
    return token;
  },
  verifyToken: (token) => {
    const data = jwt.verify(token, jwtSecret);
    return data;
  },
  generateRefreshToken: (data, options = { expiresIn: "1d" }) => {
    const token = jwt.sign(data, jwtSecret, { ...options });
    return token;
  },
};

export default tokenHandler;
