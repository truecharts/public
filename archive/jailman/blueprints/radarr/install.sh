#!/usr/local/bin/bash
# This file contains the install script for radarr

# Check if dataset for completed download and it parent dataset exist, create if they do not.
# shellcheck disable=SC2154
createmount "$1" "${global_dataset_downloads}"
createmount "$1" "${global_dataset_downloads}"/complete /mnt/fetched

# Check if dataset for media library and the dataset for movies exist, create if they do not.
# shellcheck disable=SC2154
createmount "$1" "${global_dataset_media}"
createmount "$1" "${global_dataset_media}"/movies /mnt/movies

iocage exec "$1" "fetch https://github.com/Radarr/Radarr/releases/download/v0.2.0.1480/Radarr.develop.0.2.0.1480.linux.tar.gz -o /usr/local/share"
iocage exec "$1" "tar -xzvf /usr/local/share/Radarr.develop.0.2.0.1480.linux.tar.gz -C /usr/local/share"
iocage exec "$1" rm /usr/local/share/Radarr.develop.0.2.0.1480.linux.tar.gz
iocage exec "$1" "pw user add radarr -c radarr -u 352 -d /nonexistent -s /usr/bin/nologin"
iocage exec "$1" chown -R radarr:radarr /usr/local/share/Radarr /config
iocage exec "$1" mkdir /usr/local/etc/rc.d
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/radarr/includes/radarr.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/radarr
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/radarr
iocage exec "$1" sysrc "radarr_enable=YES"
iocage exec "$1" service radarr restart
