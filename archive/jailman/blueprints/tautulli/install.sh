#!/usr/local/bin/bash
# This file contains the install script for Tautulli

iocage exec "$1" ln -s /usr/local/bin/python3 /usr/local/bin/python
iocage exec "$1" git clone https://github.com/Tautulli/Tautulli.git /usr/local/share/Tautulli
iocage exec "$1" "pw user add tautulli -c tautulli -u 109 -d /nonexistent -s /usr/bin/nologin"
iocage exec "$1" chown -R tautulli:tautulli /usr/local/share/Tautulli /config
iocage exec "$1" cp /usr/local/share/Tautulli/init-scripts/init.freenas /usr/local/etc/rc.d/tautulli
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/tautulli
iocage exec "$1" sysrc "tautulli_enable=YES"
iocage exec "$1" sysrc "tautulli_flags=--datadir /config"
iocage exec "$1" service tautulli start