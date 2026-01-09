import jwt from "jsonwebtoken";
import { jwtSecret } from "../constants/variables.js";

export const generateToken = (
  data: any,
  options: jwt.SignOptions = { expiresIn: "1h" }
): string => {
  const json = { ...data, type: "token" };
  // @ts-ignore
  return jwt.sign(json, jwtSecret, options);
};

export const verifyToken = (token: string): any => {
  return jwt.verify(token, jwtSecret);
};

export const generateRefreshToken = (
  data: any,
  options: jwt.SignOptions = { expiresIn: "100d" }
): string => {
  const json = { ...data, type: "refresh" };
  // @ts-ignore
  return jwt.sign(json, jwtSecret, options);
};
