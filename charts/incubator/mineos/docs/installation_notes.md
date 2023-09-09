# Installation Notes

- Set `USE_HTTPS` to **false**, to use **http** for the web interface. However, if using ingress set `USE_HTTPS` to **true**.

- Set `USER_NAME` to **mc** or whatever username that you want other than ~~root~~, to set the user for the web interface.

- Set `USER_PASSWORD` to **MySuperSecurePass1** or an actual super secure password, to set the user pass for the web interface.

- The servers are stored in `/var/games/minecraft/*SERVER_NAME*` so in order to add plugins/mods/additional files if the config volume is set to PVC(simple) which is default...is to use the bash truetool to mount the pvc volume to a temporarily dataset/dir, here's the guide for [truetool](https://truecharts.org/manual/SCALE/guides/pvc-access).

- To add additional ports to run your minecraft servers, please follow the [minecraft-java guide](https://truecharts.org/charts/stable/minecraft-java/community-guide#pluginsmods-that-need-additional-ports) at the extra ports section.
