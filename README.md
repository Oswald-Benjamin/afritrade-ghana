# AfriTrade Ghana 🇬🇭

> **Trade the Ghana Stock Exchange. Built for Ghana. Designed for Africa.**

AfriTrade Ghana is a mobile-first stock trading platform that makes it easy for everyday Ghanaians to buy and sell equities on the **Ghana Stock Exchange (GSE)** — powered by mobile money, built with modern web technology, and designed to scale across West Africa.

---

## Why Ghana First?

- **GSE Composite +63.63% YTD (2026)** — strongest performing major African exchange
- **Kasapreko IPO oversubscribed 146%** — retail demand is proven
- **Mobile money penetration** — mature MoMo infrastructure (MTN, Telecel, AirtelTigo)
- **Clear regulatory path** — SEC Ghana and GSE have battle-tested fintech frameworks
- **Gateway to West Africa** — Ghana as launchpad for ECOWAS and AfCFTA expansion

---

## Vision

> "Every Ghanaian with a phone should be able to own a piece of Ghana's economy."

We are building the easiest, cheapest, most accessible way to trade GSE equities. Start with Ghana. Expand to Malawi Stock Exchange, Nigerian Exchange, and Nairobi Securities Exchange within 18 months.

---

## Core Features

### Phase 1 — MVP (Months 1–3)
- [ ] GSE market data dashboard (real-time & delayed quotes)
- [ ] User registration & KYC (Ghana Card integration)
- [ ] Mobile money deposit & withdrawal (MTN MoMo, Telecel Cash, AirtelTigo Money)
- [ ] Basic buy/sell orders (market & limit)
- [ ] Portfolio tracking & transaction history
- [ ] Push notifications for order execution & price alerts

### Phase 2 — Growth (Months 4–8)
- [ ] Fixed income instruments (Government of Ghana bonds, Treasury bills)
- [ ] IPO subscription portal (retail participation in new listings)
- [ ] Social features (watchlists, leaderboards, trading activity feed)
- [ ] AI-powered market summaries (daily GSE briefing)
- [ ] Referral programme with MoMo rewards
- [ ] Savings feature ("Round-up to invest")

### Phase 3 — Pan-African (Months 9–18)
- [ ] Multi-exchange support (Malawi MSE, Nigeria NGX, Kenya NSE)
- [ ] Currency conversion layer (GHG ↔ MWK ↔ NGN ↔ KES)
- [ ] Cross-border portfolio view
- [ ] API for third-party integrations

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Frontend** | Next.js 15 (React, TypeScript, Tailwind CSS) |
| **Mobile** | React Native (iOS & Android) — Phase 2 |
| **Backend API** | Next.js API Routes + tRPC |
| **Database** | PostgreSQL (Supabase) |
| **Auth** | Supabase Auth + Ghana Card (NIA) verification |
| **Payments** | MTN MoMo API, Telecel Cash API, AirtelTigo API |
| **Market Data** | GSE data feed (direct or licensed provider) |
| **Hosting** | Vercel (frontend) + Supabase (backend) |
| **CI/CD** | GitHub Actions |
| **Monitoring** | Sentry + Supabase Dashboard |

---

## Revenue Model

| Stream | Description |
|---|---|
| **Trading commissions** | 1.5% per trade (buy or sell), capped at GHS 10 |
| **Spread markup** | 0.5% on market orders |
| **Withdrawal fees** | GHS 1 per MoMo withdrawal |
| **IPO facilitation fee** | 1% of IPO subscription value |
| **Premium tier** | GHS 15/month — real-time quotes, advanced charts, no commission cap removal |
| **B2B API** | Licensed market data access for partners |

### Unit Economics Target (Year 1)

| Metric | Target |
|---|---|
| Registered users | 10,000 |
| Active monthly traders | 3,000 |
| Avg trades/user/month | 4 |
| Avg trade value | GHS 200 |
| Monthly revenue (steady state) | ~GHS 45,000 |
| MoMo deposit success rate | >95% |
| Customer support tickets/week | <50 |

---

## Regulatory Pathway

### Required Licences & Registrations

1. **Registrar General's Department** — Company incorporation (Ghana Enterprises Agency)
2. **SEC Ghana** — Securities dealer licence or partnering with a licensed broker
3. **Bank of Ghana** — Payment service provider approval (if holding client funds)
4. **Ghana Interbank Payment & Settlement Systems (GhIPSS)** — For mobile money settlement
5. **Data Protection Commission** — DPA registration for handling personal data
6. **National Communications Authority** — For USSD/SMS notifications (if applicable)

