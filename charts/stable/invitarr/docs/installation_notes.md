---
title: Installation Notes
---

- Create a discord bot [here](https://discord.com/developers/applications).
- Enable Intents else bot will not _DM_ users after they get the role.
- Invite the bot with `Administrator` permission.

- In your discord server run the following commands in any channel that the bot has access to, you will be DM by the bot for the reply:

- `.setupplex`

  - Authenticate with your _**plex**_ `username` | `email` | `token` and `password`.

- `.roleadd @role`

  - This is the role that will trigger the bot to get the email from the user and invite them to Plex.

- `.setuplibs`
  - By default when a user is invited to plex they will have access to all Libraries. However you can bypass that with the above command.
    - a comma separated list. Remember this is case sensitive. No spaces before or after comma. Example: `Animes,Movies,Tv Shows`.

:::note

Auto Plex invite only works when someone is given this role and won't message the user if they already have this role.

:::
