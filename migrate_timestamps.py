import sqlite3
from datetime import datetime, timezone
import pytz

DB_NAME = "dexscreener_data.db"

def convert_to_utc(timestamp_str):
    # Use Europe/Berlin timezone
    local_tz = pytz.timezone('Europe/Berlin')
    local_time = datetime.fromisoformat(timestamp_str)
    local_time = local_tz.localize(local_time)
    utc_time = local_time.astimezone(timezone.utc)
    return utc_time.isoformat()

def migrate_timestamps():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    # Fetch all rows from pair_data table
    cursor.execute("SELECT id, timestamp FROM pair_data")
    rows = cursor.fetchall()

    # Update each row with UTC timestamp
    for row in rows:
        id, old_timestamp = row
        new_timestamp = convert_to_utc(old_timestamp)
        cursor.execute("UPDATE pair_data SET timestamp = ? WHERE id = ?", (new_timestamp, id))

    conn.commit()
    conn.close()

if __name__ == "__main__":
    migrate_timestamps()
    print("Timestamp migration completed.")