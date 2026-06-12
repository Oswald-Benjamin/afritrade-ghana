# AfriTrade Ghana — Implementation Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Build a Ghana-focused stock trading platform — GSE market data, mobile money integration, portfolio management, and IPO subscriptions.

**Architecture:** Next.js 15 (React, TypeScript) frontend + Supabase (PostgreSQL, Auth, RLS) backend. tRPC for type-safe API routes. Mobile money via MTN MoMo, Telecel Cash, AirtelTigo APIs. Market data via GSE feed or licensed provider.

**Tech Stack:** Next.js 15, React 19, TypeScript, Tailwind CSS, Supabase, tRPC, Zod, Zustand, Recharts, date-fns, Lucide icons

---

## Phase 1: Foundation (Weeks 1–3)

### Task 1.1: Project Bootstrap
**Objective:** Initialise Next.js project with TypeScript, Tailwind, and all dependencies.

**Files:**
- Create: `package.json` (done)
- Create: `tsconfig.json` (done)
- Create: `next.config.ts` (done)
- Create: `tailwind.config.ts` (done)
- Create: `postcss.config.mjs`
- Create: `src/styles/globals.css` (done)

**Steps:**
1. Run `npx create-next-app@latest . --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm` in the repo directory (or manually set up since files are already created)
2. Install additional dependencies: `npm install @supabase/supabase-js @supabase/ssr @trpc/client @trpc/server @trpc/react-query @tanstack/react-query zod zustand recharts date-fns lucide-react clsx tailwind-merge`
3. Install dev dependencies: `npm install -D vitest @playwright/test @types/node`
4. Run `npm run build` to verify setup
5. Commit

---

### Task 1.2: Supabase Client Setup
**Objective:** Create typed Supabase client for browser and server.

**Files:**
- Create: `src/lib/db/supabase-browser.ts`
- Create: `src/lib/db/supabase-server.ts`
- Create: `src/lib/db/supabase-middleware.ts`

**Code — `src/lib/db/supabase-browser.ts`:**
```typescript
import { createBrowserClient } from '@supabase/ssr'

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}
```

**Code — `src/lib/db/supabase-server.ts`:**
```typescript
import { createServerClient, type CookieOptions } from '@supabase/ssr'
import { cookies } from 'next/headers'

export async function createClient() {
  const cookieStore = await cookies()
  return createServerClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      cookies: {
        get(name: string) { return cookieStore.get(name)?.value },
        set(name: string, value: string, options: CookieOptions) {
          try { cookieStore.set({ name, value, ...options }) } catch {}
        },
        remove(name: string, options: CookieOptions) {
          try { cookieStore.set({ name, value: '', ...options }) } catch {}
        },
      },
    }
  )
}
```

**Steps:**
1. Create all three files
2. Verify TypeScript compilation: `npm run typecheck`
3. Commit

---

### Task 1.3: tRPC Setup
**Objective:** Configure tRPC server, client, and React provider.

**Files:**
- Create: `src/lib/api/trpc.ts`
- Create: `src/lib/api/router.ts`
- Create: `src/pages/api/trpc/[trpc].ts`
- Create: `src/lib/api/provider.tsx`

**Steps:**
1. Create tRPC init with context (Supabase user)
2. Create root router (empty, routes added in later tasks)
3. Create API handler at `/api/trpc/[trpc]`
4. Create React Query + tRPC provider wrapper
5. Verify: `npm run typecheck`
6. Commit

---

### Task 1.4: Auth Pages — Sign Up
**Objective:** Build sign-up page with email, phone, full name, and Ghana Card ID fields.

**Files:**
- Create: `src/pages/auth/signup.tsx`
- Create: `src/components/auth/SignUpForm.tsx`
- Create: `src/lib/validation/auth.ts`

**Steps:**
1. Create Zod validation schema for sign-up (email, phone, full_name, password, ghana_card_id optional)
2. Build SignUpForm component with Tailwind styling (Webara brand colours)
3. Create sign-up page with Supabase auth.signUp()
4. Write test: renders form, validates email, submits successfully
5. Commit

---

### Task 1.5: Auth Pages — Sign In
**Objective:** Build sign-in page with email/password.

**Files:**
- Create: `src/pages/auth/signin.tsx`
- Create: `src/components/auth/SignInForm.tsx`

**Steps:**
1. Build SignInForm component
2. Create sign-in page with Supabase auth.signInWithPassword()
3. Redirect to dashboard on success
4. Write test: renders form, handles invalid credentials
5. Commit

---

### Task 1.6: Auth Middleware
**Objective:** Protect routes — redirect unauthenticated users to sign-in.

**Files:**
- Create: `src/lib/db/supabase-middleware.ts`
- Modify: `next.config.ts` (add middleware matcher)

**Steps:**
1. Create Supabase middleware that refreshes session
2. Add middleware.ts at src/ that checks auth for protected routes
3. Test: accessing /dashboard redirects to /auth/signin when logged out
4. Commit

