import psycopg2
from psycopg2.extras import RealDictCursor
import os
from dotenv import load_dotenv

load_dotenv()

# Source (Supabase) connection
source_conn = psycopg2.connect(
    host=os.getenv('SUPABASE_HOST'),
    dbname=os.getenv('SUPABASE_DB'),
    user=os.getenv('SUPABASE_USER'),
    password=os.getenv('SUPABASE_PASSWORD'),
    port=os.getenv('SUPABASE_PORT')
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
    # Fetch data from Supabase
    with source_conn.cursor(cursor_factory=RealDictCursor) as cur:
        # Get pair_data_recent
        cur.execute("SELECT * FROM pair_data_recent")
        pair_data = cur.fetchall()
        
        # Get price_volume_history
        cur.execute("SELECT * FROM price_volume_history")
        price_history = cur.fetchall()
    
    # Insert into DigitalOcean
    with dest_conn.cursor() as cur:
        # Insert pair_data_recent
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
    print("Migration completed successfully!")

except Exception as e:
    print(f"Error during migration: {e}")
    dest_conn.rollback()

finally:
    source_conn.close()
    dest_conn.close()