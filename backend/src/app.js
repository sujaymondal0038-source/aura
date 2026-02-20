import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { languageMiddleware } from './middleware/language.js';
import { registerRoutes } from './modules/routes.js';

export function createApp() {
  const app = express();
  app.use(helmet());
  app.use(cors());
  app.use(express.json({ limit: '1mb' }));
  app.use(languageMiddleware);

  app.get('/health', (_req, res) => {
    res.json({ status: 'ok', service: 'aura-backend' });
  });

  registerRoutes(app);
  return app;
}
