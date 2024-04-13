---
title: Installation Notes
---

## TRAKT.TV Setup

- Please create an [app](https://trakt.tv/oauth/applications/new) in trakt.tv.
- Set the trakt app name to whatever you like for ex: `plaxt`.
- Optionally set an icon, you can download this [icon](/img/hotlink-ok/chart-icons/plaxt.png).
- Set the redirect uri to for ex (must end with `/authorize`):
- `https://plaxt.mydomain.com/authorize`.
- `https://my_public_ip:8000/authorize`.
- Set the option `/scrobble` to `true`.
- Copy both the Client ID and Secret as you will need both to setup the `plaxt` chart in the next section.

## Plaxt Setup

- Set `TRAKT_ID` with your custom trakt.tv app's client id.
- Set `TRAKT_SECRET` with your trakt.tv app's client secret.

- After launching the chart it will ask you to add your plex username in `Step 1`.
- Click the `authorize` button to authorize your custom app aka `plaxt` with trakt.tv.
- If successful, you will be given a generated webhook to add to plex in `Step 2`.

- Go to plex -> settings -> webhooks -> add the webhook.
- Profit.

Notes:

- This chart depends on plex webhooks which is a `Plex Pass` feature.
- The upstream project is no longer in development as Trakt has [official support](https://blog.trakt.tv/plex-scrobbler-52db9b016ead) for Plex Webhooks.
