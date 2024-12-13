import requests
import logging
import time
from datetime import datetime, timezone
import psycopg2
from psycopg2.extras import RealDictCursor
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

# Database setup
DB_HOST = os.getenv('DB_HOST')
DB_PORT = os.getenv('DB_PORT', '25060')  # DO's default port
DB_NAME = os.getenv('DB_NAME', 'defaultdb')
DB_USER = os.getenv('DB_USER', 'doadmin')
DB_PASSWORD = os.getenv('DB_PASSWORD')

if not DB_HOST or not DB_PASSWORD:
    raise ValueError("Missing database credentials in .env file")

def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        port=DB_PORT,
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        sslmode='require'  # Digital Ocean requires SSL
    )

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
    price_volume_data = {
        'timestamp': timestamp,
        'price_usd': pair['priceUsd'],
        'volume_h24': pair['volume'].get('h24')
    }

    try:
        with get_db_connection() as conn:
            with conn.cursor() as cur:
                # Insert into pair_data_recent
                columns = pair_data.keys()
                values = [pair_data[column] for column in columns]
                insert_query = f"""
                    INSERT INTO pair_data_recent ({', '.join(columns)})
                    VALUES ({', '.join(['%s'] * len(columns))})
                """
                cur.execute(insert_query, values)

                # Insert into price_volume_history
                columns = price_volume_data.keys()
                values = [price_volume_data[column] for column in columns]
                insert_query = f"""
                    INSERT INTO price_volume_history ({', '.join(columns)})
                    VALUES ({', '.join(['%s'] * len(columns))})
                """
                cur.execute(insert_query, values)

            conn.commit()
            logging.info(f"Data inserted for timestamp: {timestamp}")
    except Exception as e:
        logging.error(f"Error inserting data to database: {e}")

def get_recent_data():
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute("""
                    SELECT * FROM pair_data_recent
                    ORDER BY id DESC
                    LIMIT 1
                """)
                return cur.fetchone()
    except Exception as e:
        logging.error(f"Error fetching recent data: {e}")
        return None

def get_historical_data(start_date: str, end_date: str):
    try:
        with get_db_connection() as conn:
            with conn.cursor(cursor_factory=RealDictCursor) as cur:
                cur.execute("""
                    SELECT id, timestamp, price_usd, volume_h24
                    FROM price_volume_history
                    WHERE timestamp BETWEEN %s AND %s
                    ORDER BY id ASC
                """, (start_date, end_date))
                return cur.fetchall()
    except Exception as e:
        logging.error(f"Error fetching historical data: {e}")
        return []

def main():
    while True:
        try:
            print("Running data collection...") 
            logging.info("Fetching and inserting data...")
            data = fetch_data()
            if data:
                insert_data(data)
                logging.info("Data collection complete.")
            else:
                logging.error("No data fetched.")
            
            # Wait for POLL_INTERVAL seconds before next iteration
            time.sleep(POLL_INTERVAL)
            
        except Exception as e:
            logging.error(f"Error in main loop: {e}")
            # Still wait before retrying even if there's an error
            time.sleep(POLL_INTERVAL)

if __name__ == "__main__":
    main()