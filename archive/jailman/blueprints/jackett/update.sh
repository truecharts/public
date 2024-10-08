#!/usr/local/bin/bash
# This file contains the update script for jackett

iocage exec "$1" service jackett stop
#TODO insert code to update jacket itself here
iocage exec "$1" chown -R jackett:jackett /usr/local/share/Jackett /config
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/jackett/includes/jackett.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/jackett
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/jackett
iocage exec "$1" service jackett restart
