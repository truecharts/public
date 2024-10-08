#!/usr/local/bin/bash
# This file contains the update script for Tautulli

iocage exec "$1" service tautulli stop
iocage exec "$1" ln -s /usr/local/bin/python3 /usr/local/bin/python
# Tautulli is updated through pkg, this is mostly just a placeholder
iocage exec "$1" chown -R tautulli:tautulli /usr/local/share/Tautulli /config
iocage exec "$1" cp /usr/local/share/Tautulli/init-scripts/init.freenas /usr/local/etc/rc.d/tautulli
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/tautulli
iocage exec "$1" service tautulli restart
