const port = process.env.PORT || 4040;
const mongoURL = process.env.MONGODB as string;
const jwtSecret = process.env.SECRET as string;
const bcryptSalt = process.env.SALT as string;

export { bcryptSalt, jwtSecret, mongoURL, port };
