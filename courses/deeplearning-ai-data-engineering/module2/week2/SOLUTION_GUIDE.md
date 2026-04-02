# Solution Guide: Batch Data Processing from API

## Step-by-Step Solution Guide

This guide walks you through completing all exercises in the assignment.

---

## Part 1: Setup

### 1.1 Create Spotify Developer Account

1. Go to https://developer.spotify.com/
2. Sign up or log in
3. Navigate to Dashboard

### 1.2 Create Spotify App

1. Click "Create App"
2. Fill in details:
   - **App name**: `dec2w2a1-spotify-app`
   - **App description**: `spotify app to test the API`
   - **Website**: (leave empty)
   - **Redirect URIs**: `http://127.0.0.1:3000`
   - **API**: Select `Web API`
3. Click "Save"

### 1.3 Get Credentials

1. Go to App Settings
2. Reveal `Client ID` and `Client secret`
3. Copy both values
4. Paste into `src/env` file:
   ```
   CLIENT_ID=your_client_id_here
   CLIENT_SECRET=your_client_secret_here
   ```

---

## Part 2: Notebook Exercises

### Exercise 1: Get New Releases

**Location**: `C2_W2_Assignment.ipynb` - Cell 14

**Task**: Complete the `get_new_releases()` function

**Solution**:
```python
def get_new_releases(url: str, access_token: str, offset: int=0, limit: int=20, next: str="") -> Dict[Any, Any]:
    if next == "":        
        request_url = f"{url}?offset={offset}&limit={limit}"
    else: 
        request_url = f"{next}"

    # Call get_auth_header() function and pass the access token.
    headers = get_auth_header(access_token=access_token)
    
    try: 
        # Perform a get() request using the request_url and headers.
        response = requests.get(url=request_url, headers=headers)
        # Use json() method over the response to return it as Python dictionary.
        return response.json()
    
    except Exception as err:
        print(f"Error requesting data: {err}")
        return {'error': err}
```

**Key Points**:
- Use `get_auth_header()` to create authorization header
- Use `requests.get()` with URL and headers
- Convert response to JSON with `.json()`

---

### Exercise 2: Pagination with Offset

**Location**: `C2_W2_Assignment.ipynb` - Cell 34

**Task**: Create `paginated_new_releases()` function

**Solution**:
```python
def paginated_new_releases(endpoint_request: Callable, url: str, access_token: str, offset: int=0, limit: int=20) -> list:
    responses = []
    
    # Create a dictionary named kwargs with the values
    kwargs = { 
        "url": url,
        "access_token": access_token,
        "offset": offset,
        "limit": limit,
    } 

    # Call the endpoint_request() function with the arguments
    response = endpoint_request(**kwargs)
    # Use extend() method to add the albums' items to the list
    responses.extend(response.get('albums').get('items'))
    # Get the total number of elements
    total_elements = response.get('albums').get('total')

    # Run the loop as long as offset is smaller than total_elements
    while offset < total_elements:
        # Update the offset value
        offset = response.get('albums').get('offset') + limit
        # Update the offset in kwargs
        kwargs["offset"] = offset
        
        # Call the endpoint_request() function again
        response = endpoint_request(**kwargs)
        # Extend responses with new items
        responses.extend(response.get('albums').get('items'))
        
        print(f"Finished iteration for page with offset: {offset-limit}")

    return responses
```

**Key Points**:
- Start with initial request
- Get total elements from response
- Increment offset by limit each iteration
- Continue until offset >= total_elements

---

### Exercise 3: Pagination with Next URL

**Location**: `C2_W2_Assignment.ipynb` - Cell 44

**Task**: Create `paginated_with_next_new_releases()` function

**Solution**:
```python
def paginated_with_next_new_releases(endpoint_request: Callable, url: str, access_token: str) -> list:
    responses = []
        
    next_page = url
    
    kwargs = {
        "url": url,
        "access_token": access_token,
        "next": ""
    }
    
    while next_page:
        # Call the endpoint_request() function
        response = endpoint_request(**kwargs)
        # Extend responses with albums' items
        responses.extend(response.get('albums').get('items'))
        # Get the next page URL
        next_page = response.get('albums').get('next')
        # Update kwargs with next URL
        kwargs["next"] = next_page
        
        print(f"Executed request with URL: {response.get('albums').get('href')}.")
                
    return responses
```

**Key Points**:
- Use `next` field from API response
- Continue while `next_page` is not None
- Simpler than offset-based pagination

---

## Part 3: Python Script Exercises

### Exercise 4: Token Refresh ✅ (Completed)

**Location**: `src/endpoint.py` - Lines 29-44

**Task**: Handle token expiration (401 errors)

**Solution** (Already implemented):
```python
if response.status_code == 401:  # Unauthorized
    # Handle token expiration and update
    token_response = get_token(**kwargs)
    if "access_token" in token_response:
        headers = get_auth_header(
            access_token=token_response["access_token"]
        )
        print("Token has been refreshed")
        continue  # Retry the request with the updated token
    else:
        print("Failed to refresh token.")
        return []
```

**Key Points**:
- Check for 401 status code
- Call `get_token()` with kwargs
- Update headers with new token
- Use `continue` to retry request

---

### Exercise 5: Album Tracks Endpoint ✅ (Completed)

**Location**: `src/endpoint.py` - Lines 75-112

**Task**: Complete `get_paginated_album_tracks()` function

