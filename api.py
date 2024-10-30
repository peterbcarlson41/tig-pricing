from fastapi import FastAPI, Depends, HTTPException
from fastapi.security import APIKeyHeader
from pydantic import BaseModel
import sqlite3
from typing import List
from datetime import datetime, timedelta, timezone
import os
import dotenv

app = FastAPI()

dotenv.load_dotenv()

# API Key Authentication setup remains the same
API_KEY = os.environ.get("API_KEY")
if not API_KEY:
    raise ValueError("API_KEY environment variable must be set")

api_key_header = APIKeyHeader(name="X-API-Key")

def get_api_key(api_key: str = Depends(api_key_header)):
    if api_key != API_KEY:
        raise HTTPException(status_code=403, detail="Invalid API Key")
    return api_key

# Updated Pydantic models to match frontend expectations
class PriceData(BaseModel):
    date: str
    price: float
    volume: float
    change: float

class PriceResponse(BaseModel):
    currentPrice: float
    priceChange: float
    historicalData: List[PriceData]

def get_db_connection():
    conn = sqlite3.connect("dexscreener_data.db")
    conn.row_factory = sqlite3.Row
    return conn

def calculate_price_change(current_price: float, previous_price: float) -> float:
    if previous_price == 0:
        return 0
    return ((current_price - previous_price) / previous_price) * 100

@app.get("/api/price", response_model=PriceResponse)
def get_price_data(api_key: str = Depends(get_api_key)):
    conn = get_db_connection()
    cursor = conn.cursor()
    
    # Get current price and timestamp
    cursor.execute("""
        SELECT timestamp, priceUsd as price, volume_h24, marketCap
        FROM pair_data_recent
        ORDER BY timestamp DESC
        LIMIT 1
    """)
    current_data = cursor.fetchone()
    
    if not current_data:
        raise HTTPException(status_code=404, detail="No price data available")
    
    current_price = float(current_data['price'])
    
    # Get historical data for the past week
    one_week_ago = (datetime.now(timezone.utc) - timedelta(days=7)).isoformat()
    cursor.execute("""
        SELECT 
            strftime('%Y-%m-%d %H:00:00', timestamp) as date,
            AVG(priceUsd) as price,
            AVG(volume_h24) as volume
        FROM pair_data_recent
        WHERE timestamp >= ?
        GROUP BY date
        ORDER BY date
    """, (one_week_ago,))
    
    historical_rows = cursor.fetchall()
    
    # Calculate price change (24h)
    one_day_ago = (datetime.now(timezone.utc) - timedelta(days=1)).isoformat()
    cursor.execute("""
        SELECT priceUsd as price
        FROM pair_data_recent
        WHERE timestamp <= ?
        ORDER BY timestamp DESC
        LIMIT 1
    """, (one_day_ago,))
    
    previous_day_data = cursor.fetchone()
    previous_price = float(previous_day_data['price']) if previous_day_data else current_price
    price_change = calculate_price_change(current_price, previous_price)
    
    conn.close()
    
    # Transform historical data to match frontend expectations
    historical_data = []
    previous_price = None
    for row in historical_rows:
        price = float(row['price'])
        change = calculate_price_change(price, previous_price) if previous_price is not None else 0
        historical_data.append(PriceData(
            date=row['date'],
            price=price,
            volume=float(row['volume']) if row['volume'] else 0,
            change=change
        ))
        previous_price = price
    
    return PriceResponse(
        currentPrice=current_price,
        priceChange=price_change,
        historicalData=historical_data
    )

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)