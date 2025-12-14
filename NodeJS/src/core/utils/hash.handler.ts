import bcrypt from "bcryptjs";
import { bcryptSalt } from "../constants/variables.js";

const hashHandler = {
  has: async (data: string) => {
    const hashed = await bcrypt.hash(data, parseInt(bcryptSalt));
    return hashed;
  },
  compare: async (data: string, hashed: string) => {
    const isValid = await bcrypt.compare(data, hashed);
    return isValid;
  },
};

export default hashHandler;
