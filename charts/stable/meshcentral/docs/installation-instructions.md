---
title: Installation instructions
---

:::caution

Ingress for this chart is **required**

:::

## Unset Keys

Keys that start with `_` are **unset**.

## Hardcoded values

We hardcoded some values, so the chart can work correctly based on how it's written.
Those values are:

```json
{
  "$schema": "http://info.meshcentral.com/downloads/meshcentral-config-schema.json",
  "settings": {
    "mongoDB": "actual-generated-mongodb-url",
    "mongoDbName": "actual-mongodb-name",
    "sessionKey": "32char-long-random-generated-key",
    "port": "to-the-same-port-as-your-main-service",
    "selfUpdate": false,
    "cleanNpmCacheOnUpdate": false
  },
  "domains": {
    // This applies to ALL domains
    "": {
      "myServer": {
        "Upgrade": false
      }
    }
  }
}
```
