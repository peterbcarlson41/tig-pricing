from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import APIKeyHeader
from pydantic import BaseModel
import sqlite3
from typing import List
import os
import dotenv
from datetime import datetime, timedelta, timezone

app = FastAPI()

dotenv.load_dotenv()

# API Key Authentication
API_KEY = os.environ.get("API_KEY")
if not API_KEY:
    raise ValueError("API_KEY environment variable must be set")

api_key_header = APIKeyHeader(name="X-API-Key")

def get_api_key(api_key: str = Depends(api_key_header)):
    if api_key != API_KEY:
        raise HTTPException(status_code=403, detail="Invalid API Key")
    return api_key

# Database setup
DB_NAME = "dexscreener_data.db"

class PriceData(BaseModel):
    timestamp: str
    price: str

def get_db_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row
    return conn

@app.get("/price/week", response_model=List[PriceData])
def get_week_price_data(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    one_week_ago = (datetime.now(timezone.utc) - timedelta(days=7)).isoformat()
    
    cursor.execute("""
        SELECT 
            strftime('%Y-%m-%d %H:00:00', timestamp) as hour,
            AVG(priceUsd) as avg_price
        FROM pair_data_recent
        WHERE timestamp >= ?
        GROUP BY hour
        ORDER BY hour
    """, (one_week_ago,))
    
    rows = cursor.fetchall()
    conn.close()
    
    return [{"timestamp": row['hour'], "price": str(row['avg_price'])} for row in rows]

@app.get("/price/alltime", response_model=List[PriceData])
def get_alltime_price_data(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT timestamp, price
        FROM token_price_history
        ORDER BY timestamp
    """)
    
    rows = cursor.fetchall()
    
    # If there's no data in token_price_history, fall back to pair_data_recent
    if not rows:
        cursor.execute("""
            SELECT 
                strftime('%Y-%m-%d', timestamp) as day,
                AVG(priceUsd) as avg_price
            FROM pair_data_recent
            GROUP BY day
            ORDER BY day
        """)
        rows = cursor.fetchall()
        conn.close()
        return [{"timestamp": row['day'], "price": str(row['avg_price'])} for row in rows]
    
    conn.close()
    
    return [{"timestamp": row['timestamp'], "price": str(row['price'])} for row in rows]

@app.get("/price/day", response_model=List[PriceData])
def get_day_price_data(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    one_day_ago = (datetime.now(timezone.utc) - timedelta(days=1)).isoformat()
    
    cursor.execute("""
        SELECT timestamp, priceUsd as price
        FROM pair_data_recent
        WHERE timestamp >= ?
        ORDER BY timestamp
    """, (one_day_ago,))
    
    rows = cursor.fetchall()
    conn.close()
    
    return [{"timestamp": row['timestamp'], "price": str(row['price'])} for row in rows]

@app.get("/volume/24h")
def get_24h_volume(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT volume_h24 as total_volume
        FROM pair_data_recent
        ORDER BY timestamp DESC
        LIMIT 1
    """)
    
    row = cursor.fetchone()
    conn.close()
    
    if row and row['total_volume'] is not None:
        return {"volume_24h": str(row['total_volume'])}
    else:
        return {"volume_24h": "0"}

@app.get("/price/current")
def get_current_price(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    cursor.execute("""
        SELECT timestamp, priceUsd as price
        FROM pair_data_recent
        ORDER BY timestamp DESC
        LIMIT 1
    """)
    
    row = cursor.fetchone()
    conn.close()
    
    if row:
        return {"timestamp": row['timestamp'], "price": str(row['price'])}
    else:
        raise HTTPException(status_code=404, detail="No price data available")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)