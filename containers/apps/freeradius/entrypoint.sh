#!/bin/sh
set -e

if [ -f "/etc/raddb/clients.conf" ]; then
  echo "Radius config already exists, skipping config copy..."
else
  echo "Radius config does not exist, copying..."
  cp -Rf /etc/freeradius/* /etc/raddb/
fi

chown -R freerad:freerad /etc/raddb/

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- freeradius "$@"
fi

# check for the expected command
if [ "$1" = 'freeradius' ]; then
    shift
    exec freeradius -f "$@"
fi

# many people are likely to call "radiusd" as well, so allow that
if [ "$1" = 'radiusd' ]; then
    shift
    exec freeradius -f "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"
