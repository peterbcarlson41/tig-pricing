import requests
import sqlite3
import logging
import time
from datetime import datetime, timezone

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# API endpoint
URL = "https://api.dexscreener.com/latest/dex/pairs/base/0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA"

# Database setup
DB_NAME = "dexscreener_data.db"

def create_tables():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    
    # Main pair data table (for most recent data)
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS pair_data_recent (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp TEXT,
        chainId TEXT,
        dexId TEXT,
        url TEXT,
        pairAddress TEXT,
        priceNative TEXT,
        priceUsd TEXT,
        fdv REAL,
        marketCap REAL,
        pairCreatedAt INTEGER,
        volume_m5 REAL,
        volume_h1 REAL,
        volume_h6 REAL,
        volume_h24 REAL,
        priceChange_m5 REAL,
        priceChange_h1 REAL,
        priceChange_h6 REAL,
        priceChange_h24 REAL,
        txns_m5_buys INTEGER,
        txns_m5_sells INTEGER,
        txns_h1_buys INTEGER,
        txns_h1_sells INTEGER,
        txns_h6_buys INTEGER,
        txns_h6_sells INTEGER,
        txns_h24_buys INTEGER,
        txns_h24_sells INTEGER,
        liquidity_usd REAL,
        liquidity_base REAL,
        liquidity_quote REAL
    )
    ''')

    # Historical price and volume data table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS price_volume_history (
        timestamp TEXT,
        priceUsd TEXT,
        volume_h24 REAL,
        PRIMARY KEY (timestamp)
    )
    ''')

    # Token tables
    for token_type in ['base', 'quote']:
        cursor.execute(f'''
        CREATE TABLE IF NOT EXISTS {token_type}_token (
            pair_id INTEGER,
            address TEXT,
            name TEXT,
            symbol TEXT,
            FOREIGN KEY (pair_id) REFERENCES pair_data_recent (id)
        )
        ''')

    # Create indexes for faster queries
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_price_volume_history_timestamp ON price_volume_history (timestamp)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_price_volume_history_price ON price_volume_history (priceUsd)')
    cursor.execute('CREATE INDEX IF NOT EXISTS idx_price_volume_history_volume ON price_volume_history (volume_h24)')

    conn.commit()
    conn.close()

def fetch_data():
    try:
        response = requests.get(URL)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        logging.error(f"Error fetching data: {e}")
        return None

def insert_data(data):
    if not data or 'pairs' not in data or not data['pairs']:
        logging.warning("No valid data to insert")
        return

    pair = data['pairs'][0]
    timestamp = datetime.now(timezone.utc).isoformat()

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    # Insert into pair_data_recent (replacing any existing record)
    cursor.execute('''
    INSERT OR REPLACE INTO pair_data_recent (
        timestamp, chainId, dexId, url, pairAddress, priceNative, priceUsd, 
        fdv, marketCap, pairCreatedAt, 
        volume_m5, volume_h1, volume_h6, volume_h24,
        priceChange_m5, priceChange_h1, priceChange_h6, priceChange_h24,
        txns_m5_buys, txns_m5_sells, txns_h1_buys, txns_h1_sells,
        txns_h6_buys, txns_h6_sells, txns_h24_buys, txns_h24_sells,
        liquidity_usd, liquidity_base, liquidity_quote
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        timestamp, pair['chainId'], pair['dexId'], pair['url'], pair['pairAddress'],
        pair['priceNative'], pair['priceUsd'], pair['fdv'], pair['marketCap'], pair['pairCreatedAt'],
        pair['volume'].get('m5'), pair['volume'].get('h1'), pair['volume'].get('h6'), pair['volume'].get('h24'),
        pair['priceChange'].get('m5'), pair['priceChange'].get('h1'), pair['priceChange'].get('h6'), pair['priceChange'].get('h24'),
        pair['txns']['m5']['buys'], pair['txns']['m5']['sells'],
        pair['txns']['h1']['buys'], pair['txns']['h1']['sells'],
        pair['txns']['h6']['buys'], pair['txns']['h6']['sells'],
        pair['txns']['h24']['buys'], pair['txns']['h24']['sells'],
        pair['liquidity']['usd'], pair['liquidity']['base'], pair['liquidity']['quote']
    ))

    # Insert into price_volume_history
    cursor.execute('''
    INSERT OR REPLACE INTO price_volume_history (timestamp, priceUsd, volume_h24)
    VALUES (?, ?, ?)
    ''', (timestamp, pair['priceUsd'], pair['volume'].get('h24')))

    conn.commit()
    conn.close()
    logging.info(f"Data inserted for timestamp: {timestamp}")

def get_recent_data():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM pair_data_recent ORDER BY timestamp DESC LIMIT 1")
    result = cursor.fetchone()
    conn.close()
    return result

def get_historical_data(start_date, end_date):
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("""
    SELECT timestamp, priceUsd, volume_h24
    FROM price_volume_history
    WHERE timestamp BETWEEN ? AND ?
    ORDER BY timestamp
    """, (start_date, end_date))
    results = cursor.fetchall()
    conn.close()
    return results

def main():
    create_tables()
    while True:
        data = fetch_data()
        if data:
            insert_data(data)
        time.sleep(60) 

if __name__ == "__main__":
    main()