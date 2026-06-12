/** @type {import('tailwindcss').Config} */
export default {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        // Webara Studio brand colours
        brand: {
          dark: '#131c20',
          gold: '#e0b152',
          cream: '#e4ddcd',
          card: '#223239',
        },
        // Trading-specific colours
        market: {
          up: '#22c55e',
          down: '#ef4444',
          neutral: '#6b7280',
        },
      },
      fontFamily: {
        sans: ['Inter', 'system-ui', 'sans-serif'],
        mono: ['JetBrains Mono', 'monospace'],
      },
    },
  },
  plugins: [],
}
