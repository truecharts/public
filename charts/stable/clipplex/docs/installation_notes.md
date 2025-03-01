---
title: Installation Notes
---

- Set the env. `PLEX_TOKEN` to your plex token, info [here](https://support.plex.tv/articles/204059436-finding-an-authentication-token-x-plex-token/).

- Optionally the env. `STREAMABLE_LOGIN` and `STREAMABLE_PASSWORD` to your account details.

- Set the env. `PLEX_URL` to the url of Plex, typically you can use:

  - `http://plex.plex.svc.cluster.local:32400`
  - `http://IP:32400`
  - `https://plex.mydomain.tld`

- In order for this to work you will need to add your media through additional storage and mount the same internal dir that you used in plex.
  - ex: `/media`
