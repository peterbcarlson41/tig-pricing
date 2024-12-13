import psycopg2
from psycopg2.extras import RealDictCursor
import os
from dotenv import load_dotenv
import logging

logging.basicConfig(level=logging.INFO)
load_dotenv()

CREATE_TABLES_SQL = """
CREATE TABLE IF NOT EXISTS pair_data_recent (
    timestamp TIMESTAMPTZ PRIMARY KEY,
    chain_id TEXT,
    dex_id TEXT,
    url TEXT,
    pair_address TEXT,
    price_native NUMERIC,
    price_usd NUMERIC,
    fdv NUMERIC,
    market_cap NUMERIC,
    pair_created_at TEXT,
    volume_m5 NUMERIC,
    volume_h1 NUMERIC,
    volume_h6 NUMERIC,
    volume_h24 NUMERIC,
    price_change_m5 NUMERIC,
    price_change_h1 NUMERIC,
    price_change_h6 NUMERIC,
    price_change_h24 NUMERIC,
    txns_m5_buys INTEGER,
    txns_m5_sells INTEGER,
    txns_h1_buys INTEGER,
    txns_h1_sells INTEGER,
    txns_h6_buys INTEGER,
    txns_h6_sells INTEGER,
    txns_h24_buys INTEGER,
    txns_h24_sells INTEGER,
    liquidity_usd NUMERIC,
    liquidity_base NUMERIC,
    liquidity_quote NUMERIC
);

CREATE TABLE IF NOT EXISTS price_volume_history (
    timestamp TIMESTAMPTZ PRIMARY KEY,
    price_usd NUMERIC,
    volume_h24 NUMERIC
);
"""

# Source (Supabase) connection
source_conn = psycopg2.connect(
    "postgresql://postgres:{password}@db.zukwsalmpdmnmkizpqvt.supabase.co:5432/postgres?sslmode=require".format(
        password=os.getenv('SUPABASE_PASSWORD')
    )
)

# Destination (DigitalOcean) connection
dest_conn = psycopg2.connect(
    host=os.getenv('DB_HOST'),
    dbname=os.getenv('DB_NAME'),
    user=os.getenv('DB_USER'),
    password=os.getenv('DB_PASSWORD'),
    port=os.getenv('DB_PORT'),
    sslmode='require'
)

try:
    # Create tables in DigitalOcean if they don't exist
    with dest_conn.cursor() as cur:
        logging.info("Creating tables if they don't exist...")
        cur.execute(CREATE_TABLES_SQL)
        dest_conn.commit()

    # Fetch data from Supabase
    with source_conn.cursor(cursor_factory=RealDictCursor) as cur:
        logging.info("Fetching pair_data_recent from Supabase...")
        cur.execute("SELECT * FROM pair_data_recent")
        pair_data = cur.fetchall()
        
        logging.info("Fetching price_volume_history from Supabase...")
        cur.execute("SELECT * FROM price_volume_history")
        price_history = cur.fetchall()
    
    # Insert into DigitalOcean
    with dest_conn.cursor() as cur:
        # Insert pair_data_recent
        logging.info("Migrating pair_data_recent...")
        for record in pair_data:
            columns = record.keys()
            values = [record[column] for column in columns]
            insert_query = f"""
                INSERT INTO pair_data_recent ({', '.join(columns)})
                VALUES ({', '.join(['%s'] * len(columns))})
                ON CONFLICT (timestamp) DO UPDATE
                SET {', '.join(f"{col} = EXCLUDED.{col}" for col in columns)}
            """
            cur.execute(insert_query, values)
        
        # Insert price_volume_history
        logging.info("Migrating price_volume_history...")
        for record in price_history:
            columns = record.keys()
            values = [record[column] for column in columns]
            insert_query = f"""
                INSERT INTO price_volume_history ({', '.join(columns)})
                VALUES ({', '.join(['%s'] * len(columns))})
                ON CONFLICT (timestamp) DO UPDATE
                SET {', '.join(f"{col} = EXCLUDED.{col}" for col in columns)}
            """
            cur.execute(insert_query, values)
    
    dest_conn.commit()
    logging.info("Migration completed successfully!")

except Exception as e:
    logging.error(f"Error during migration: {e}")
    dest_conn.rollback()

finally:
    source_conn.close()
    dest_conn.close()