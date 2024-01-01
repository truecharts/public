---
title: Installation Notes
---

## Services

This chart provides two services:

- Main Service
- Admin Service

The Main Service provides the primary functionality of the chart, while the Admin service is used for first-time setup and generally does not need to be accessed afterwards.

## Configuration

The admin service **must** first be used to setup Kasm before the main service can be accessed.

Connect to the admin service at `https://HOST_IP:PORT` (10351 by default) and follow the prompts to complete the initial setup. Once you are at the dashboard you can switch over to the main service and login with the user you just configured.

:::info

You cannot use ingress to access the admin service, it must be accessed via host-ip/port.

:::

Attempting to access the main service before doing this will result in `ERR_CONNECTION_REFUSED`.

At this point, if you wish, you can change the admin service networking from `LoadBalancer` to `ClusterIP` to conceal its port since you likely won't need to access it again.
