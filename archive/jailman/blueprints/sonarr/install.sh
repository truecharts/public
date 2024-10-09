#!/usr/local/bin/bash
# This file contains the install script for sonarr

# Check if dataset for completed download and it parent dataset exist, create if they do not.
# shellcheck disable=SC2154
createmount "$1" "${global_dataset_downloads}"
createmount "$1" "${global_dataset_downloads}"/complete /mnt/fetched

# Check if dataset for media library and the dataset for tv shows exist, create if they do not.
# shellcheck disable=SC2154
createmount "$1" "${global_dataset_media}"
createmount "$1" "${global_dataset_media}"/shows /mnt/shows

iocage exec "$1" "fetch http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz -o /usr/local/share"
iocage exec "$1" "tar -xzvf /usr/local/share/NzbDrone.master.tar.gz -C /usr/local/share"
iocage exec "$1" rm /usr/local/share/NzbDrone.master.tar.gz
iocage exec "$1" "pw user add sonarr -c sonarr -u 351 -d /nonexistent -s /usr/bin/nologin"
iocage exec "$1" chown -R sonarr:sonarr /usr/local/share/NzbDrone /config
iocage exec "$1" mkdir /usr/local/etc/rc.d
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/sonarr/includes/sonarr.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/sonarr
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/sonarr
iocage exec "$1" sysrc "sonarr_enable=YES"
iocage exec "$1" service sonarr restart
