---
title: Installation Notes
---

Requires the following sysctl added to `System Settings` -> `Advanced` -> `sysctl`

- Variable: **net.ipv4.ping_group_range**
- Value: **0 2147483647**

Setting this up may require a reboot.

Go to [twingate](https://www.twingate.com/) and create a network.

Set your tenant name to **TwinGate Network**.
Optionally set a custom DNS to TwinGate DNS.

Setup a connector and generate your **TwinGate Access Token** and **TwinGate Refresh Token**.
