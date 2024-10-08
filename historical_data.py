import json
import sqlite3
from datetime import datetime, timezone

def insert_historical_price_data(json_file_path, db_name):
    # Read JSON data from file
    with open(json_file_path, 'r') as file:
        data = json.load(file)

    conn = sqlite3.connect(db_name)
    cursor = conn.cursor()

    # Create the new table if it doesn't exist
    cursor.execute('''
    CREATE TABLE IF NOT EXISTS token_price_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        timestamp TEXT NOT NULL,
        price REAL NOT NULL,
        UNIQUE(timestamp)
    )
    ''')

    # Extract price history from the loaded JSON data
    price_history = data['data']['token']['market']['priceHistory']

    # Insert data into the new table
    for entry in price_history:
        # Convert Unix timestamp to ISO format string
        iso_timestamp = datetime.fromtimestamp(entry['timestamp'], tz=timezone.utc).isoformat()
        
        cursor.execute('''
        INSERT OR REPLACE INTO token_price_history (timestamp, price)
        VALUES (?, ?)
        ''', (iso_timestamp, entry['value']))

    conn.commit()
    conn.close()

    print(f"Historical price data has been inserted into {db_name}")

# Usage
json_file_path = "historical_data.json"
db_name = "dexscreener_data.db"
insert_historical_price_data(json_file_path, db_name)