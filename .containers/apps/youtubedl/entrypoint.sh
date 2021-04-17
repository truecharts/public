#!/usr/bin/env bash

rm -R /data/*
cp -Rf /app/* /data
exec node /data/app.js ${@} ${EXTRA_ARGS}
