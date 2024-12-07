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

def migrate_historical_to_recent():
    try:
        # Fetch all data from token_price_history
        historical_data = supabase.table('token_price_history') \
            .select('*') \
            .execute()

        # Check if there is data in the response
        historical_records = historical_data.data  # Access the data directly

        if not historical_records:
            print("No data found in token_price_history")
            return

        # Prepare records for insertion into pair_data_recent
        recent_data = [
            {
                'timestamp': record['timestamp'],
                'price_usd': record['price'],
                # Add additional fields here if required to match pair_data_recent schema
            }
            for record in historical_records
        ]

        # Insert records into pair_data_recent
        result = supabase.table('pair_data_recent').insert(recent_data).execute()
        print(f"Successfully migrated {len(recent_data)} records to pair_data_recent")

    except Exception as e:
        print(f"Error during migration: {e}")

# Usage
if __name__ == "__main__":
    migrate_historical_to_recent()
