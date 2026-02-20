# AURA — Global Multilingual Live Streaming Platform

AURA is a production-oriented monorepo blueprint for a multilingual live streaming + paid 1v1 video call product with hierarchical roles:

- **Admin → Agency → Host → User**
- Real-time **coin monetization**
- **Localization-first** architecture with RTL support
- AI moderation, fraud checks, and payout controls

This repository now includes:

1. **Backend API + WebSocket skeleton** (`backend/`) for auth, wallet, streaming, moderation, analytics, admin controls
2. **Database schema** (`backend/sql/schema.sql`) for roles, coins, wallets, gifts, calls, payouts, KYC, fraud logs
3. **Admin dashboard architecture note** (`docs/admin-dashboard.md`)
4. **Flutter mobile architecture note** (`docs/mobile-app.md`)
5. **Cloud/deployment architecture** (`docs/architecture.md`)
6. **Localization strategy** (`docs/localization.md`)

---

## Quick start (backend skeleton)

```bash
cd backend
cp .env.example .env
npm install
npm run dev
```

Health check:

```bash
curl http://localhost:8080/health
```

---

## Tech stack (recommended)

- **Mobile**: Flutter (Android/iOS)
- **Backend**: Node.js + REST + WebSocket
- **Database**: PostgreSQL (UTF-8)
- **Streaming/RTC**: Agora or ZEGOCLOUD
- **Infra**: AWS/GCP (autoscaling, LB, managed DB, object storage)
- **Observability**: OpenTelemetry + Prometheus + Grafana + centralized logs

---

## Implemented architecture highlights

- Dynamic language negotiation via `Accept-Language` and profile preference
- RTL-aware language metadata (Arabic/Urdu)
- Coin economy primitives: purchases, gifts, call deduction, ledger entries
- Commission model support (host/agency/platform split)
- Admin-level payout freeze and manual override points
- AI moderation pipeline hooks and strike lifecycle
- Fraud logging (IP, device fingerprint, suspicious pattern flags)
- Analytics aggregation tables for weekly/monthly dashboards

---

## Repository structure

```text
.
├── backend
│   ├── sql
│   │   └── schema.sql
│   └── src
│       ├── app.js
│       ├── config
│       ├── middleware
│       ├── modules
│       └── ws
├── docs
│   ├── admin-dashboard.md
│   ├── architecture.md
│   ├── localization.md
│   └── mobile-app.md
├── admin-web
└── mobile-flutter
```

---

## Production roadmap

1. Complete API controllers/service implementations per module.
2. Add OAuth/OTP providers, payment gateways, and app-store billing verification.
3. Integrate Agora/ZEGOCLOUD tokens and live/call orchestration.
4. Build Flutter screens + i18n JSON/ARB files and RTL layouts.
5. Implement admin web UI (RBAC, charts, moderation, payout workflows).
6. Add CI/CD, IaC (Terraform), SAST/DAST, and DR runbooks.
