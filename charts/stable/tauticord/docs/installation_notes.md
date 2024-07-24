---
title: Installation Notes
---

Basic Notes for tauticord.

:::note[requirements]

- A Plex Media Server
- Tautulli (formerly known as PlexPy)
- A Discord server
- A Discord bot token, a simple guide [here](https://www.digitaltrends.com/gaming/how-to-make-a-discord-bot/).
  - Permissions required:
    - Manage Channels
    - View Channels
    - Send Messages
    - Manage Messages
    - Read Message History
    - Add Reactions
    - Manage Emojis
  - Example bot invite link: `https://discord.com/oauth2/authorize?client_id=YOUR_APPLICATION_ID&scope=bot&permissions=1073818704`

:::

:::note[Common Issues]

- On startup, Tauticord attempts to upload a set of custom emojis that it will use when displaying stream information ( if they do not already exist). Your bot will need to have the Manage Emojis permission in order to do this.
- Discord has a limit of 50 custom emojis per server. If you have reached this limit, you will need to remove some of your existing emojis before Tauticord can upload its own.
- If you do not want to remove any of your existing emojis, Tauticord will simply skip uploading its own emojis and use the default emojis that Discord provides instead.

:::
