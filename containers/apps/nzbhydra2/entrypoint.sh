#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

exec /usr/bin/python3 /app/nzbhydra2wrapperPy3.py --nobrowser --datafolder /config ${EXTRA_ARGS}
