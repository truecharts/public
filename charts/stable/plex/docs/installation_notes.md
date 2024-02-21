---
title: Plex Installation Notes
---

## Public Port

- The LAN port used by Plex (32400) is hardcoded and cannot be changed. Because of this do not change the port in the Plex app config from 32400. If you need to run Plex on a different public port you will need to setup port forwarding on a router from the public port to 32400 on your server IP. You will also need to change the public port in the remote access section of Plex settings.

## Require HTTPS

![Plex App Config](./img/Plex-App-Config.png)

- This option cannot be enabled until initial plex setup is complete and remote access is enabled and functioning as shown below.

![remote access](./img/plex-remote-access.png)

## Plug-ins

Plex allows for the installation of plug-ins. Plug-ins can be added using the codeserver addon.

1. Enable the codeserver addon in Plex application configuration.
   ![codeserver-addon](./img/plex-codeserver-addon.png)
2. Access codeserver using the previously configured port (ie. `http://192.168.1.2:36107`).
3. Browse to the plug-ins folder in codeserver.
   ![codeserver-browse](./img/plex-codeserver-browse.png)
4. Upload plugins.
   ![codeserver-upload](./img/plex-codeserver-upload.png)
5. Restart Plex
