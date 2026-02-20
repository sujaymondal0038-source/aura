const fallback = process.env.DEFAULT_LANGUAGE || 'en';
const supported = new Set((process.env.SUPPORTED_LANGUAGES || 'en').split(','));

export function languageMiddleware(req, _res, next) {
  const explicit = req.headers['x-language'];
  const accept = req.headers['accept-language']?.split(',')?.[0]?.trim()?.split('-')?.[0];
  const selected = explicit || accept || fallback;
  req.context = {
    language: supported.has(selected) ? selected : fallback,
    isRtl: ['ar', 'ur'].includes(selected)
  };
  next();
}
