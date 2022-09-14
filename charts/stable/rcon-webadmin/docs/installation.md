# Installation Guide

- Set `RWA_ENV` to **True** to use env variables. Setting this to **False** will use all default values.

- Set `RWA_ADMIN` to **True** to make the initial user a admin.

- Set `RWA_USERNAME` to any username for the web interface, defaults to **admin**.

- Set `RWA_PASSWORD` to a secure password for the web interface.

- Set `RWA_GAME` to a game such as minecraft | rust | csgo | other.

- Set `RWA_SERVER_NAME` to a custom name for the initial server.

- Set `RWA_RCON_HOST` To the initial RCON server IP to control. Cluster URL may work, but was not tested.

- Set `RWA_RCON_PORT` To the port number of the initial RCON server to control.

- Set `RWA_RCON_PASSWORD` to the password for the initial RCON server to control.

## Notes

- It's assumed that all game servers or services have secure passwords for RCON, blank or no passwords at all will **NOT** work and its advisable to set a secure password for both the web interface of this chart and also the rcon service too.
