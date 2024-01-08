import { Server } from "socket.io";
import app from "./src/config/express.js";
import { port } from "./src/core/constants/variables.js";
import socketFunc from "./socket.js";
import "./src/config/database.js";

const appListener = () => console.log(`Server is running on port: ${port}`);
const server = app.listen(port, appListener);

const ioOption = { pingTimeout: 30000, cors: { origin: [] } };
const io = new Server(server, ioOption);

io.on("connection", socketFunc);
