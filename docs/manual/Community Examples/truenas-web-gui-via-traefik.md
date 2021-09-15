# TrueNAS Web GUI via Traefik on port 443

If you followed the instructions in `11 - Exposing Traefik on port 80/443` from the `Quick Start Guides`, your TrueNAS Web GUI will now be served on custom ports (port 81 and 444 in the video guide).

If you don't want to access the TrueNAS Web GUI using these custom ports, you can follow the instructions in guide `16 - Setting up External-Services` to access the TrueNAS Web GUI via Traefik on port 443.

When setting up the `External Service`:
- Set `External Service IP` to the ip address of your TrueNAS server
- Set `Port Type` to `HTTPS`
- Set `Service Port` to the same value as `Web Interface HTTPS Port` in the TrueNAS GUI Settings (`444` if you followed `11 - Exposing Traefik on port 80/443`)
- Setup Ingress according to guide 12 (set the `Host` and `HostName` values to e.g. truenas.example.com)

Now Traefik will serve the TrueNAS Web GUI over HTTPS on truenas.example.com. Ensure your DNS points truenas.example.com to the ip address of your TrueNAS server.

To check if you setup everything correctly, compare your settings to the settings in this screenshot:

![Screenshot with External Service settings overview](./truenas-web-gui-via-traefik-screenshot.png?raw=true "Screenshot with External Service settings overview")

Once your External Service is deployed, you can get this overview by choosing "Edit" from the External Service menu (three dots).