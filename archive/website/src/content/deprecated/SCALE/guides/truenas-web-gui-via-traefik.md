---
title: Accessing the TrueNAS SCALE Web GUI via Traefik
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

If you followed the instructions in [Installing Traefik](/charts/premium/traefik/how-to), your TrueNAS Web GUI will now be served on custom ports (port 81 and 444 in the video guide).

To access the TrueNAS Web GUI via Traefik on port 443, use the `external-service` app:

1. Set `External Service IP` to the ip address of your TrueNAS server
2. Set `Port Type` to `HTTPS`
3. Set `Service Port` to the same value as `Web Interface HTTPS Port` in the TrueNAS GUI Settings (`444` if you followed [Installing Traefik](/charts/premium/traefik/how-to))
4. Setup Ingress according to guide 12 (set the `Host` and `HostName` values to e.g. truenas.example.com)

Now, Traefik will serve the TrueNAS Web GUI over HTTPS on truenas.example.com. Ensure your DNS points truenas.example.com to the ip address of your TrueNAS server.

To check if you setup everything correctly, compare your settings to the settings in this screenshot:

![Screenshot with External Service settings overview](./img/truenas-web-gui-via-traefik-screenshot.png)

Once your External Service is deployed, you can get this overview by choosing "Edit" from the External Service menu (three dots).
