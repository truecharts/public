---
title: Automatic Gluetun Port Forwarding
---

qBittorrent can be configured to automatically utilize the VPN forward port when used with Gluetun for ProtonVPN and PIA, all other VPN providers should be configured manually as the port does not change.

:::danger[GLUETUN PORT FORWARDING REQUIRED]

qBittorrent will fail to start if Gluetun is not configured for use with port forwarding enabled.

:::

You are required to provide the qBittorrent WebUI username and password. Because of this requirement you _CANNOT_ enable this feature until you have completed the installation of qBittorrent and configured the WebUI username and password in the qBittorrent settings first.

To enable automatic port forwarding add to your `.Values`:

```yaml
qbitportforward:
  enabled: true
  QBT_USERNAME: "admin"
  QBT_PASSWORD: "adminadmin"
```

