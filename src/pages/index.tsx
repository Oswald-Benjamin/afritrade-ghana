import type { NextPage } from 'next'
import Head from 'next/head'

const DashboardPage: NextPage = () => {
  return (
    <>
      <Head>
        <title>AfriTrade Ghana — Dashboard</title>
        <meta name="description" content="Trade the Ghana Stock Exchange" />
      </Head>

      <main className="min-h-screen">
        {/* Placeholder — dashboard components built in Phase 2 */}
        <div className="max-w-7xl mx-auto px-4 py-8">
          <h1 className="text-3xl font-bold text-brand-gold mb-2">
            Welcome to AfriTrade Ghana
          </h1>
          <p className="text-cream/60 mb-8">
            Your dashboard is being built. Check back soon.
          </p>

          <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
            <div className="card">
              <p className="text-cream/60 text-sm">Portfolio Value</p>
              <p className="text-2xl font-bold">GHS —</p>
            </div>
            <div className="card">
              <p className="text-cream/60 text-sm">Day P&L</p>
              <p className="text-2xl font-bold text-market-up">—</p>
            </div>
            <div className="card">
              <p className="text-cream/60 text-sm">Cash Balance</p>
              <p className="text-2xl font-bold">GHS —</p>
            </div>
          </div>

          <div className="card">
            <h2 className="text-lg font-semibold mb-4">Market Overview</h2>
            <p className="text-cream/60">
              GSE Composite Index data will appear here.
            </p>
          </div>
        </div>
      </main>
    </>
  )
}

export default DashboardPage
