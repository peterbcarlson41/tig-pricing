# DexScreener Data Collection

This project automatically fetches and stores DEX pair data from DexScreener API, specifically tracking the BASE/USDC pair at address `0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA`. The data is stored in a PostgreSQL database hosted on DigitalOcean.

## Features

- Automated data collection every 5 minutes using PM2
- Stores comprehensive pair data including:
  - Price (native and USD)
  - Volume metrics (5m, 1h, 6h, 24h)
  - Price changes
  - Transaction counts
  - Liquidity information
- Historical price and volume tracking
- Runs on a DigitalOcean Droplet for reliability

## Setup

### Prerequisites

- Python 3.9 or higher
- DigitalOcean account
- PM2 (for process management)
- Basic Droplet with Ubuntu

### Installation

1. Set up your Droplet:

```bash
# Update system
sudo apt update
sudo apt upgrade -y

# Install Python and dependencies
sudo apt install python3-pip -y
pip3 install psycopg2-binary requests python-dotenv

# Install Node.js and PM2
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
npm install -g pm2
```

2. Set up your environment variables in `.env`:

```
DB_HOST=your-db-cluster.db.ondigitalocean.com
DB_PORT=25060
DB_NAME=defaultdb
DB_USER=doadmin
DB_PASSWORD=your-password
```

3. Create the database tables:

```sql
CREATE TABLE pair_data_recent (
    timestamp TIMESTAMPTZ PRIMARY KEY,
    chain_id TEXT,
    dex_id TEXT,
    url TEXT,
    pair_address TEXT,
    price_native NUMERIC,
    price_usd NUMERIC,
    fdv NUMERIC,
    market_cap NUMERIC,
    pair_created_at TEXT,
    volume_m5 NUMERIC,
    volume_h1 NUMERIC,
    volume_h6 NUMERIC,
    volume_h24 NUMERIC,
    price_change_m5 NUMERIC,
    price_change_h1 NUMERIC,
    price_change_h6 NUMERIC,
    price_change_h24 NUMERIC,
    txns_m5_buys INTEGER,
    txns_m5_sells INTEGER,
    txns_h1_buys INTEGER,
    txns_h1_sells INTEGER,
    txns_h6_buys INTEGER,
    txns_h6_sells INTEGER,
    txns_h24_buys INTEGER,
    txns_h24_sells INTEGER,
    liquidity_usd NUMERIC,
    liquidity_base NUMERIC,
    liquidity_quote NUMERIC
);

CREATE TABLE price_volume_history (
    timestamp TIMESTAMPTZ PRIMARY KEY,
    price_usd NUMERIC,
    volume_h24 NUMERIC
);
```

### Running the Script

Start the script with PM2:

```bash
pm2 start script.py --interpreter python3 --name "dex-scraper"
pm2 save
pm2 startup
```

Monitor the script:

```bash
pm2 logs dex-scraper    # View logs
pm2 status              # Check status
pm2 restart dex-scraper # Restart if needed
```

## Database Schema

### Table: pair_data_recent

Stores the most recent pair data including:

- Timestamps
- Prices (native and USD)
- Volume metrics
- Transaction counts
- Liquidity information

### Table: price_volume_history

Stores historical price and volume data:

- Timestamp
- USD price
- 24-hour volume

## Error Handling

The script includes comprehensive error handling and logging:

- Failed API requests are logged
- Database connection issues are captured
- Data validation errors are reported
- All operations are logged with timestamps

## Security

- Database access is restricted by IP using DigitalOcean's Trusted Sources
- SSL is required for database connections
- Credentials are stored in environment variables
- Running on a dedicated Droplet instead of shared runners

## Troubleshooting

If the script isn't running:

1. Check PM2 logs: `pm2 logs dex-scraper`
2. Verify database connectivity
3. Check environment variables
4. Ensure Python dependencies are installed
5. Verify Droplet has internet access

Common issues:

- Database connection timeout: Check trusted sources
- API rate limiting: Verify POLL_INTERVAL
- Process crashes: Check PM2 logs for errors

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - feel free to use and modify as needed.
