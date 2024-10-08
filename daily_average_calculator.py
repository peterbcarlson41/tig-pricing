import sqlite3
import logging
from datetime import datetime, timezone, timedelta

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Database setup
DB_NAME = "dexscreener_data.db"

def calculate_and_insert_daily_average():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    # Calculate yesterday's date
    yesterday = (datetime.now(timezone.utc) - timedelta(days=1)).date()
    yesterday_start = datetime.combine(yesterday, datetime.min.time()).replace(tzinfo=timezone.utc)
    yesterday_end = datetime.combine(yesterday, datetime.max.time()).replace(tzinfo=timezone.utc)

    # Calculate the average price for yesterday
    cursor.execute("""
    SELECT AVG(CAST(priceUsd AS REAL)) 
    FROM price_volume_history 
    WHERE timestamp >= ? AND timestamp < ?
    """, (yesterday_start.isoformat(), yesterday_end.isoformat()))
    
    avg_price = cursor.fetchone()[0]

    if avg_price is not None:
        # Use yesterday's date for the timestamp
        daily_timestamp = yesterday_start.isoformat()

        cursor.execute("""
        INSERT OR REPLACE INTO token_price_history (timestamp, price)
        VALUES (?, ?)
        """, (daily_timestamp, avg_price))

        conn.commit()
        logging.info(f"Inserted daily average price for {yesterday} at {daily_timestamp}: {avg_price}")
    else:
        logging.warning(f"No data available to calculate average for {yesterday}")

    conn.close()

if __name__ == "__main__":
    calculate_and_insert_daily_average()