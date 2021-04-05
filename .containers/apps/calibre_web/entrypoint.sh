#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"

# create symlinks for database and log
[[ ! -f /config/app.db ]] && \
	cp /app/defaults/app.db /config/app.db
[[ -f /app/app.db ]] && \
	rm /app/app.db
[[ ! -L /app/app.db ]] && \
	ln -s /config/app.db /app/app.db

# create symlinks for log
[[ ! -f /config/calibre-web.log ]] && \
	touch /config/calibre-web.log
[[ -f /app/calibre-web.log ]] && \
	rm /app/calibre-web.log
[[ ! -L /app/calibre-web.log ]] && \
	ln -s /config/calibre-web.log /app/calibre-web.log

# create Google drive client_secrets.json file
[[ ! -f /config/client_secrets.json ]] && \
	echo "{}" > /config/client_secrets.json
[[ -f /app/client_secrets.json ]] &&
	rm /app/client_secrets.json
[[ ! -L /app/client_secrets.json ]] &&
	ln -s /config/client_secrets.json /app/client_secrets.json

# create Google drive symlinks for database
[[ ! -f /config/gdrive.db ]] && \
	cp /app/gdrive.db /config/gdrive.db
[[ -f /app/gdrive.db ]] && \
	rm /app/gdrive.db
[[ ! -L /app/gdrive.db ]] && \
	ln -s /config/gdrive.db /app/gdrive.db


exec python3 /app/cps.py
