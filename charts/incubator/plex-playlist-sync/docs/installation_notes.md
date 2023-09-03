# Installation Notes

- Set `PLEX_URL` with `http://IP:PORT` or cluster: `http://plex.ix-plex.svc.cluster.local:32400`. this cluster URL assumes you named your applicatin `plex`.

- To set `PLEX_TOKEN` you need to Browse to a library item and view the XML for it in plex as the `admin` user in the browser, the url will end with `...Plex-Token=` so **ONLY** copy after the `=` for the token.

Required parameters are 1, 2, or 3 depending on your desired setup. More information is explained below.


![xml_info_token.png](imgs/xml_info_token.png)


- `WRITE_MISSING_AS_CSV` can either be 0 or 1. 0 disables this feature, which is the default. 1 writes missing tracks from each playlist to a csv file.
- `APPEND_SERVICE_SUFFIX` can either be 0 or 1. 0 disables this feature. 1 appends the service name to the playlist name, which is the default.
- `ADD_PLAYLIST_POSTER` can either be 0 or 1. 0 disables this feature. 1 will add poster for each playlist, which is the default.
- `ADD_PLAYLIST_DESCRIPTION` can either be 0 or 1. 0 disables this feature. 1 will add description for each playlist, which is the default.
- `APPEND_INSTEAD_OF_SYNC` can either be 0 or 1. 0 appends to the playlist only, which is the default. 1 will sync tracks.
- `SECONDS_TO_WAIT` is the seconds to wait between syncs. 84000 is the default.
- `SPOTIFY_CLIENT_ID` should be your Spotify client id. (Option 1)
- `SPOTIFY_CLIENT_SECRET` can be your Spotify client secret. (Option 1)
- `SPOTIFY_USER_ID` can be your Spotify user id. (Option 1)
- `DEEZER_USER_ID` can be your Deezer user id. (Option 2)
- `DEEZER_PLAYLIST_ID` can be your Deezer playlist ids separated by a space. (Option 3)

## Spotify Required Parameters (Option 1)
`SPOTIFY_CLIENT_ID` - can be obtained by becoming a [Spotify Developer](https://developer.spotify.com/dashboard/login).
`SPOTIFY_CLIENT_SECRET` - you will receive the secret when you get your client id.
`SPOTIFY_USER_ID` - can be found on [Spotify's account page](https://www.spotify.com/us/account/overview/).

## Deezer Required Parameters

### Option 2

`DEEZER_USER_ID` - can be obtained by logging in and clicking on your profile. The ID will be in the URL and is a numerical value. Ex: /profile/#

### Option 3

`DEEZER_PLAYLIST_ID` - can be obtained by getting the playlists that you want to sync. They ID will be in the URL and is a numerical value. Ex: /playlist/#