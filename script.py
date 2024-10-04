import requests
import sqlite3
import time
import logging
import json
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
    
    # Main pair data table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS pair_data (
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
        pairCreatedAt INTEGER
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
            FOREIGN KEY (pair_id) REFERENCES pair_data (id)
        )
        ''')

    # Transactions table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS transactions (
        pair_id INTEGER,
        timeframe TEXT,
        buys INTEGER,
        sells INTEGER,
        FOREIGN KEY (pair_id) REFERENCES pair_data (id)
    )
    ''')

    # Volume table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS volume (
        pair_id INTEGER,
        timeframe TEXT,
        amount REAL,
        FOREIGN KEY (pair_id) REFERENCES pair_data (id)
    )
    ''')

    # Price change table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS price_change (
        pair_id INTEGER,
        timeframe TEXT,
        change REAL,
        FOREIGN KEY (pair_id) REFERENCES pair_data (id)
    )
    ''')

    # Liquidity table
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS liquidity (
        pair_id INTEGER,
        usd REAL,
        base REAL,
        quote REAL,
        FOREIGN KEY (pair_id) REFERENCES pair_data (id)
    )
    ''')

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

    # Insert main pair data
    cursor.execute('''
    INSERT INTO pair_data (timestamp, chainId, dexId, url, pairAddress, priceNative, priceUsd, fdv, marketCap, pairCreatedAt)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', (
        timestamp, pair['chainId'], pair['dexId'], pair['url'], pair['pairAddress'],
        pair['priceNative'], pair['priceUsd'], pair['fdv'], pair['marketCap'], pair['pairCreatedAt']
    ))
    pair_id = cursor.lastrowid

    # Insert token data
    for token_type in ['base', 'quote']:
        token = pair[f'{token_type}Token']
        cursor.execute(f'''
        INSERT INTO {token_type}_token (pair_id, address, name, symbol)
        VALUES (?, ?, ?, ?)
        ''', (pair_id, token['address'], token['name'], token['symbol']))

    # Insert transactions data
    for timeframe, txn_data in pair['txns'].items():
        cursor.execute('''
        INSERT INTO transactions (pair_id, timeframe, buys, sells)
        VALUES (?, ?, ?, ?)
        ''', (pair_id, timeframe, txn_data['buys'], txn_data['sells']))

    # Insert volume data
    for timeframe, volume in pair['volume'].items():
        cursor.execute('''
        INSERT INTO volume (pair_id, timeframe, amount)
        VALUES (?, ?, ?)
        ''', (pair_id, timeframe, volume))

    # Insert price change data
    for timeframe, change in pair['priceChange'].items():
        cursor.execute('''
        INSERT INTO price_change (pair_id, timeframe, change)
        VALUES (?, ?, ?)
        ''', (pair_id, timeframe, change))

    # Insert liquidity data
    liquidity = pair['liquidity']
    cursor.execute('''
    INSERT INTO liquidity (pair_id, usd, base, quote)
    VALUES (?, ?, ?, ?)
    ''', (pair_id, liquidity['usd'], liquidity['base'], liquidity['quote']))

    conn.commit()
    conn.close()
    logging.info(f"Data inserted for timestamp: {timestamp}")

def main():
    create_tables()
    while True:
        data = fetch_data()
        if data:
            insert_data(data)
        time.sleep(60)  # Wait for 60 seconds

if __name__ == "__main__":
    main()