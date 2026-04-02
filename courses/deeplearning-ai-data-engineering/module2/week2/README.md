# Week 2: Batch Data Processing from an API

## Assignment: Spotify API Data Ingestion
**Status**: ✅ Completed & Submitted  
**Grade**: Passed  
**Date**: January 15, 2026

## Overview
Built a batch data processing pipeline to extract data from the Spotify Web API, implementing pagination, authentication token management, and error handling.

## Technologies Used
- **Python**: Core programming language
- **Spotify Web API**: Data source for new album releases and tracks
- **Libraries**:
  - `requests`: HTTP API calls
  - `python-dotenv`: Environment variable management
  - `spotipy`: Spotify SDK (optional exercises)
  - `json`: Data serialization

## What We Accomplished

### 1. API Authentication
- Implemented OAuth 2.0 Client Credentials flow
- Created token request function with POST method
- Managed access tokens for API authorization

### 2. API Data Extraction
- Built `get_new_releases()` function to fetch album data
- Implemented request headers with Bearer token authentication
- Handled API responses and JSON parsing

### 3. Pagination Patterns
Implemented two pagination approaches:

#### Offset-Based Pagination
- Used `offset` and `limit` parameters
- Iterated through pages by incrementing offset
- Tracked total elements to determine when to stop

#### Next URL Pagination
- Used `next` field from API response
- More robust approach (handles dynamic data)
- Continues until `next` is `null`

### 4. Token Refresh & Error Handling
- Detected 401 Unauthorized responses
- Automatically refreshed expired tokens
- Retried failed requests with new token
- Implemented try-except blocks for resilience

### 5. Batch Pipeline
Built production-ready pipeline in `src/main.py`:
- Fetched 100 new album releases
- Extracted album IDs
- Iterated through each album to get track details
- Saved results to timestamped JSON file

### 6. SDK Usage (Optional)
- Explored Spotipy SDK as alternative to raw API calls
- Compared manual implementation vs SDK approach
- Understood abstraction benefits and trade-offs

## Key Concepts Learned

### API Best Practices
- Always handle authentication properly
- Implement token refresh logic
- Use pagination for large datasets
- Add error handling and logging
- Respect API rate limits

### Batch Processing Patterns
- Extract data in chunks (pagination)
- Process iteratively (album → tracks)
- Save results with timestamps
- Handle failures gracefully

### Code Organization
- Separate authentication logic (`authentication.py`)
- Isolate endpoint functions (`endpoint.py`)
- Orchestrate in main script (`main.py`)
- Use environment variables for secrets

## File Structure
```
week2/
├── C2_W2_Assignment.ipynb    # Main assignment notebook
├── src/
│   ├── authentication.py     # Token management
│   ├── endpoint.py           # API request functions
│   ├── main.py              # Batch pipeline orchestration
│   ├── env.template         # Credential template
│   └── env                  # Actual credentials (gitignored)
├── images/                  # Assignment screenshots
└── README.md               # This file
```

## Running the Code

### Setup
```bash
# Install dependencies
pip install requests python-dotenv spotipy

# Configure credentials
cp src/env.template src/env
# Edit src/env with your Spotify API credentials
```

### Execute Notebook
```bash
jupyter notebook C2_W2_Assignment.ipynb
```

### Run Batch Pipeline
```bash
cd src
python main.py
```

### Output
Creates `album_items_<TIMESTAMP>.json` with:
- 100 album releases
- Track details for each album
- Full metadata from Spotify API

## Credentials Setup
1. Go to https://developer.spotify.com/dashboard
2. Create new app
3. Get Client ID and Client Secret
4. Add to `src/env` file

## Notes
- Credentials are gitignored for security
- Use `src/env.template` as reference
- All cells tested and execute successfully
- Pipeline handles token expiration automatically

## Next Steps
- Week 3: Data transformation and quality checks
- Week 4: Advanced pipeline orchestration with Airflow
