---
title: Installation Guide
---

- Set `HA Token` to a Long Live HA token that can be found by going to your profile and then at bottom of the page you will see `Long-Lived Access Tokens`.

  - Create token and give it any name.
  - Copy the token and paste it to the above field.

- Set `HA URL` to the IP or cluster url + port, for ex: `http://home-assistant.ix-home-assistant.svc.cluster.local:8123`
- Set `Dashboard URL` to a http/s url.

  - HTTP ex: `http://IP:PORT`
  - HTTPS ex: `https://app.mydomain.tld`

- Set `Latitude`, `Longitude`, `ELEVATION` by the using this 3rd party [service](https://www.latlong.net/) or any service you want. It needs to match to what you set in HA, according to AppDaemon's docs.