---

### Task 1.7: Layout & Navigation
**Objective:** Build main app layout with sidebar/navbar and page structure.

**Files:**
- Create: `src/components/layout/AppLayout.tsx`
- Create: `src/components/layout/Sidebar.tsx`
- Create: `src/components/layout/TopBar.tsx`
- Create: `src/components/ui/Card.tsx`
- Create: `src/components/ui/Button.tsx`

**Steps:**
1. Build reusable Card and Button components (Webara brand)
2. Build Sidebar with nav links: Dashboard, Market, Portfolio, IPOs, Wallet, Settings
3. Build TopBar with user avatar, notifications, sign out
4. Build AppLayout wrapper
5. Apply to dashboard page
6. Commit

---

## Phase 2: Market Data & Dashboard (Weeks 3–5)

### Task 2.1: Market Data Service
**Objective:** Create service to fetch and cache GSE market data.

**Files:**
- Create: `src/lib/api/market-data.ts`
- Create: `src/lib/hooks/useMarketData.ts`

**Steps:**
1. Create market data service with functions: getStocks(), getStock(ticker), getMarketSummary(), getPriceHistory(ticker, range)
2. For MVP: use mock data (hardcoded GSE stocks with realistic prices)
3. Create React hook useMarketData() with React Query caching
4. Write test: returns mock data, caches correctly
5. Commit

---

### Task 2.2: Dashboard Page
**Objective:** Build main dashboard with GSE summary, top movers, and portfolio overview.

**Files:**
- Create: `src/pages/index.tsx` (dashboard)
- Create: `src/components/market/MarketSummary.tsx`
- Create: `src/components/market/TopMovers.tsx`
- Create: `src/components/portfolio/PortfolioOverview.tsx`

**Steps:**
1. Build MarketSummary card (GSE Composite, advancers/decliners)
2. Build TopMovers list (biggest gainers/losers)
3. Build PortfolioOverview card (total value, day P&L, cash balance)
4. Compose dashboard page with all components
5. Commit

---

### Task 2.3: Market Page
**Objective:** Build full market page with stock list, search, and sector filter.

**Files:**
- Create: `src/pages/market/index.tsx`
- Create: `src/components/market/StockList.tsx`
- Create: `src/components/market/StockRow.tsx`
- Create: `src/components/market/MarketSearch.tsx`

**Steps:**
1. Build MarketSearch component
2. Build StockRow component (ticker, name, price, change%, volume)
3. Build StockList with search and sector filter
4. Create market page
5. Commit

---

### Task 2.4: Stock Detail Page
**Objective:** Build individual stock page with price chart and trade button.

**Files:**
- Create: `src/pages/market/[ticker].tsx`
- Create: `src/components/market/PriceChart.tsx`
- Create: `src/components/market/StockHeader.tsx`
- Create: `src/components/market/TradePanel.tsx`

**Steps:**
1. Build StockHeader (name, ticker, price, change, key stats)
2. Build PriceChart using Recharts (area chart with time range selector)
3. Build TradePanel (buy/sell toggle, quantity input, order type, estimated cost)
4. Create stock detail page
5. Commit

---

## Phase 3: Trading Engine (Weeks 5–7)

### Task 3.1: Order Submission
**Objective:** Implement buy/sell order submission via tRPC.

**Files:**
- Create: `src/lib/api/orders.ts`
- Create: `src/lib/validation/orders.ts`
- Modify: `src/lib/api/router.ts` (add orders router)

**Steps:**
1. Create Zod schema for order submission (ticker, side, type, quantity, price?)
2. Create tRPC router for orders: submitOrder(), cancelOrder(), getOrders()
3. Implement order validation (sufficient cash/shares, valid ticker)
4. Write test: validates order, rejects insufficient funds
5. Commit

---

### Task 3.2: Order Execution (Simulated)
**Objective:** Simulate order execution for MVP (no real broker integration yet).

**Files:**
- Create: `src/lib/api/order-engine.ts`
- Modify: `src/lib/api/orders.ts`

**Steps:**
1. Create order engine that processes market orders immediately at current price
2. Create limit order book that checks on each price update
3. Update portfolio cash and positions on fill
4. Create transaction record on fill
5. Write test: market buy reduces cash, adds position
6. Commit

---

### Task 3.3: Portfolio Page
**Objective:** Build portfolio page with positions, P&L, and transaction history.

**Files:**
- Create: `src/pages/portfolio/index.tsx`
- Create: `src/components/portfolio/PositionsList.tsx`
- Create: `src/components/portfolio/TransactionHistory.tsx`
- Create: `src/components/portfolio/PortfolioChart.tsx`

**Steps:**
1. Build PositionsList (ticker, qty, avg cost, current price, P&L)
2. Build TransactionHistory table
3. Build PortfolioChart (allocation pie chart + value over time)
4. Create portfolio page
5. Commit

