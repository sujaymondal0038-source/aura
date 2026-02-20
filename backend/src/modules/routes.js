import { Router } from 'express';

export function registerRoutes(app) {
  const router = Router();

  router.get('/v1/meta/localization', (req, res) => {
    res.json({
      language: req.context.language,
      rtl: req.context.isRtl,
      supported: (process.env.SUPPORTED_LANGUAGES || 'en').split(',')
    });
  });

  router.get('/v1/admin/overview', (_req, res) => {
    res.json({
      kpis: {
        liveHosts: 0,
        concurrentUsers: 0,
        dailyCoinsSpent: 0,
        pendingWithdrawals: 0
      }
    });
  });

  router.post('/v1/wallet/deduct-call', (req, res) => {
    const { userId, hostId, coinsPerMinute, minutes } = req.body;
    const deducted = Number(coinsPerMinute || 0) * Number(minutes || 0);
    res.json({ userId, hostId, deducted, status: 'calculated' });
  });

  router.post('/v1/moderation/strike', (req, res) => {
    const { actorId, reason } = req.body;
    res.json({ actorId, reason, status: 'strike_recorded' });
  });

  app.use(router);
}
