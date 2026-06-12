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

## Architecture

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

## Roadmap

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
