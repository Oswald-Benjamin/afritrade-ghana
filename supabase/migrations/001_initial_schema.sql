-- AfriTrade Ghana — Initial Database Schema
-- Supabase PostgreSQL Migration

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ─── Custom Types ─────────────────────────────────────────────

CREATE TYPE kyc_status AS ENUM ('pending', 'verified', 'rejected', 'expired');
CREATE TYPE order_type AS ENUM ('market', 'limit');
CREATE TYPE order_side AS ENUM ('buy', 'sell');
CREATE TYPE order_status AS ENUM ('pending', 'submitted', 'partially_filled', 'filled', 'cancelled', 'rejected', 'expired');
CREATE TYPE transaction_type AS ENUM ('deposit', 'withdrawal', 'trade_buy', 'trade_sell', 'commission', 'ipo_subscription', 'dividend');
CREATE TYPE transaction_status AS ENUM ('pending', 'completed', 'failed', 'reversed');
CREATE TYPE momo_provider AS ENUM ('mtn', 'telecel', 'airteltigo');
CREATE TYPE momo_status AS ENUM ('initiated', 'pending_confirmation', 'completed', 'failed', 'timed_out');
CREATE TYPE ipo_status AS ENUM ('upcoming', 'open', 'closed', 'allocated', 'listed', 'cancelled');

-- ─── Profiles (extends Supabase auth.users) ───────────────────

CREATE TABLE public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT,
    phone TEXT NOT NULL,
    full_name TEXT NOT NULL DEFAULT '',
    ghana_card_id TEXT,
    kyc_status kyc_status NOT NULL DEFAULT 'pending',
    kyc_verified_at TIMESTAMPTZ,
    display_name TEXT,
    avatar_url TEXT,
    preferred_language TEXT NOT NULL DEFAULT 'en',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Portfolios ──────────────────────────────────────────────

CREATE TABLE public.portfolios (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    cash_balance DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    invested_value DECIMAL(12, 2) NOT NULL DEFAULT 0.00,
    is_demo BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, is_demo)
);

-- ─── Positions ───────────────────────────────────────────────

CREATE TABLE public.positions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    ticker TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0,
    average_cost DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, ticker)
);

-- ─── Orders ──────────────────────────────────────────────────

CREATE TABLE public.orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    ticker TEXT NOT NULL,
    type order_type NOT NULL,
    side order_side NOT NULL,
    quantity INTEGER NOT NULL,
    price DECIMAL(10, 2),
    status order_status NOT NULL DEFAULT 'pending',
    filled_quantity INTEGER NOT NULL DEFAULT 0,
    filled_price DECIMAL(10, 2),
    commission DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    broker_reference TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Transactions ────────────────────────────────────────────

CREATE TABLE public.transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    type transaction_type NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    currency TEXT NOT NULL DEFAULT 'GHS',
    status transaction_status NOT NULL DEFAULT 'pending',
    reference TEXT,
    metadata JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Mobile Money Transactions ───────────────────────────────

CREATE TABLE public.momo_transactions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    provider momo_provider NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('deposit', 'withdrawal')),
    amount DECIMAL(12, 2) NOT NULL,
    phone TEXT NOT NULL,
    reference TEXT NOT NULL UNIQUE,
    external_reference TEXT,
    status momo_status NOT NULL DEFAULT 'initiated',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at TIMESTAMPTZ
);

-- ─── IPOs ────────────────────────────────────────────────────

CREATE TABLE public.ipos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ticker TEXT NOT NULL UNIQUE,
    company_name TEXT NOT NULL,
    sector TEXT NOT NULL,
    offer_price DECIMAL(10, 2) NOT NULL,
    offer_size BIGINT NOT NULL,
    opens_at TIMESTAMPTZ NOT NULL,
    closes_at TIMESTAMPTZ NOT NULL,
    listing_date DATE,
    status ipo_status NOT NULL DEFAULT 'upcoming',
    oversubscription_ratio DECIMAL(5, 2),
    description TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── IPO Subscriptions ───────────────────────────────────────

CREATE TABLE public.ipo_subscriptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    ipo_id UUID NOT NULL REFERENCES public.ipos(id) ON DELETE CASCADE,
    shares INTEGER NOT NULL,
    amount DECIMAL(12, 2) NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'allocated', 'refunded')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE(user_id, ipo_id)
);

-- ─── Price Alerts ────────────────────────────────────────────

