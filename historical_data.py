import sqlite3
import json
import logging
import os
from datetime import datetime, timezone

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Database name (should be the same as in your main script)
DB_NAME = "dexscreener_data.db"

# JSON file name
JSON_FILE = "historical_data.json"

def unix_to_iso(unix_timestamp):
    """Convert Unix timestamp to ISO format string."""
    return datetime.fromtimestamp(int(unix_timestamp), tz=timezone.utc).isoformat()

def recreate_table():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    try:
        # Drop the existing table if it exists
        cursor.execute("DROP TABLE IF EXISTS historical_price_data")
        logging.info("Dropped existing historical_price_data table.")

        # Create a new table with the correct structure
        cursor.execute('''
        CREATE TABLE historical_price_data (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pair_address TEXT,
            timestamp TEXT,
            price_usd REAL,
            UNIQUE(pair_address, timestamp)
        )
        ''')
        logging.info("Created new historical_price_data table with correct structure.")

        conn.commit()
    except sqlite3.Error as e:
        logging.error(f"Database error: {e}")
        conn.rollback()
        return False
    finally:
        conn.close()

    return True

def populate_historical_price_data():
    if not os.path.exists(JSON_FILE):
        logging.error(f"JSON file '{JSON_FILE}' not found in the current directory.")
        return

    try:
        with open(JSON_FILE, 'r') as file:
            data = json.load(file)
    except json.JSONDecodeError:
        logging.error(f"Error decoding JSON from file '{JSON_FILE}'. Please check the file format.")
        return

    try:
        pair_address = data['data']['token']['address']
        price_history = data['data']['token']['market']['priceHistory']
    except KeyError as e:
        logging.error(f"Required data not found in JSON: {e}")
        return

    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    try:
        for entry in price_history:
            unix_timestamp = entry['timestamp']
            iso_timestamp = unix_to_iso(unix_timestamp)
            logging.info(f"Inserting data: Timestamp {iso_timestamp}, Price {entry['value']}")
            cursor.execute('''
            INSERT OR REPLACE INTO historical_price_data (pair_address, timestamp, price_usd)
            VALUES (?, ?, ?)
            ''', (pair_address, iso_timestamp, entry['value']))

        conn.commit()
        logging.info(f"Historical price data populated for pair address: {pair_address}")
    except sqlite3.Error as e:
        logging.error(f"Database error: {e}")
        conn.rollback()
    finally:
        conn.close()

def verify_data_format():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()
    cursor.execute("SELECT timestamp, price_usd FROM historical_price_data LIMIT 5")
    samples = cursor.fetchall()
    conn.close()

    logging.info("Sample data from the database:")
    for timestamp, price in samples:
        logging.info(f"Timestamp: {timestamp}, Price: {price}")

def main():
    if recreate_table():
        populate_historical_price_data()
        verify_data_format()
    else:
        logging.error("Failed to recreate table. Aborting data population.")

if __name__ == "__main__":
    main()