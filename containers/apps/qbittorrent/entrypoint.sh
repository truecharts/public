#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

if [[ ! -f "/config/qBittorrent/qBittorrent.conf" ]]; then
    mkdir -p /config/qBittorrent
    cp /app/qBittorrent.conf /config/qBittorrent/qBittorrent.conf
fi

exec /app/qbittorrent-nox --webui-port="${WEBUI_PORT}" ${EXTRA_ARGS}
