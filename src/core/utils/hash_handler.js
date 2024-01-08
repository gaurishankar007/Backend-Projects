import bcrypt from "bcryptjs";
import { bcryptSalt } from "../constants/variables.js";

const hashHandler = {
  has: (data) => {
    const hashed = bcrypt.hash(data, bcryptSalt);
    return hashed;
  },
  compare: async (data, hashed) => {
    const isValid = bcrypt.compare(data, hashed);
    return isValid;
  },
};

export default hashHandler;
