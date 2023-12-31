---
title: Installation Guide
---

## Credentials

- Set `RWA USERNAME` to any username for the web interface, defaults to **admin**.
- Set `RWA PASSWORD` to a secure password for the web interface.
- Set `RWA RCON PASSWORD` to the password for the initial RCON server to control.

## Configuration

- Set `RWA ADMIN` to **true** to make the initial user a admin.
- Set `RWA ENV` to **true** to use env variables. Setting this to **false** will use all default values.
- Set `RWA_WEB_RCON` to **true** to enable web rcon _if_ supported by the game server
- Set `RWA_READ_ONLY_WIDGET_OPTIONS` to **true** to prevent the initial user changing options in the widget options tab
- Set `RWA GAME` to a game such as minecraft | rust | csgo | other.
- Set `RWA SERVER NAME` to a custom name for the initial server.
- Set `RWA RCON HOST` To the initial RCON server IP to control. Cluster URL may work, but was not tested.
- Set `RWA RCON PORT` To the port number of the initial RCON server to control.
- Set `RWA_RESTRICT_COMMANDS` to prevent the initial user user executing these commands
- Set `RWA_RESTRICT_WIDGETS` to hide this list of widgets from the initial user

## Notes

- It's assumed that all game servers or services have secure passwords for RCON, blank or no passwords at all will **NOT** work and its advisable to set a secure password for both the web interface of this chart and also the rcon service too.
