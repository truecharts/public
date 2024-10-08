#!/usr/local/bin/bash
# This file contains the update script for sonarr

iocage exec "$1" service sonarr stop
#TODO insert code to update sonarr itself here
iocage exec "$1" chown -R sonarr:sonarr /usr/local/share/NzbDrone /config
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/sonarr/includes/sonarr.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/sonarr
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/sonarr
iocage exec "$1" service sonarr restart
