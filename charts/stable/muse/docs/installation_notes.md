---
title: Installation Notes
---

More information about the following `.Values.muse`:
- `discord.token` can be acquired [here](https://discordapp.com/developers/applications) by creating a 'New Application', then going to 'Bot' and press 'Reset Token'.
- `spotify.client.id` and `spotify.client.secret` can be acquired [here](https://developer.spotify.com/dashboard/applications) with 'Create a new app'
- `youtube.key` can be acquired by [creating a new project](https://console.developers.google.com/) in Google's Developer Console, enabling the YouTube API, and creating an API key under credentials.

Optionally you can set additional settings in the `.Values.muse.bot` en `.Values.muse.cache`. For more details check the `helm-release.yalm` and read the upstream documentation.

Once deployed, check the chart logs to get the discord invite link that auto-generated and then invite the bot into your server.

The bot will play music only in voice channels.
