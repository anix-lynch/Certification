import datetime as dt
import json
import os

from dotenv import load_dotenv
from endpoint import (
    get_paginated_new_releases,
    get_paginated_album_tracks,
)
from authentication import get_token

load_dotenv("./env", override=True)

CLIENT_ID = os.getenv("CLIENT_ID", "")
CLIENT_SECRET = os.getenv("CLIENT_SECRET", "")


URL_TOKEN = "https://accounts.spotify.com/api/token"
URL_NEW_RELEASES = "https://api.spotify.com/v1/browse/new-releases"
URL_ALBUM_TRACKS = "https://api.spotify.com/v1/albums"


def main():
    # Getting token:
    kwargs = {
        "client_id": CLIENT_ID,
        "client_secret": CLIENT_SECRET,
        "url": URL_TOKEN,
    }

    token = get_token(**kwargs)

    new_releases = get_paginated_new_releases(
        base_url=URL_NEW_RELEASES,
        access_token=token.get("access_token"),
        get_token=get_token,
        **kwargs,
    )

    print("New album releases have been extracted.")

    # Getting albums IDs
    albums_ids = [album["id"] for album in new_releases]

    print(
        f"Total number of new album releases extracted: {len(albums_ids)}"
    )

    # Getting information about each album
    print(f"Getting information about each album")

    album_items = {}

    ### Exercise 6
    ### START CODE HERE ### (~ 9 lines of code)
    for album_id in albums_ids:
        album_data = get_paginated_album_tracks(
            base_url=URL_ALBUM_TRACKS,
            access_token=token.get("access_token"),
            album_id=album_id,
            get_token=get_token,
            **kwargs,
        )
    ### END CODE HERE ###

        album_items[album_id] = album_data

        print(f"Album {album_id} has been processed successfully")

    # Saving processed data to a JSON file.
    if len(album_items.keys()) > 0:
        current_time = dt.datetime.now(dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
        filename = f"album_items_{current_time}"

        with open(f"./{filename}.json", "w+") as albums_file:
            json.dump(album_items, albums_file)

        print(f"Data has been saved successfully to {filename}.json")
    else:
        print(f"No data was available to be saved.")


if __name__ == "__main__":
    main()
