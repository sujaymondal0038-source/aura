import { WebSocketServer } from 'ws';

export function createWsGateway(server) {
  const wss = new WebSocketServer({ server, path: '/ws' });

  wss.on('connection', (socket) => {
    socket.send(JSON.stringify({ type: 'connected', message: 'AURA realtime gateway' }));

    socket.on('message', (message) => {
      let payload;
      try {
        payload = JSON.parse(String(message));
      } catch {
        payload = { type: 'raw', data: String(message) };
      }
      socket.send(JSON.stringify({ type: 'echo', payload }));
    });
  });

  return wss;
}
