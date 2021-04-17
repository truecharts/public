#!/usr/bin/env bash

echo "Patching youtubedl-material"
cd /data
find . -maxdepth 1 ! -name users ! -name appdata  -exec rm -Rf {} +
cp -Rn /app/* /data
exec node /data/app.js ${@} ${EXTRA_ARGS}
