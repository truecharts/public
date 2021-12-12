#!/usr/bin/env bash

# The format of the to-app.txt file is as follows:
# PORT:tccr.io/truecharts/CHART:TAG

for i in $(cat to-app.txt); do

    SOURCE=${i##*/}
    PORT=$( echo $i | cut -d':' -f1 )
    PLAIN=$( echo $SOURCE | cut -d':' -f1 )
    TAG=$( echo $SOURCE | cut -d':' -f2 )
    CLEANTAG=${TAG//$'\r'/}
    CLEANPORT=${PORT//$'\r'/}
    CLEAN=${PLAIN//$'\r'/}
    echo "${CLEAN##*|} ${CLEANTAG}"
    mkdir -p charts/dev/${CLEAN}
    cp -rf templates/app/* charts/dev/${CLEAN}
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/Chart.yaml
    sed -i "s|CHARTNAME|${CLEAN}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTTAG|${CLEANTAG}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTPORT|${CLEANPORT}|g" charts/dev/${CLEAN}/values.yaml
    sed -i "s|CHARTPORT|${CLEANPORT}|g" charts/dev/${CLEAN}/questions.yaml
    done
