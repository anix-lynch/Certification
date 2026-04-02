# Quick Commands Reference

## Setup Commands

### Install Dependencies
```bash
pip install requests python-dotenv
# Optional: for Exercise 7
pip install spotipy
```

### Configure Environment
```bash
cd src
# Edit env file
nano env
# or
vim env
```

Add your credentials:
```
CLIENT_ID=your_client_id_here
CLIENT_SECRET=your_client_secret_here
```

## Running the Pipeline

### Run Main Pipeline
```bash
cd src
python main.py
```

### Test Individual Components

#### Test Authentication
```python
from authentication import get_token
from dotenv import load_dotenv
import os

load_dotenv('./env')
token = get_token(
    client_id=os.getenv('CLIENT_ID'),
    client_secret=os.getenv('CLIENT_SECRET'),
    url="https://accounts.spotify.com/api/token"
)
print(token.get('access_token'))
```

#### Test New Releases Endpoint
```python
from endpoint import get_paginated_new_releases
from authentication import get_token
from dotenv import load_dotenv
import os

load_dotenv('./env')
kwargs = {
    "client_id": os.getenv('CLIENT_ID'),
    "client_secret": os.getenv('CLIENT_SECRET'),
    "url": "https://accounts.spotify.com/api/token"
}
token = get_token(**kwargs)

releases = get_paginated_new_releases(
    base_url="https://api.spotify.com/v1/browse/new-releases",
    access_token=token.get('access_token'),
    get_token=get_token,
    **kwargs
)
print(f"Total releases: {len(releases)}")
```

#### Test Album Tracks
```python
from endpoint import get_paginated_album_tracks
# ... (same setup as above)

album_id = "4iV5W9uYEdYUVa79Axb7Rh"  # Example album ID
tracks = get_paginated_album_tracks(
    base_url="https://api.spotify.com/v1/albums",
    access_token=token.get('access_token'),
    album_id=album_id,
    get_token=get_token,
    **kwargs
)
print(f"Total tracks: {len(tracks)}")
```

## Jupyter Notebook Commands

### Run All Cells
- Click "Run All" button in notebook toolbar
- Or: `Shift + Enter` on each cell

### Run Single Cell
- `Shift + Enter` - Run and move to next
- `Ctrl + Enter` - Run and stay in cell

## Verification Commands

### Check Output File
```bash
cd src
ls -lh album_items_*.json
```

### View JSON Content
```python
import json
import glob

# Find latest file
files = glob.glob('album_items_*.json')
latest = max(files, key=os.path.getctime)

with open(latest, 'r') as f:
    data = json.load(f)

print(f"Albums processed: {len(data)}")
print(f"First album ID: {list(data.keys())[0]}")
print(f"Tracks in first album: {len(data[list(data.keys())[0]])}")
```

### Count Total Tracks
```python
import json
import glob

files = glob.glob('album_items_*.json')
latest = max(files, key=os.path.getctime)

with open(latest, 'r') as f:
    data = json.load(f)

total_tracks = sum(len(tracks) for tracks in data.values())
print(f"Total tracks across all albums: {total_tracks}")
```

## API Testing Commands

### Test Token Endpoint (curl)
```bash
curl -X POST "https://accounts.spotify.com/api/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET"
```

### Test New Releases (curl)
```bash
curl "https://api.spotify.com/v1/browse/new-releases?limit=5" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

### Test Album Tracks (curl)
```bash
curl "https://api.spotify.com/v1/albums/ALBUM_ID/tracks" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## Debugging Commands

### Check Python Version
```bash
python --version
python3 --version
```

### Check Installed Packages
```bash
pip list | grep -E "requests|dotenv|spotipy"
```

### Run with Verbose Output
```python
import logging
logging.basicConfig(level=logging.DEBUG)
# Then run your script
```

### Test Network Connectivity
```bash
# Test Spotify API
curl -I https://api.spotify.com/v1/browse/new-releases

# Test token endpoint
curl -I https://accounts.spotify.com/api/token
```

## Git Commands (for GitHub sync)

### Check Status
```bash
cd /path/to/repo
git status
```

### Add Files
```bash
git add module2/week2/
```

### Commit
```bash
git commit -m "Complete Course 2 Week 2: Batch Data Processing from API"
```

### Push
```bash
git push origin main
```

## Common Issues & Fixes

### Import Error: No module named 'requests'
```bash
pip install requests
```

### Import Error: No module named 'dotenv'
```bash
pip install python-dotenv
```

### 401 Unauthorized Error
- Check credentials in `src/env`
- Verify token hasn't expired
- Token refresh should handle automatically

### 429 Rate Limit Error
- Add delay between requests
- Reduce request frequency
- Wait 30 seconds and retry

### File Not Found Error
```bash
# Make sure you're in the right directory
pwd
# Should be: .../module2/week2/src
```

## Environment Variables

### Set in Terminal (temporary)
```bash
export CLIENT_ID="your_client_id"
export CLIENT_SECRET="your_client_secret"
```

### Load from File
```python
from dotenv import load_dotenv
import os

load_dotenv('./env')  # or './src/env'
CLIENT_ID = os.getenv('CLIENT_ID')
CLIENT_SECRET = os.getenv('CLIENT_SECRET')
```

## Useful Python Snippets

### Pretty Print JSON
```python
import json
print(json.dumps(data, indent=2))
```

### Save Results to File
```python
import json
with open('output.json', 'w') as f:
    json.dump(data, f, indent=2)
```

### Load Results from File
```python
import json
with open('output.json', 'r') as f:
    data = json.load(f)
```

### Check Response Status
```python
response = requests.get(url, headers=headers)
print(f"Status: {response.status_code}")
print(f"Headers: {response.headers}")
```

