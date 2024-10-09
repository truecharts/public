#!/usr/local/bin/bash
# This file contains the update script for mariadb

# shellcheck disable=SC2154
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
HOST_NAME="jail_${1}_host_name"
INCLUDES_PATH="${SCRIPT_DIR}/blueprints/mariadb/includes"

# Install includes fstab
iocage exec "${1}" mkdir -p /mnt/includes
iocage fstab -a "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0


iocage exec "${1}" service caddy stop
iocage exec "${1}" service php-fpm stop

fetch -o /tmp https://getcaddy.com
if ! iocage exec "${1}" bash -s personal "${DL_FLAGS}" < /tmp/getcaddy.com
then
    echo "Failed to download/install Caddy"
    exit 1
fi

# Copy and edit pre-written config files
echo "Copying Caddyfile for no SSL"
iocage exec "${1}" cp -f /mnt/includes/caddy /usr/local/etc/rc.d/
iocage exec "${1}" cp -f /mnt/includes/Caddyfile /usr/local/www/Caddyfile
# shellcheck disable=SC2154
iocage exec "${1}" sed -i '' "s/yourhostnamehere/${HOST_NAME}/" /usr/local/www/Caddyfile
iocage exec "${1}" sed -i '' "s/JAIL-IP/${JAIL_IP}/" /usr/local/www/Caddyfile

# Don't need /mnt/includes any more, so unmount it
iocage fstab -r "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0

iocage exec "${1}" service caddy start
iocage exec "${1}" service php-fpm start
