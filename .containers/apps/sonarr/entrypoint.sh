#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /usr/bin/mono --debug /app/Sonarr.exe --nobrowser --data=/config ${EXTRA_ARGS}