### Recommended Approach
Partner with an existing **licensed broker-dealer** initially (e.g., Databank, IC Securities, or CalBank's brokerage arm) to handle trade execution and settlement. This lets us launch faster while pursuing our own SEC dealer licence in parallel.

---

## Market Context

### Key GSE Listings (June 2026)
| Company | Ticker | Sector |
|---|---|---|
| MTN Ghana | MTNGH | Telecoms |
| AngloGold Ashanti | AADs | Mining |
| Tullow Oil | TLW | Oil & Gas |
| GCB Bank | GCB | Banking |
| TotalEnergies Marketing | TOTAL | Oil & Kasapreko* | KASAP* | Beverages (*IPO pending) |

> *Note: Verify current GSE listing status before building data models.*

### Competitors & Differentiation

| Competitor | Weakness | Our Edge |
|---|---|---|
| Databank (eStock) | Desktop-first, high fees, complex UX | Mobile-first, lower fees, simpler |
| IC Securities | Institutional focus, not retail | Built for retail traders |
| Bamboo / Chipper | Focus on US stocks, not GSE | GSE-native, MoMo-native |
| Local bank apps | Limited trading, no real-time data | Purpose-built trading experience |

---

## Broker Partnership Roadmap

Recommended approach: partner with an existing licensed dealer member while pursuing our own SEC licence in parallel (two-track strategy).

### Recommended Partner Shortlist

| Broker | Why | Contact Approach |
|---|---|---|
| **Databank Brokerage** | Already runs eStock digital platform; understands fintech partnerships | Direct approach via Databank Group CEO office |
| **IC Securities** | Growing retail presence; IC Group backing; innovation-friendly | Approach via IC Securities MD |
| **CalBank Brokerage** | Banking parent; MoMo settlement infrastructure | CalBank corporate development |

### Phased Approach

| Phase | Timeline | Activity |
|---|---|---|
| **Phase 1: Target Mapping** | Weeks 1–4 | Formalise shortlist of all SEC-registered dealer members; engage Ghanaian legal counsel; prepare partnership pitch deck |
| **Phase 2: Negotiation** | Weeks 5–8 | Present technical architecture and MoMo integration plan; negotiate revenue share (suggest 60/40 in favour of technology partner); draft partnership agreement |
| **Phase 3: Integration** | Weeks 9–12 | Integrate with partner broker's trading systems; configure mobile money payment rails; pilot with limited user group (50–100 beta testers) |

## Data Feed Strategy

GSE offers multiple data tiers. For V1.0.0:

| Tier | Scope | Cost |
|---|---|---|
| **End of Day Index Data** | GSE Composite Index closing values | GHS 2,500/year |
| **Individual Company EOD** | Listed company prices, financials, market cap | GHS 1,000/month (GHS 12,000/year) |
| **Total V1.0.0 data budget** | Index + all listed companies | **~GHS 14,500/year (~USD 8,500)** |

Real-time data (GHS 40,000/year) is deferred to V2. Actual broker partners may provide delayed data as part of the partnership arrangement — confirm during negotiation.

```
┌─────────────────────────────────────────────┐
│                  Next.js App                 │
│  ┌─────────┐ ┌──────────┐ ┌──────────────┐  │
│  │Web App  │ │Admin     │ │API Routes /  │  │
│  │(React)  │ │Dashboard │ │tRPC          │  │
│  └─────────┘ └──────────┘ └──────────────┘  │
└──────────────────┬──────────────────────────┘
                   │
        ┌──────────┼──────────────┐
        │          │              │
   ┌────▼───┐ ┌───▼────┐  ┌──────▼──────┐
   │Supabase│ │MoMo    │ │  GSE Market  │
   │(Auth + │ │APIs    │ │  Data Feed   │
   │   DB)  │ │(MTN,   │ │  (Broker or  │
   │        │ │Telecel,│ │  Direct GSE) │
   │        │ │Airtel) │ │              │
   └────────┘ └────────┘  └──────────────┘
```

---

## Getting Started

### Prerequisites
- Node.js 20+
- npm or pnpm
- Supabase account
- MTN MoMo developer account

### Installation

```bash
git clone https://github.com/Oswald-Benjamin/afritrade-ghana.git
cd afritrade-ghana
npm install

# Copy environment template
cp .env.example .env.local

# Run database migrations
npx supabase db push

# Start development server
npm run dev
```

### Environment Variables
See `.env.example` for all required keys.

---

## Risk Analysis

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| **Regulatory delays** (SEC licence) | Medium | High | Two-track strategy: partner broker first, pursue own licence in parallel |
| **MoMo API downtime** | Low | High | Multi-provider integration (MTN primary, Telecel V2); graceful error handling |
| **Low user adoption** | Medium | High | Education-first onboarding; simulated trading mode; low minimums |
| **Data feed cost overrun** | Low | Medium | Start with EOD data only; negotiate partner-provided data |
| **Broker partner negotiation failure** | Medium | High | Three-broker shortlist; fallback to direct SEC licence application |
| **Currency/inflation risk** | Medium | Low | GHS-denominated; transparent fee communication |

## Estimated Capital Requirements (18 months, V1.0.0 + buffer)

| Item | Cost (USD) |
|---|---|
| Legal & regulatory (Ghanaian counsel, SEC applications) | 15,000–25,000 |
| Platform development (web app, backend, APIs) | 40,000–60,000 |
| MoMo integration & testing | 8,000–12,000 |
| GSE data feed (EOD, 18 months) | 10,000–15,000 |
| Compliance infrastructure (KYC/AML, audit) | 10,000–15,000 |
| Marketing & user acquisition | 15,000–25,000 |
| Operational reserve | 20,000–30,000 |
| **Total** | **118,000–182,000** |

---

## Roadmap

### V1.0.0 — Closed Beta (Target: September 1, 2026)

**Scope: A real user can sign up, fund via MoMo, and place trades.**

| # | Feature | Priority |
|---|---|---|
| 1 | User auth (signup, signin, session management) | P0 |
| 2 | KYC gate (Ghana Card ID capture, manual review queue) | P0 |
| 3 | GSE market data (EOD feed: index + listed company prices) | P0 |
| 4 | MTN MoMo deposit (real API, request-to-pay flow) | P0 |
| 5 | Buy market orders (execution logic, simulated settlement) | P0 |
| 6 | Portfolio view (positions, cash balance, P&L) | P0 |
| 7 | Transaction history | P0 |
| 8 | Basic admin dashboard (user list, order ledger) | P0 |
| 9 | Sell market orders | P1 |
| 10 | Limit orders | P1 |
| 11 | Price alerts (above/below, email notification) | P1 |
| 12 | Market intelligence layer (company fundamentals, sector data) | P1 |

**Explicitly NOT in V1.0.0:**
- IPO subscriptions → V2
- Fixed income (GoG bonds, T-bills) → V2
- React Native mobile app → V2
- Multi-exchange (Malawi, Nigeria, Kenya) → V2
- Diaspora features (multi-currency, family accounts) → V2
- Social features (watchlists, leaderboards) → V2
- AI market summaries → V2
- Shareholder voting platform → V2
- Bilingual UI (Twi) → V2
- Financial literacy hub → V2
- Simulated trading mode → V2

### V2.0.0 — Public Launch (Target: Q1 2027)

- IPO subscription portal
- Fixed income instruments
- React Native mobile app (iOS + Android)
- Bilingual UI (English + Twi)
- Diaspora onboarding (GBP/USD corridors)
- Financial literacy hub
- Simulated trading mode
- Social features

### V3.0.0 — Pan-African (Target: Q3 2027)

- Multi-exchange: Malawi MSE, Nigeria NGX, Kenya NSE
- Currency conversion layer
- Cross-border portfolio view
- Shareholder voting platform
- AI-powered market summaries

---

| Quarter | Milestone |
|---|---|
| **Q3 2026** | Core platform development, Supabase + Next.js MVP |
| **Q4 2026** | SEC/Broker partnership, MoMo integration, closed beta |
| **Q1 2027** | Public launch in Ghana, 5,000 users target |
| **Q2 2027** | IPO portal, fixed income, premium tier |
| **Q3 2027** | React Native mobile app, Malawi MSE integration |
| **Q4 2027** | Nigeria NGX, Kenya NSE — pan-African live |

---

## Contributing

This is a private venture. Contributions are by invitation only.

For enquiries, contact: **oswald@cryptosi.org**

---

## Licence

Proprietary — All rights reserved.

---

*Built by the Crypto SI team. AfriTrade Ghana is a product of Webara Studio.*
