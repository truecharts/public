#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /usr/bin/python3 /app/Tautulli.py --nolaunch --config /config/config.ini --datadir /config ${EXTRA_ARGS}
