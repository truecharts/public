#!/bin/sh
set -e

if [ -f "/config/clients.conf" ]; then
  echo "Radius config already exists, skipping config copy..."
else
  echo "Radius config does not exist, copying..."
  cp -Rf /etc/raddb/* /config/
fi

chown -R freerad:freerad /config


exec freeradius -f -d /config "$@"
