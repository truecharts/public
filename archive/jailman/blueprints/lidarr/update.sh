#!/usr/local/bin/bash
# This file contains the update script for lidarr

iocage exec "$1" service lidarr stop
#TODO insert code to update lidarr itself here
iocage exec "$1" chown -R lidarr:lidarr /usr/local/share/lidarr /config
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/lidarr/includes/lidarr.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/lidarr
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/lidarr
iocage exec "$1" service lidarr restart