---

## Phase 4: Mobile Money (Weeks 7–9)

### Task 4.1: MoMo Deposit Flow
**Objective:** Implement MTN MoMo deposit integration.

**Files:**
- Create: `src/lib/api/momo.ts`
- Create: `src/pages/wallet/index.tsx`
- Create: `src/components/wallet/DepositForm.tsx`
- Create: `src/components/wallet/WithdrawalForm.tsx`

**Steps:**
1. Create MoMo service: initiateDeposit(), checkStatus(), initiateWithdrawal()
2. For MVP: implement MTN MoMo Collection API (request-to-pay)
3. Build DepositForm (amount, phone, provider select)
4. Build WithdrawalForm
5. Build Wallet page with balance, deposit/withdrawal forms, transaction list
6. Write test: initiates deposit, handles callback
7. Commit

---

### Task 4.2: MoMo Callbacks
**Objective:** Handle MoMo payment callbacks and update balances.

**Files:**
- Create: `src/pages/api/webhooks/momo.ts`
- Modify: `src/lib/api/momo.ts`

**Steps:**
1. Create webhook endpoint for MoMo callbacks
2. Verify callback authenticity (signature check)
3. Update momo_transactions status
4. Credit user portfolio on successful deposit
5. Write test: callback credits correct amount
6. Commit

---

## Phase 5: Polish & Beta (Weeks 9–12)

### Task 5.1: KYC Flow
**Objective:** Build Ghana Card verification flow.

**Files:**
- Create: `src/pages/account/kyc.tsx`
- Create: `src/components/auth/KYCForm.tsx`
- Create: `src/lib/api/kyc.ts`

**Steps:**
1. Build KYC form (Ghana Card ID, photo upload)
2. Create KYC service (integrate with NIA API or manual review queue)
3. Update profile KYC status
4. Gate trading behind KYC verification
5. Commit

---

### Task 5.2: Price Alerts
**Objective:** Build price alert creation and notification system.

**Files:**
- Create: `src/lib/api/alerts.ts`
- Create: `src/components/market/AlertForm.tsx`
- Create: `src/pages/account/alerts.tsx`

**Steps:**
1. Build AlertForm (ticker, condition above/below, target price)
2. Create alerts tRPC router
3. Create alerts management page
4. Add cron job to check alerts against market data
5. Commit

---

### Task 5.3: IPO Page
**Objective:** Build IPO listing and subscription page.

**Files:**
- Create: `src/pages/ipos/index.tsx`
- Create: `src/components/market/IPOCard.tsx`
- Create: `src/pages/ipos/[id].tsx`

**Steps:**
1. Build IPO card component
2. Build IPO listing page
3. Build IPO detail page with subscription form
4. Gate subscription behind KYC + sufficient cash
5. Commit

---

### Task 5.4: Testing & E2E
**Objective:** Write comprehensive tests and E2E flows.

**Files:**
- Create: `tests/e2e/auth.spec.ts`
- Create: `tests/e2e/trading.spec.ts`
- Create: `tests/e2e/wallet.spec.ts`

**Steps:**
1. Write Playwright E2E tests for auth flow
2. Write E2E tests for trading flow (buy/sell)
3. Write E2E tests for wallet (deposit/withdrawal)
4. Run full test suite: `npm run test:e2e`
5. Fix any failures
6. Commit

---

## Phase 6: Production Prep (Weeks 12–14)

### Task 6.1: Admin Dashboard
**Objective:** Build admin panel for user management and monitoring.

**Files:**
- Create: `src/pages/admin/index.tsx`
- Create: `src/pages/admin/users.tsx`
- Create: `src/pages/admin/orders.tsx`

**Steps:**
1. Create admin layout with role-based access
2. Build users management page
3. Build orders monitoring page
4. Add admin RLS policies
5. Commit

---

### Task 6.2: Monitoring & Error Tracking
**Objective:** Add Sentry error tracking and performance monitoring.

**Files:**
- Modify: `next.config.ts`
- Create: `sentry.client.config.ts`
- Create: `sentry.server.config.ts`

**Steps:**
1. Install Sentry SDK
2. Configure client and server Sentry
3. Add error boundaries to key components
4. Test error reporting
5. Commit

---

### Task 6.3: Deployment
**Objective:** Deploy to production (Vercel + Supabase).

**Steps:**
1. Set up Vercel project and connect repo
2. Configure production Supabase instance
3. Run migrations on production DB
4. Set all environment variables in Vercel
5. Deploy and verify
6. Set up custom domain
7. Commit

---

## Post-MVP (Phase 3 of Roadmap)

- React Native mobile app
- Real broker integration (Databank, IC Securities)
- Fixed income instruments (GoG bonds, T-bills)
- Social features (watchlists, leaderboards)
- AI market summaries
- Multi-exchange expansion (Malawi MSE, Nigeria NGX, Kenya NSE)
