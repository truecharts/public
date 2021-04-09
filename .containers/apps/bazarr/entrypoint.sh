#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /usr/bin/python3 /app/bazarr.py --no-update --config /config ${EXTRA_ARGS}