CREATE TABLE public.price_alerts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
    ticker TEXT NOT NULL,
    condition TEXT NOT NULL CHECK (condition IN ('above', 'below')),
    target_price DECIMAL(10, 2) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    triggered_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Market Data Cache ───────────────────────────────────────

CREATE TABLE public.market_data_cache (
    ticker TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    sector TEXT NOT NULL,
    current_price DECIMAL(10, 2) NOT NULL,
    previous_close DECIMAL(10, 2),
    change DECIMAL(10, 2),
    change_percent DECIMAL(6, 2),
    volume BIGINT,
    market_cap DECIMAL(15, 2),
    high_52w DECIMAL(10, 2),
    low_52w DECIMAL(10, 2),
    last_updated TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── GSE Composite Index History ──────────────────────────────

CREATE TABLE public.gse_index_history (
    id BIGSERIAL PRIMARY KEY,
    date DATE NOT NULL UNIQUE,
    composite_value DECIMAL(10, 2) NOT NULL,
    change_value DECIMAL(10, 2),
    change_percent DECIMAL(6, 2),
    volume BIGINT,
    total_value DECIMAL(15, 2),
    advancing INTEGER,
    declining INTEGER,
    unchanged INTEGER
);

-- ─── Indexes ─────────────────────────────────────────────────

CREATE INDEX idx_orders_user_id ON public.orders(user_id);
CREATE INDEX idx_orders_status ON public.orders(status);
CREATE INDEX idx_orders_user_status ON public.orders(user_id, status);
CREATE INDEX idx_positions_user_id ON public.positions(user_id);
CREATE INDEX idx_transactions_user_id ON public.transactions(user_id);
CREATE INDEX idx_transactions_created ON public.transactions(created_at DESC);
CREATE INDEX idx_momo_txn_user ON public.momo_transactions(user_id);
CREATE INDEX idx_momo_txn_ref ON public.momo_transactions(reference);
CREATE INDEX idx_price_alerts_user ON public.price_alerts(user_id);
CREATE INDEX idx_price_alerts_active ON public.price_alerts(is_active) WHERE is_active = TRUE;
CREATE INDEX idx_gse_history_date ON public.gse_index_history(date DESC);

-- ─── Row Level Security ──────────────────────────────────────

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.portfolios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.positions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.momo_transactions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ipo_subscriptions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.price_alerts ENABLE ROW LEVEL SECURITY;

-- Profiles: users can read/write own profile
CREATE POLICY profiles_select ON public.profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY profiles_update ON public.profiles FOR UPDATE USING (auth.uid() = id);

-- Portfolios
CREATE POLICY portfolios_select ON public.portfolios FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY portfolios_update ON public.portfolios FOR UPDATE USING (auth.uid() = user_id);

-- Positions
CREATE POLICY positions_all ON public.positions FOR ALL USING (auth.uid() = user_id);

-- Orders
CREATE POLICY orders_select ON public.orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY orders_insert ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Transactions
CREATE POLICY transactions_select ON public.transactions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY transactions_insert ON public.transactions FOR INSERT WITH CHECK (auth.uid() = user_id);

-- MoMo transactions
CREATE POLICY momo_txn_select ON public.momo_transactions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY momo_txn_insert ON public.momo_transactions FOR INSERT WITH CHECK (auth.uid() = user_id);

-- IPO subscriptions
CREATE POLICY ipo_sub_select ON public.ipo_subscriptions FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY ipo_sub_insert ON public.ipo_subscriptions FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Price alerts
CREATE POLICY price_alerts_all ON public.price_alerts FOR ALL USING (auth.uid() = user_id);

-- Public read access for market data and IPOs
CREATE POLICY market_data_public ON public.market_data_cache FOR SELECT USING (TRUE);
CREATE POLICY public_ipos ON public.ipos FOR SELECT USING (TRUE);

-- ─── Helper Functions ────────────────────────────────────────

-- Auto-update updated_at timestamp
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to all tables with updated_at
CREATE TRIGGER update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_portfolios_updated_at BEFORE UPDATE ON public.portfolios FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_positions_updated_at BEFORE UPDATE ON public.positions FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();
CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- On user signup: create profile and demo portfolio
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.profiles (id, email, full_name, phone)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', ''),
        COALESCE(NEW.raw_user_meta_data->>'phone', '')
    );
    INSERT INTO public.portfolios (user_id, is_demo, cash_balance)
    VALUES (NEW.id, TRUE, 10000.00);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
