import json
from datetime import datetime, timezone
from supabase import create_client
from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Initialize Supabase client
SUPABASE_URL = os.getenv('SUPABASE_URL')
SUPABASE_KEY = os.getenv('SUPABASE_KEY')

if not SUPABASE_URL or not SUPABASE_KEY:
    raise ValueError("Missing Supabase credentials in .env file")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

def insert_historical_price_data(json_file_path):
    # Read JSON data from file
    with open(json_file_path, 'r') as file:
        data = json.load(file)

    # Extract price history from the loaded JSON data
    price_history = data['data']['token']['market']['priceHistory']

    # Prepare data for batch insert
    records = []
    for entry in price_history:
        # Convert Unix timestamp to ISO format string
        iso_timestamp = datetime.fromtimestamp(entry['timestamp'], tz=timezone.utc).isoformat()
        
        records.append({
            'timestamp': iso_timestamp,
            'price': entry['value']
        })

    try:
        # Insert data into Supabase
        # This will upsert (update if exists, insert if not) based on timestamp
        result = supabase.table('token_price_history').upsert(records).execute()
        print(f"Successfully inserted {len(records)} records")
        return result
        
    except Exception as e:
        print(f"Error inserting data: {e}")
        return None

# Usage
if __name__ == "__main__":
    json_file_path = "historical_data.json"
    insert_historical_price_data(json_file_path)