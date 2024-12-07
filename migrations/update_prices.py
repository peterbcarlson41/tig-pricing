import logging
from decimal import Decimal, ROUND_HALF_UP
from supabase import create_client
import os

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# Supabase setup
SUPABASE_URL = os.environ['SUPABASE_URL']
SUPABASE_KEY = os.environ['SUPABASE_KEY']

if not SUPABASE_URL or not SUPABASE_KEY:
    raise ValueError("Missing Supabase credentials in environment variables")

supabase = create_client(SUPABASE_URL, SUPABASE_KEY)

def update_missing_native_prices():
    """
    Fetch records from pair_data_recent, update missing price_native values,
    and save back to Supabase.
    """
    try:
        # Fetch all records from pair_data_recent
        response = supabase.table('pair_data_recent').select('*').execute()
        records = response.data

        # Process each record
        updated_records = []
        for record in records:
            if record.get('price_native') is None and record.get('price_usd') is not None:
                # Convert to Decimal for precise rounding
                price = Decimal(str(record['price_usd'])).quantize(Decimal('0.0001'), rounding=ROUND_HALF_UP)
                record['price_native'] = float(price)
                updated_records.append(record)

        # Update records in Supabase
        if updated_records:
            supabase.table('pair_data_recent').upsert(updated_records).execute()
            logging.info(f"Successfully updated {len(updated_records)} records")
        else:
            logging.info("No records needed updating")

    except Exception as e:
        logging.error(f"Error processing data: {e}")

if __name__ == "__main__":
    update_missing_native_prices()