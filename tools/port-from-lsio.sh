#!/usr/bin/env bash

# The format of the to-app.txt file is as follows:
# tccr.io/truecharts/CHART:TAG

for i in $(cat to-app.txt); do

    PLAIN=${i##*/}
    PLAIN=$( echo $PLAIN | cut -d':' -f1 )
    CLEAN=${PLAIN//$'\r'/}
    echo ${CLEAN##*|}
    PORT=$(curl -v --silent https://raw.githubusercontent.com/linuxserver/docker-${CLEAN}/master/README.md | grep " \-p" | grep ':' | head -1 | cut -d':' -f1 | cut -d' ' -f4)
    echo "${PORT}:${i}" >> output.txt
    done
