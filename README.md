# DexScreener Data Collection

This project automatically fetches and stores DEX pair data from DexScreener API, specifically tracking the BASE/USDC pair at address `0x5280d5E63b416277d0F81FAe54Bb1e0444cAbDAA`. The data is stored in a Supabase database and includes both real-time and historical price tracking.

## Features

- Automated data collection every 5 minutes
- Stores comprehensive pair data including:
  - Price (native and USD)
  - Volume metrics (5m, 1h, 6h, 24h)
  - Price changes
  - Transaction counts
  - Liquidity information
- Historical price and volume tracking
- Automatic price conversion from USD to native currency

## Setup

### Prerequisites

- Python 3.9 or higher
- Supabase account and project
- GitHub account for automated workflows

### Environment Variables

The following environment variables are required:

```
SUPABASE_URL=your_supabase_project_url
SUPABASE_KEY=your_supabase_api_key
```

### GitHub Secrets

Add the following secrets to your GitHub repository:

1. `SUPABASE_URL`: Your Supabase project URL
2. `SUPABASE_KEY`: Your Supabase API key

## GitHub Actions Workflow

The project uses GitHub Actions for automated data collection. The workflow is defined in `.github/workflows/schedule.yml`:

```yaml
name: Schedule Data Fetching
on:
  schedule:
    - cron: "*/5 * * * *" # Triggers every 5 minutes
  workflow_dispatch: # Allows manual trigger

jobs:
  fetchData:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v3
        with:
          python-version: "3.9"
      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install requests supabase-py
      - name: Run the data fetching script
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_KEY: ${{ secrets.SUPABASE_KEY }}
        run: |
          python script.py
```

## Scripts

### `script.py`

Main data collection script that:

- Fetches data from DexScreener API
- Processes and formats the data
- Stores it in Supabase tables

### `update_prices.py`

Utility script that:

- Checks for missing native prices in the database
- Copies USD prices to native price fields when missing
- Rounds prices to 4 decimal places

## Database Schema

### Table: pair_data_recent

Stores the most recent pair data including:

- Timestamps
- Prices (native and USD)
- Volume metrics
- Transaction counts
- Liquidity information

### Table: price_volume_history

Stores historical price and volume data:

- Timestamp
- USD price
- 24-hour volume

## Error Handling

The scripts include comprehensive error handling and logging:

- Failed API requests are logged
- Database connection issues are captured
- Data validation errors are reported
- All operations are logged with timestamps

## Manual Execution

To run the data collection manually:

1. Clone the repository
2. Set up environment variables
3. Install dependencies: `pip install requests supabase-py`
4. Run the script: `python script.py`

## Troubleshooting

If the GitHub Action isn't running:

1. Check the Actions tab for any error messages
2. Verify the secrets are properly set
3. Ensure the workflow file has the correct syntax
4. Remember that GitHub's scheduled actions may have slight delays

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT License - feel free to use and modify as needed.
