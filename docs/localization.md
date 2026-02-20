# Localization and RTL Strategy

## Principles
- Store all text as Unicode UTF-8.
- Persist per-user language preference.
- Use device locale for first-run defaults.
- Support runtime language switching without restart.

## Required language features
- Languages: en, hi, bn, ar, es, fr, ur (extensible)
- RTL rendering for Arabic/Urdu
- Multilingual notifications using template keys + locale params
- Multilingual admin dashboard labels and reports

## Backend contract
- API accepts `x-language` and `accept-language`.
- Response includes active language and RTL flag.
- Chat/gift labels are localized by key using client bundles.

## Database notes
- JSONB translation maps for dynamic gift names and system text.
- Use collation-safe searches for multilingual names.
