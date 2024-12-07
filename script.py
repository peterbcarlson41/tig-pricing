import requests
import logging
import time
from datetime import datetime, timezone
from supabase import create_client
from typing import Optional
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Constants
URL = "https://api.dexscreener.com/latest/dex/pairs/base/0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA"
POLL_INTERVAL = 300  # 5 minutes in seconds

# Supabase setup
SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_KEY')

if not SUPABASE_URL or not SUPABASE_KEY:
    raise ValueError("Missing Supabase credentials in .env file")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

def fetch_data() -> Optional[dict]:
    try:
        response = requests.get(URL)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logging.error(f"Error fetching data: {e}")
        return None

def insert_data(data: dict) -> None:
    if not data or 'pairs' not in data or not data['pairs']:
        logging.warning("No valid data to insert")
        return

    pair = data['pairs'][0]
    timestamp = datetime.now(timezone.utc).isoformat()

    # Prepare data for pair_data_recent table
    pair_data = {
        'timestamp': timestamp,
        'chain_id': pair['chainId'],
        'dex_id': pair['dexId'],
        'url': pair['url'],
        'pair_address': pair['pairAddress'],
        'price_native': pair['priceNative'],
        'price_usd': pair['priceUsd'],
        'fdv': pair['fdv'],
        'market_cap': pair['marketCap'],
        'pair_created_at': pair['pairCreatedAt'],
        'volume_m5': pair['volume'].get('m5'),
        'volume_h1': pair['volume'].get('h1'),
        'volume_h6': pair['volume'].get('h6'),
        'volume_h24': pair['volume'].get('h24'),
        'price_change_m5': pair['priceChange'].get('m5'),
        'price_change_h1': pair['priceChange'].get('h1'),
        'price_change_h6': pair['priceChange'].get('h6'),
        'price_change_h24': pair['priceChange'].get('h24'),
        'txns_m5_buys': pair['txns']['m5']['buys'],
        'txns_m5_sells': pair['txns']['m5']['sells'],
        'txns_h1_buys': pair['txns']['h1']['buys'],
        'txns_h1_sells': pair['txns']['h1']['sells'],
        'txns_h6_buys': pair['txns']['h6']['buys'],
        'txns_h6_sells': pair['txns']['h6']['sells'],
        'txns_h24_buys': pair['txns']['h24']['buys'],
        'txns_h24_sells': pair['txns']['h24']['sells'],
        'liquidity_usd': pair['liquidity']['usd'],
        'liquidity_base': pair['liquidity']['base'],
        'liquidity_quote': pair['liquidity']['quote']
    }

    # Prepare data for price_volume_history table
    # Prepare data for price_volume_history table
    price_volume_data = {
        'timestamp': timestamp,
        'price_usd': pair['priceUsd'],  # Changed from priceUsd
        'volume_h24': pair['volume'].get('h24')
    }

    try:
        # Insert into pair_data_recent
        supabase.table('pair_data_recent').upsert(pair_data).execute()

        # Insert into price_volume_history
        supabase.table('price_volume_history').upsert(price_volume_data).execute()

        logging.info(f"Data inserted for timestamp: {timestamp}")
    except Exception as e:
        logging.error(f"Error inserting data to Supabase: {e}")

def get_recent_data():
    try:
        response = supabase.table('pair_data_recent')\
            .select('*')\
            .order('timestamp', desc=True)\
            .limit(1)\
            .execute()
        return response.data[0] if response.data else None
    except Exception as e:
        logging.error(f"Error fetching recent data: {e}")
        return None

def get_historical_data(start_date: str, end_date: str):
    try:
        response = supabase.table('price_volume_history')\
            .select('timestamp, price_usd, volume_h24')\
            .gte('timestamp', start_date)\
            .lte('timestamp', end_date)\
            .order('timestamp')\
            .execute()
        return response.data
    except Exception as e:
        logging.error(f"Error fetching historical data: {e}")
        return []

def main():
    logging.info(f"Fetching and inserting data...")
    data = fetch_data()
    if data:
        insert_data(data)
        logging.info("Data collection complete.")
    else:
        logging.error("No data fetched.")


if __name__ == "__main__":
    main()