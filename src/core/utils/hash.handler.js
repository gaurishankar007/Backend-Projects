import bcrypt from "bcryptjs";
import { bcryptSalt } from "../constants/variables.js";

const hashHandler = {
  has: async (data) => {
    const hashed = await bcrypt.hash(data, parseInt(bcryptSalt));
    return hashed;
  },
  compare: async (data, hashed) => {
    const isValid = await bcrypt.compare(data, hashed);
    return isValid;
  },
};

export default hashHandler;
