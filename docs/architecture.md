# AURA Cloud Architecture

## Core services
- API Gateway + WAF
- Auth/Identity service (OTP + JWT + refresh)
- User/Host/Agency service
- Wallet/Ledger service
- Live Orchestration service (Agora/ZEGOCLOUD tokening + session lifecycle)
- Moderation service (AI + rule engine + strike management)
- Reporting service (weekly/monthly aggregations)
- Notification service (push + multilingual templates)

## Data and messaging
- PostgreSQL (primary relational store)
- Redis (sessions, rate limits, presence, pub/sub cache)
- Kafka/PubSub (analytics and moderation event stream)
- Object storage for media, KYC docs, and audit exports

## Scalability
- Kubernetes autoscaling on CPU/RPS/connections
- Stateless API pods behind load balancer
- WebSocket gateway with sticky sessions or Redis adapter
- Read replicas for analytics-heavy workloads

## Security/compliance
- TLS everywhere, secrets manager, KMS-encrypted data keys
- PII partitioning + strict RBAC
- Full audit logs for wallet and withdrawal actions
- Policy alignment for Google Play / Apple content + payment rules
