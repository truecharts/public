---
title: How To
---

:::caution

This chart requires **aria2** to be installed or otherwise reachable.

:::

To connect to **aria2** in ariang webGUI. Go to `Ariang Settings` and click on the first RPC option.

The example below uses ingress so the rpc protocol defaults to `https` and the port should be set to `443`. If you don't use ingress at all then protocol can be set to `http` and the port can be defaulted to `6800` or whatever port you set in `aria2`.

![ariang-ingress](./img/ariang-ingress.png)
