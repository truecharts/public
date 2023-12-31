---
title: Installation Notes
---

- `Discord Token` can be acquired [here](https://discordapp.com/developers/applications) by creating a 'New Application', then going to 'Bot'.
- `Spotify Client Id` and `Spotify Client Secret` can be acquired [here](https://developer.spotify.com/dashboard/applications) with 'Create a Client ID'.
- `Youtube API Key` can be acquired by [creating a new project](https://console.developers.google.com/) in Google's Developer Console, enabling the YouTube API, and creating an API key under credentials.

Optionally you can enable the `advanced` settings and set the following:

- `Cache Limit` can accept MB or GB string values for example: **512MB** or **10GB**.
- `Bot Status` has list of values for the discord bot:
  - Online
  - Away
  - Do not Disturb
- `Bot Activity Type` has list of values for the discord bot:
  - Playing
  - Listening
  - Watching
  - Streaming
- Set `Bot Activity` to whatever you want that follows the activity type.
- If you plan to publicly share your bot with more servers other than your own, its recommended by the upstream project to set `Register Commands On Bot` to **true** if its more than 10 guilds. The bot is purpose built to support multiple servers.

:::note

If `Bot Activity Type` set to **Streaming** then `Bot Activity URL` will be shown and is required to be set by adding either a youtube or twitch stream url.

:::

Once installed, check the app logs to get the discord invite link that auto-generated and then invite the bot into your server.

The bot will play music only in voice channels.
