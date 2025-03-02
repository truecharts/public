---
title: Installation Guide
---

## Configuration

- Set the env. `TOKEN` to a long-lived token from Home Assistant. To create a long-lived token, click your user icon in the HA front end and look for the Long-Lived Access Tokens card under the tab security.

  - Create token and give it any name.
  - Copy the token and paste it in your deployment file.

- Set the env. `DASH_URL` to a http url of your assigned IP+port or your configured https Ingress URL.
  - HTTP example: `http://IP:PORT`
  - HTTPS example: `https://app.mydomain.tld`
- Set the env. `HA_URL` to the IP, URL or Cluster-URL + port. For example: `http://home-assistant.home-assistant.svc.cluster.local:8123`

- Set the env. `LATITUDE`, `LONGITUDE`, `ELEVATION` by the using this 3rd party [service](https://www.latlong.net/) or any service you want. It needs to match to what you set in HA, according to AppDaemon's docs.

## Example Deployment

```yaml
TZ: Pacific/Honolulu

workload:
  main:
    podSpec:
      containers:
        main:
          env:
            DASH_URL: "http://192.168.1.215:5050"
            HA_URL: "http://home-assistant.home-assistant.svc.cluster.local:8123"
            LATITUDE: 21.306944
            LONGITUDE: -157.858337
            ELEVATION: 1217
            TIMEZONE: "{{ .Values.TZ }}"
            TOKEN: "ThisShouldBeTheVeryLongLivedTokenFromHomeAssistant"
```
