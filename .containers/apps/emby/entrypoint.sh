#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

export LD_LIBRARY_PATH="${APP_DIR}"
export FONTCONFIG_PATH="${APP_DIR}"/etc/fonts
if [ -d "/lib/x86_64-linux-gnu" ]; then
	export LIBVA_DRIVERS_PATH=/usr/lib/x86_64-linux-gnu/dri:"${APP_DIR}"/dri
fi
export SSL_CERT_FILE="${APP_DIR}"/etc/ssl/certs/ca-certificates.crt

exec /app/EmbyServer \
	-programdata /config \
	-ffdetect /app/ffdetect \
	-ffmpeg /app/ffmpeg \
	-ffprobe /app/ffprobe \
	-restartexitcode 3
