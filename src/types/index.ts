// AfriTrade Ghana — Core Type Definitions

// ─── User & Auth ──────────────────────────────────────────────

export interface User {
  id: string
  email: string
  phone: string
  full_name: string
  ghana_card_id: string | null
  kyc_status: KycStatus
  kyc_verified_at: string | null
  created_at: string
  updated_at: string
}

export type KycStatus = 'pending' | 'verified' | 'rejected' | 'expired'

export interface UserProfile {
  user_id: string
  display_name: string
  avatar_url: string | null
  preferred_language: 'en' | 'tw' | 'ga' | 'ha'
  notification_preferences: NotificationPreferences
}

export interface NotificationPreferences {
  email: boolean
  push: boolean
  sms: boolean
  price_alerts: boolean
  order_updates: boolean
  market_news: boolean
}

// ─── Market Data ──────────────────────────────────────────────

export interface Stock {
  ticker: string
  name: string
  sector: Sector
  current_price: number
  previous_close: number
  change: number
  change_percent: number
  volume: number
  market_cap: number | null
  high_52w: number | null
  low_52w: number | null
  last_updated: string
}

export type Sector =
  | 'banking'
  | 'telecoms'
  | 'mining'
  | 'oil_gas'
  | 'manufacturing'
  | 'beverages'
  | 'insurance'
  | 'agriculture'
  | 'utilities'
  | 'other'

export interface MarketSummary {
  gse_composite_index: number
  composite_change: number
  composite_change_percent: number
  total_volume: number
  total_value: number
  advancing: number
  declining: number
  unchanged: number
  date: string
}

export interface PricePoint {
  timestamp: string
  open: number
  high: number
  low: number
  close: number
  volume: number
}

export type TimeRange = '1D' | '1W' | '1M' | '3M' | '1Y' | 'ALL'

// ─── Trading ──────────────────────────────────────────────────

export interface Order {
  id: string
  user_id: string
  ticker: string
  type: OrderType
  side: OrderSide
  quantity: number
  price: number | null // null for market orders
  status: OrderStatus
  filled_quantity: number
  filled_price: number | null
  commission: number
  created_at: string
  updated_at: string
}

export type OrderType = 'market' | 'limit'
export type OrderSide = 'buy' | 'sell'
export type OrderStatus =
  | 'pending'
  | 'submitted'
  | 'partially_filled'
  | 'filled'
  | 'cancelled'
  | 'rejected'
  | 'expired'

export interface Position {
  user_id: string
  ticker: string
  stock_name: string
  quantity: number
  average_cost: number
  current_price: number
  market_value: number
  unrealized_pnl: number
  unrealized_pnl_percent: number
}

export interface PortfolioSummary {
  total_value: number
  cash_balance: number
  invested_value: number
  total_pnl: number
  total_pnl_percent: number
  day_pnl: number
  day_pnl_percent: number
  positions: Position[]
}

export interface Transaction {
  id: string
  user_id: string
  type: TransactionType
  amount: number
  currency: 'GHS'
  status: TransactionStatus
  reference: string | null
  metadata: Record<string, unknown> | null
  created_at: string
}

export type TransactionType =
  | 'deposit'
  | 'withdrawal'
  | 'trade_buy'
  | 'trade_sell'
  | 'commission'
  | 'ipo_subscription'
  | 'dividend'

export type TransactionStatus = 'pending' | 'completed' | 'failed' | 'reversed'

// ─── Mobile Money ─────────────────────────────────────────────

export interface MomoTransaction {
  id: string
  user_id: string
  provider: MomoProvider
  type: 'deposit' | 'withdrawal'
  amount: number
  phone: string
  reference: string
  external_reference: string | null
  status: MomoStatus
  created_at: string
  completed_at: string | null
}

export type MomoProvider = 'mtn' | 'telecel' | 'airteltigo'
export type MomoStatus =
  | 'initiated'
  | 'pending_confirmation'
  | 'completed'
  | 'failed'
  | 'timed_out'

export interface MomoQuote {
  amount: number
  fee: number
  total: number
  estimated_seconds: number
}

// ─── IPOs ─────────────────────────────────────────────────────

export interface IPO {
  id: string
  ticker: string
  company_name: string
  sector: Sector
  offer_price: number
  offer_size: number
  opens_at: string
  closes_at: string
  listing_date: string
  status: IPOStatus
  oversubscription_ratio: number | null
  description: string | null
}

export type IPOStatus =
  | 'upcoming'
  | 'open'
  | 'closed'
  | 'allocated'
  | 'listed'
  | 'cancelled'

export interface IPOSubscription {
  id: string
  user_id: string
  ipo_id: string
  shares: number
  amount: number
  status: 'pending' | 'confirmed' | 'allocated' | 'refunded'
  created_at: string
}

// ─── Price Alerts ─────────────────────────────────────────────

export interface PriceAlert {
  id: string
  user_id: string
  ticker: string
  condition: 'above' | 'below'
  target_price: number
  is_active: boolean
  triggered_at: string | null
  created_at: string
}
