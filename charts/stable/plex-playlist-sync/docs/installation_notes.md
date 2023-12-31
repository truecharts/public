---
title: Installation Notes
---

## Plex Required Parameters

- Set the Plex Configuration's `Url` with the address of your Plex server, such as `http://IP:PORT`. If you're using TrueNAS Scale and your application's name is `plex`, then this value should work `http://plex.ix-plex.svc.cluster.local:32400`.

- Set the Plex Configuration's `Token` with your Plex Token value. To get this, you'll need to log into Plex as the server owner and browse to am item in your library. Then select the "View as XML" hyperlink. This should open up a new tab showing XML data and the URL will end with `...Plex-Token=`. Your token value is after the `=`, so **only** copy that value.

![xml_info_token.png](imgs/xml_info_token.png)

## Spotify Required Parameters

_Note: These configuration settings are only if you are using Spotify. If you're intending to use Spotify, then the Spotify Configuration settings are all required._

Your Spotify Client Id and Client Secret can be obtained by becoming a [Spotify Developer](https://developer.spotify.com/dashboard/login).

Your Spotify User Id - can be found on [Spotify's account page](https://www.spotify.com/us/account/overview/).

## Deezer Required Parameters

_Note: These configuration settings are only if you are using Deezer. If you're intending on using Deezer instead, either the `User Id` option or the `Playlist Id` option is required._

### Option 1 - Sync all user playlists

Your Deezer User Id can be obtained by logging in and clicking on your profile. The Id will be in the URL and is a numerical value. Ex: `/profile/#`

### Option 2 - Sync specific playlists

The Deezer Playlist Id can be obtained by navigating to the playlists that you want to sync. They Id will be in the URL and is a numerical value. Ex: `/playlist/#`
