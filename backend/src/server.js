import http from 'node:http';
import dotenv from 'dotenv';
import { createApp } from './app.js';
import { createWsGateway } from './ws/gateway.js';

dotenv.config();

const port = Number(process.env.PORT || 8080);
const app = createApp();
const server = http.createServer(app);

createWsGateway(server);

server.listen(port, () => {
  console.log(`AURA backend listening on :${port}`);
});
