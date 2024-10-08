#!/usr/local/bin/bash
# This file contains the install script for jackett

iocage exec "$1" "fetch https://github.com/Jackett/Jackett/releases/download/v0.16.546/Jackett.Binaries.Mono.tar.gz -o /usr/local/share"
iocage exec "$1" "tar -xzvf /usr/local/share/Jackett.Binaries.Mono.tar.gz -C /usr/local/share"
iocage exec "$1" rm /usr/local/share/Jackett.Binaries.Mono.tar.gz
iocage exec "$1" "pw user add jackett -c jackett -u 818 -d /nonexistent -s /usr/bin/nologin"
iocage exec "$1" chown -R jackett:jackett /usr/local/share/Jackett /config
iocage exec "$1" mkdir /usr/local/etc/rc.d
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/jackett/includes/jackett.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/jackett
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/jackett
iocage exec "$1" sysrc "jackett_enable=YES"
iocage exec "$1" service jackett restart
