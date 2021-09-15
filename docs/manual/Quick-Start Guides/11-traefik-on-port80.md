# 11 - Exposing Traefik on port 80/443

#### Video Guide

![type:video](https://www.youtube.com/embed/UHuyn9qCY6g)

Afterwards you can follow `16 - Setting up External-Services` if you don't want to access the TrueNAS web gui using the new ports (port 81 and 444 in the video guide). When setting up the `External Service`, set `External Service IP` to the ip address of your TrueNAS server, `Port Type` to `HTTP` and `Service Port` to `81`. You can set the `Host` and `HostName` values to the hostname of your TrueNAS server e.g. truenas.example.com. Now Traefik will serve the TrueNAS web gui over HTTPS on truenas.example.com. Ensure your DNS points truenas.example.com to the ip address of your TrueNAS server.
