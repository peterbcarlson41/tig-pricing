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
        FROM pair_data
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
        SELECT 
            strftime('%Y-%m-%d', timestamp) as day,
            AVG(priceUsd) as avg_price
        FROM pair_data
        GROUP BY day
        ORDER BY day
    """)
    
    rows = cursor.fetchall()
    conn.close()
    
    return [{"timestamp": row['day'], "price": str(row['avg_price'])} for row in rows]

@app.get("/price/day", response_model=List[PriceData])
def get_day_price_data(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    one_day_ago = (datetime.now(timezone.utc) - timedelta(days=1)).isoformat()
    
    cursor.execute("""
        SELECT timestamp, priceUsd as price
        FROM pair_data
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
        FROM pair_data
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
        FROM pair_data
        ORDER BY timestamp DESC
        LIMIT 1
    """)
    
    row = cursor.fetchone()
    conn.close()
    
    if row:
        return {"timestamp": row['timestamp'], "price": str(row['price'])}
    else:
        raise HTTPException(status_code=404, detail="No price data available")

@app.get("/price/change24h")
def get_price_change_24h(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get current price
    cursor.execute("""
        SELECT timestamp, priceUsd as price
        FROM pair_data
        ORDER BY timestamp DESC
        LIMIT 1
    """)
    current_row = cursor.fetchone()
    
    if not current_row:
        conn.close()
        raise HTTPException(status_code=404, detail="No current price data available")
    
    current_price = current_row['price']
    current_timestamp = current_row['timestamp']
    
    # Get price 24 hours ago
    twenty_four_hours_ago = (datetime.fromisoformat(current_timestamp) - timedelta(hours=24)).isoformat()
    cursor.execute("""
        SELECT priceUsd as price
        FROM pair_data
        WHERE timestamp <= ?
        ORDER BY timestamp DESC
        LIMIT 1
    """, (twenty_four_hours_ago,))
    
    old_row = cursor.fetchone()
    conn.close()
    
    if not old_row:
        return {
            "current_price": str(current_price),
            "current_timestamp": current_timestamp,
            "price_change_24h": None,
            "price_change_percentage_24h": None,
            "error": "No price data available for 24 hours ago"
        }
    
    old_price = old_row['price']
    price_change = float(current_price) - float(old_price)
    price_change_percentage = (price_change / float(old_price)) * 100
    
    return {
        "current_price": str(current_price),
        "current_timestamp": current_timestamp,
        "price_24h_ago": str(old_price),
        "price_change_24h": str(price_change),
        "price_change_percentage_24h": str(price_change_percentage)
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)