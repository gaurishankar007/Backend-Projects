import dotenv from "dotenv";
dotenv.config();

const port = process.env.PORT || 4040;
const mongoURL = process.env.MONGODB;
const jwtSecret = process.env.SECRET;
const bcryptSalt = process.env.SALT;

export { port, mongoURL, jwtSecret, bcryptSalt };
