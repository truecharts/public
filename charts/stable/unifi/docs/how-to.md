---
title: How-To
---

## L3 Adoption (DNS)

One solution to solve problems when trying to adopt devices is to
correctly configure your DNS server.

By default all Unifi Devices try to resolve `unifi.localdomain`,
to find the controller. Even adopted devices, uses this as a fallback.

What you have to do is configure your DNS server, to resolve
`unifi.localdomain` to the IP of your Unifi Controller. So the devices can find the
controller.

:::tip

Replace `localdomain` with whatever domain you have on your LAN.

:::

:::caution

This will only work if you use the default port (8080), on your Unifi controller

:::

For more information and solutions for L3 Adoption you can read this
[article](https://help.ui.com/hc/en-us/articles/204909754-UniFi-Network-Layer-3-Adoption)
on Unifi's website.
