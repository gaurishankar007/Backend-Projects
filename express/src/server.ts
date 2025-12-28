import "reflect-metadata";
import { Server } from "socket.io";
import { App } from "./app.js";
import { port } from "./constants/variables.js";

const application = new App();
const app = application.app;

const onAppListened = () => console.log(`Server is running on port: ${port}`);
const server = app.listen(port, onAppListened);

const ioOption = { pingTimeout: 30000, cors: { origin: [] } };
const io = new Server(server, ioOption);

application.initializeSocket(io);
