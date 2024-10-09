#!/usr/local/bin/bash
# This script installs the current release of Mariadb and PhpMyAdmin into a created jail
#####
#
# Init and Mounts
#
#####

# Initialise defaults
# shellcheck disable=SC2154
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
INCLUDES_PATH="${SCRIPT_DIR}/blueprints/mariadb/includes"
# shellcheck disable=SC2154
CERT_EMAIL="jail_${1}_cert_email"
CERT_EMAIL="${!CERT_EMAIL:-placeholder@email.fake}"
# shellcheck disable=SC2154
DB_ROOT_PASSWORD="jail_${1}_db_root_password"
HOST_NAME="jail_${1}_host_name"
DL_FLAGS=""
DNS_ENV=""

# Check that necessary variables were set by nextcloud-config
if [ -z "${JAIL_IP}" ]; then
  echo 'Configuration error: The mariadb jail does NOT accept DHCP'
  echo 'Please reinstall using a fixed IP adress'
  exit 1
fi

# Make sure DB_PATH is empty -- if not, MariaDB/PostgreSQL will choke
# shellcheck disable=SC2154
if [ "$(ls -A "/mnt/${global_dataset_config}/${1}/db")" ]; then
    echo "Reinstall of mariadb detected... Continuing"
    REINSTALL="true"
fi

# Mount database dataset and set zfs preferences
iocage exec "${1}" rm -Rf /usr/local/etc/mysql/my.cnf
createmount "${1}" "${global_dataset_config}"/"${1}"/db /config/db
zfs set recordsize=16K "${global_dataset_config}"/"${1}"/db
zfs set primarycache=metadata "${global_dataset_config}"/"${1}"/db

iocage exec "${1}" "pw groupadd -n mysql -g 88"
iocage exec "${1}" "pw useradd -n mysql -u 88 -d /nonexistent -s /usr/sbin/nologin -g mysql"

iocage exec "${1}" chown -R mysql:mysql /config

iocage exec "${1}" sysrc mysql_optfile=/config/my.cnf
iocage exec "${1}" sysrc mysql_dbdir=/config/db
iocage exec "${1}" sysrc mysql_pidfile=/config/mysql.pid
iocage exec "${1}" sysrc mysql_enable="YES"

# Install includes fstab
iocage exec "${1}" mkdir -p /mnt/includes
iocage fstab -a "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0

iocage exec "${1}" cp -f /mnt/includes/my.cnf /config/my.cnf
iocage exec "${1}" cp -f /mnt/includes/config.inc.php /usr/local/www/phpMyAdmin/config.inc.php
iocage exec "${1}" sed -i '' "s|mypassword|${!DB_ROOT_PASSWORD}|" /config/my.cnf
iocage exec "${1}" ln -s /config/my.cnf /usr/local/etc/mysql/my.cnf

#####
#
# Install Caddy and PhpMyAdmin
#
#####

fetch -o /tmp https://getcaddy.com
if ! iocage exec "${1}" bash -s personal "${DL_FLAGS}" < /tmp/getcaddy.com
then
    echo "Failed to download/install Caddy"
    exit 1
fi

# Copy and edit pre-written config files
echo "Copying Caddyfile for no SSL"
iocage exec "${1}" cp -f /mnt/includes/caddy.rc /usr/local/etc/rc.d/caddy
iocage exec "${1}" cp -f /mnt/includes/Caddyfile /usr/local/www/Caddyfile
# shellcheck disable=SC2154
iocage exec "${1}" sed -i '' "s/yourhostnamehere/${!HOST_NAME}/" /usr/local/www/Caddyfile
iocage exec "${1}" sed -i '' "s/JAIL-IP/${JAIL_IP}/" /usr/local/www/Caddyfile

iocage exec "${1}" sysrc caddy_enable="YES"
iocage exec "${1}" sysrc php_fpm_enable="YES"
iocage exec "${1}" sysrc caddy_cert_email="${CERT_EMAIL}"
iocage exec "${1}" sysrc caddy_env="${DNS_ENV}"

iocage restart "${1}"
sleep 10

if [ "${REINSTALL}" == "true" ]; then
    echo "Reinstall detected, skipping generaion of new config and database"
else

    # Secure database, set root password, create Nextcloud DB, user, and password
    iocage exec "${1}" mysql -u root -e "DELETE FROM mysql.user WHERE User='';"
    iocage exec "${1}" mysql -u root -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    iocage exec "${1}" mysql -u root -e "DROP DATABASE IF EXISTS test;"
    iocage exec "${1}" mysql -u root -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    iocage exec "${1}" mysqladmin --user=root password "${!DB_ROOT_PASSWORD}"
    iocage exec "${1}" mysqladmin reload
fi

# Save passwords for later reference
iocage exec "${1}" echo "MariaDB root password is ${!DB_ROOT_PASSWORD}" > /root/"${1}"_db_password.txt


# Don't need /mnt/includes any more, so unmount it
iocage fstab -r "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0

# Done!
echo "Installation complete!"
echo "Using your web browser, go to http://${!HOST_NAME} to log in"

if [ "${REINSTALL}" == "true" ]; then
    echo "You did a reinstall, please use your old database and account credentials"
else
    echo "Database Information"
    echo "--------------------"
    echo "The MariaDB root password is ${!DB_ROOT_PASSWORD}"
    fi
echo ""
echo "All passwords are saved in /root/${1}_db_password.txt"