**Solution** (Already implemented):
```python
def get_paginated_album_tracks(
    base_url: str,
    access_token: str,
    album_id: str,
    get_token: Callable,
    **kwargs,
) -> list:
    # Call get_auth_header() with access token
    headers = get_auth_header(access_token=access_token)
    # Create request URL: base_url/album_id/tracks
    request_url = f"{base_url}/{album_id}/tracks"
    album_data = []

    try:
        while request_url:
            print(f"Requesting to: {request_url}")
            # Perform GET request
            response = requests.get(url=request_url, headers=headers)

            # Handle token refresh (same as Exercise 4)
            if response.status_code == 401:
                token_response = get_token(**kwargs)
                if "access_token" in token_response:
                    headers = get_auth_header(
                        access_token=token_response["access_token"]
                    )
                    print("Token has been refreshed")
                    continue
                else:
                    print("Failed to refresh token.")
                    return []

            # Convert to JSON
            response_json = response.json()
            # Extend album_data with items
            album_data.extend(response_json["items"])
            # Update request_url with next
            request_url = response_json["next"]

        return album_data
    except Exception as err:
        print(f"Error occurred during request: {err}")
        return []
```

**Key Points**:
- URL format: `{base_url}/{album_id}/tracks`
- Use `response_json["items"]` for tracks
- Use `response_json["next"]` for pagination
- Same token refresh logic as Exercise 4

---

### Exercise 6: Main Pipeline ✅ (Completed)

**Location**: `src/main.py` - Lines 54-64

**Task**: Complete function call in main loop

**Solution** (Already implemented):
```python
for album_id in albums_ids:
    album_data = get_paginated_album_tracks(
        base_url=URL_ALBUM_TRACKS,
        access_token=token.get("access_token"),
        album_id=album_id,
        get_token=get_token,
        **kwargs,
    )
    
    album_items[album_id] = album_data
    print(f"Album {album_id} has been processed successfully")
```

**Key Points**:
- Use `URL_ALBUM_TRACKS` constant
- Get access token from `token.get("access_token")`
- Pass `album_id` from loop
- Pass `get_token` function
- Pass `**kwargs` for token refresh

---

### Exercise 7: Spotipy SDK (Optional)

**Location**: `C2_W2_Assignment.ipynb` - Cell 72

**Task**: Implement pagination with Spotipy SDK

**Solution**:
```python
def paginated_new_releases_sdk(limit: int=20) -> list:
    album_data = []
    
    # First request
    response = spotify.new_releases(limit=limit)
    # Extend with first page items
    album_data.extend(response.get('albums').get('items'))
    # Get total elements
    total_albums_elements = response.get('albums').get('total')
    # Create offset list (start at limit, end at total, step by limit)
    offset_idx = list(range(limit, total_albums_elements, limit))

    for idx in offset_idx:
        # Request with offset
        response_page = spotify.new_releases(limit=limit, offset=idx)
        # Extend with page items
        album_data.extend(response_page.get('albums').get('items'))
    
    return album_data
```

---

## Part 4: Running the Pipeline

### 4.1 Test Individual Functions

1. **Test Authentication**:
   ```python
   from authentication import get_token
   from dotenv import load_dotenv
   import os
   
   load_dotenv('./src/env')
   token = get_token(
       client_id=os.getenv('CLIENT_ID'),
       client_secret=os.getenv('CLIENT_SECRET'),
       url="https://accounts.spotify.com/api/token"
   )
   print(token)
   ```

2. **Test New Releases**:
   ```python
   from endpoint import get_paginated_new_releases
   from authentication import get_token
   
   # Get token first
   # Then call:
   releases = get_paginated_new_releases(
       base_url="https://api.spotify.com/v1/browse/new-releases",
       access_token=token.get('access_token'),
       get_token=get_token,
       **kwargs
   )
   ```

### 4.2 Run Full Pipeline

```bash
cd src
python main.py
```

**Expected Output**:
- Progress messages for each request
- Token refresh messages (if needed)
- "Album {id} has been processed successfully" for each album
- Final message: "Data has been saved successfully to album_items_{timestamp}.json"

### 4.3 Verify Results

1. Check for JSON file: `album_items_{timestamp}.json`
2. Verify file contains album data:
   ```python
   import json
   with open('album_items_*.json', 'r') as f:
       data = json.load(f)
   print(f"Albums processed: {len(data)}")
   print(f"First album tracks: {len(data[list(data.keys())[0]])}")
   ```

---

## Troubleshooting

### Issue: 401 Unauthorized Error

**Solution**: 
- Check credentials in `src/env`
- Verify token hasn't expired
- Token refresh should handle this automatically

### Issue: Rate Limit (429 Error)

**Solution**:
- Add delays between requests
- Reduce request frequency
- Implement exponential backoff

### Issue: Empty Results

**Solution**:
- Verify API credentials are correct
- Check network connectivity
- Review API response structure

### Issue: Import Errors

**Solution**:
```bash
pip install requests python-dotenv
```

---

## Key Takeaways

1. **Authentication**: Always handle token expiration
2. **Pagination**: Two methods (offset vs next URL)
3. **Error Handling**: Check status codes, handle exceptions
4. **Batch Processing**: Process data in chunks, save results incrementally
5. **API Best Practices**: Respect rate limits, handle errors gracefully

---

## Next Steps

1. Complete notebook exercises (1-3, 7)
2. Test the completed pipeline
3. Experiment with different endpoints
4. Add error handling and logging
5. Optimize for performance

