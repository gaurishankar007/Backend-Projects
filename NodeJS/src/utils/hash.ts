import bcrypt from "bcryptjs";
import { bcryptSalt } from "../constants/variables.js";

export const hash = async (data: string): Promise<string> => {
  const salt = await bcrypt.genSalt(parseInt(bcryptSalt));
  return await bcrypt.hash(data, salt);
};

export const compare = async (
  data: string,
  hashed: string
): Promise<boolean> => {
  return await bcrypt.compare(data, hashed);
};
