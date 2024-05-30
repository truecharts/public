---
title: How To
---

You can use the following json code to construct a json object to be used for the `config` field or use the upstream doc for your specific domain provider [here](https://github.com/qdm12/ddns-updater#configuration):

My domain provider is `cloudflare`.

The `zone_identifier` or `Zone ID` is _per_ domain and can be found in the overview of the website/domain.

My host or the `A record` is set to `@`.

If the record is proxied through CLoudflare, set `proxied` to `true` or otherwise `false`.

The `token` is different from the API key. Please go to [api-tokens](https://dash.cloudflare.com/profile/api-tokens) in Cloudflare to create a `Edit zone DNS` token for your specific zone or domain.

:::caution

For security purposes create multiple different tokens for every domain you plan to add. **DO NOT** use a global token.

:::

The `ip_version` should always be `ipv4` unless your special :/.

```json
{
  "settings": [
    {
      "provider": "cloudflare",
      "zone_identifier": "ZONE_ID",
      "domain": "MY_DOMAIN_1.com",
      "host": "@",
      "proxied": true,
      "ttl": 600,
      "token": "TOKEN_1",
      "ip_version": "ipv4"
    },
    {
      "provider": "cloudflare",
      "zone_identifier": "ZONE_ID_2",
      "domain": "MY_DOMAIN_2.com",
      "host": "@",
      "proxied": true,
      "ttl": 600,
      "token": "TOKEN_2",
      "ip_version": "ipv4"
    },
    {
      "provider": "cloudflare",
      "zone_identifier": "ZONE_ID_3",
      "domain": "MY_DOMAIN_3.com",
      "host": "@",
      "proxied": true,
      "ttl": 600,
      "token": "TOKEN_3",
      "ip_version": "ipv4"
    }
  ]
}
```

:::tip

You can also reach us using Discord for real-time feedback and support
If you found a bug in our chart, open a Github issue but generally it's advised to contact us on Discord first in most cases.

:::
