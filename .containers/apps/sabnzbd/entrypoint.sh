#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /usr/bin/python3 /app/SABnzbd.py --browser 0 --server 0.0.0.0:8080 --config-file /config/sabnzbd.ini ${EXTRA_ARGS}
