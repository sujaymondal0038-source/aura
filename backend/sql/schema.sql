-- AURA PostgreSQL schema (UTF-8 required)

CREATE TYPE role_type AS ENUM ('admin', 'agency', 'host', 'user');
CREATE TYPE kyc_status AS ENUM ('pending', 'approved', 'rejected');
CREATE TYPE withdrawal_status AS ENUM ('pending', 'approved', 'rejected', 'frozen');
CREATE TYPE txn_kind AS ENUM ('coin_purchase', 'gift_sent', 'call_deduction', 'earning_credit', 'adjustment');

CREATE TABLE accounts (
  id UUID PRIMARY KEY,
  role role_type NOT NULL,
  phone_e164 TEXT UNIQUE,
  display_name TEXT,
  preferred_language TEXT NOT NULL DEFAULT 'en',
  is_rtl BOOLEAN NOT NULL DEFAULT FALSE,
  is_suspended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE agencies (
  id UUID PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id),
  commission_pct NUMERIC(5,2) NOT NULL DEFAULT 10.00,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE hosts (
  id UUID PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id),
  agency_id UUID REFERENCES agencies(id),
  kyc kyc_status NOT NULL DEFAULT 'pending',
  level INT NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE wallets (
  account_id UUID PRIMARY KEY REFERENCES accounts(id),
  coin_balance BIGINT NOT NULL DEFAULT 0,
  earning_balance BIGINT NOT NULL DEFAULT 0,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE transactions (
  id UUID PRIMARY KEY,
  account_id UUID NOT NULL REFERENCES accounts(id),
  kind txn_kind NOT NULL,
  coins BIGINT NOT NULL,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE streams (
  id UUID PRIMARY KEY,
  host_id UUID NOT NULL REFERENCES hosts(id),
  title TEXT,
  language TEXT NOT NULL DEFAULT 'en',
  started_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,
  concurrent_peak INT NOT NULL DEFAULT 0
);

CREATE TABLE call_sessions (
  id UUID PRIMARY KEY,
  host_id UUID NOT NULL REFERENCES hosts(id),
  user_id UUID NOT NULL REFERENCES accounts(id),
  coins_per_minute INT NOT NULL,
  started_at TIMESTAMPTZ NOT NULL,
  ended_at TIMESTAMPTZ,
  deducted_coins BIGINT NOT NULL DEFAULT 0
);

CREATE TABLE gifts (
  id UUID PRIMARY KEY,
  code TEXT UNIQUE NOT NULL,
  default_name JSONB NOT NULL,
  coin_cost INT NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE withdrawals (
  id UUID PRIMARY KEY,
  host_id UUID NOT NULL REFERENCES hosts(id),
  amount BIGINT NOT NULL,
  status withdrawal_status NOT NULL DEFAULT 'pending',
  reviewed_by UUID REFERENCES accounts(id),
  reviewed_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE moderation_events (
  id UUID PRIMARY KEY,
  actor_account_id UUID NOT NULL REFERENCES accounts(id),
  event_type TEXT NOT NULL,
  severity INT NOT NULL,
  details JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE fraud_logs (
  id UUID PRIMARY KEY,
  account_id UUID REFERENCES accounts(id),
  ip_address INET,
  device_fingerprint TEXT,
  risk_score INT NOT NULL DEFAULT 0,
  reason TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX idx_transactions_account_created ON transactions(account_id, created_at DESC);
CREATE INDEX idx_streams_host_started ON streams(host_id, started_at DESC);
CREATE INDEX idx_calls_host_started ON call_sessions(host_id, started_at DESC);
CREATE INDEX idx_fraud_account_created ON fraud_logs(account_id, created_at DESC);
