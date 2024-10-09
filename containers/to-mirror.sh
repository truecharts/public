for i in $(cat ./to-mirror.txt); do

    PLAIN=${i##*/}
    PLAIN=$( echo $PLAIN | cut -d':' -f1 )
    CLEAN=${PLAIN//$'\r'/}
    echo ${CLEAN##*|}
    mkdir mirror/${CLEAN}
    echo "FROM ${i//$'\r'/}" >> mirror/${CLEAN}/Dockerfile
    echo 'LABEL "org.opencontainers.image.source"="https://github.com/truecharts/containers"' >> mirror/${CLEAN}/Dockerfile
    echo "linux/amd64" >> mirror/${CLEAN}/PLATFORM
    done
