#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /app/Ombi --host http://0.0.0.0:3579 --storage /config ${EXTRA_ARGS}
