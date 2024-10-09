#!/usr/local/bin/bash
# This file contains the install script for bitwarden

# Initialise defaults
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
HOST_NAME="jail_${1}_host_name"

DB_DATABASE="jail_${1}_db_database"
DB_DATABASE="${!DB_DATABASE:-$1}"

DB_USER="jail_${1}_db_user"
DB_USER="${!DB_USER:-$DB_DATABASE}"

# shellcheck disable=SC2154
INSTALL_TYPE="jail_${1}_db_type"
INSTALL_TYPE="${!INSTALL_TYPE:-mariadb}"

DB_JAIL="jail_${1}_db_jail"
# shellcheck disable=SC2154
DB_HOST="jail_${!DB_JAIL}_ip4_addr"
DB_HOST="${!DB_HOST%/*}:3306"

# shellcheck disable=SC2154
DB_PASSWORD="jail_${1}_db_password"
DB_STRING="mysql://${DB_USER}:${!DB_PASSWORD}@${DB_HOST}/${DB_DATABASE}"
# shellcheck disable=SC2154
ADMIN_TOKEN="jail_${1}_admin_token"

if [ -z "${!DB_PASSWORD}" ]; then
    echo "db_password can't be empty"
    exit 1
fi

if [ -z "${!DB_JAIL}" ]; then
    echo "db_jail can't be empty"
    exit 1
fi

if [ -z "${!JAIL_IP}" ]; then
    echo "ip4_addr can't be empty"
    exit 1
fi

if [ -z "${!ADMIN_TOKEN}" ]; then
ADMIN_TOKEN=$(openssl rand -base64 16)
fi

# install latest rust version, pkg version is outdated and can't build bitwarden_rs
iocage exec "${1}" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# Install Bitwarden_rs
iocage exec "${1}" mkdir -p /usr/local/share/bitwarden/src
iocage exec "${1}" git clone https://github.com/dani-garcia/bitwarden_rs/ /usr/local/share/bitwarden/src
TAG=$(iocage exec "${1}" "git -C /usr/local/share/bitwarden/src tag --sort=v:refname | tail -n1")
iocage exec "${1}" "git -C /usr/local/share/bitwarden/src checkout ${TAG}"
#TODO replace with: cargo build --features mysql --release
if [ "${INSTALL_TYPE}" == "mariadb" ]; then
    iocage exec "${1}" "cd /usr/local/share/bitwarden/src && $HOME/.cargo/bin/cargo build --features mysql --release"
    iocage exec "${1}" "cd /usr/local/share/bitwarden/src && $HOME/.cargo/bin/cargo install diesel_cli --no-default-features --features mysql"
else
    iocage exec "${1}" "cd /usr/local/share/bitwarden/src && $HOME/.cargo/bin/cargo build --features sqlite --release"
    iocage exec "${1}" "cd /usr/local/share/bitwarden/src && $HOME/.cargo/bin/cargo install diesel_cli --no-default-features --features sqlite-bundled"
fi


iocage exec "${1}" cp -r /usr/local/share/bitwarden/src/target/release /usr/local/share/bitwarden/bin

# Download and install webvault
WEB_RELEASE_URL=$(curl -Ls -o /dev/null -w "%{url_effective}" https://github.com/dani-garcia/bw_web_builds/releases/latest)
WEB_TAG="${WEB_RELEASE_URL##*/}"
iocage exec "${1}" "fetch http://github.com/dani-garcia/bw_web_builds/releases/download/$WEB_TAG/bw_web_$WEB_TAG.tar.gz -o /usr/local/share/bitwarden"
iocage exec "${1}" "tar -xzvf /usr/local/share/bitwarden/bw_web_$WEB_TAG.tar.gz -C /usr/local/share/bitwarden/"
iocage exec "${1}" rm /usr/local/share/bitwarden/bw_web_"$WEB_TAG".tar.gz

# shellcheck disable=SC2154
if [ -f "/mnt/${global_dataset_config}/${1}/ssl/bitwarden-ssl.crt" ]; then
    echo "certificate exist... Skipping cert generation"
else
    "No ssl certificate present, generating self signed certificate"
    if [ ! -d "/mnt/${global_dataset_config}/${1}/ssl" ]; then
        echo "cert folder not existing... creating..."
        iocage exec "${1}" mkdir /config/ssl
    fi
    openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost" -keyout /mnt/"${global_dataset_config}"/"${1}"/ssl/bitwarden-ssl.key -out /mnt/"${global_dataset_config}"/"${1}"/ssl/bitwarden-ssl.crt
fi

if [ -f "/mnt/${global_dataset_config}/${1}/bitwarden.log" ]; then
    echo "Reinstall of Bitwarden detected... using existing config and database"
elif [ "${INSTALL_TYPE}" == "mariadb" ]; then
    echo "No config detected, doing clean install, utilizing the Mariadb database ${DB_HOST}"
    iocage exec "${!DB_JAIL}" mysql -u root -e "CREATE DATABASE ${DB_DATABASE};"
    iocage exec "${!DB_JAIL}" mysql -u root -e "GRANT ALL ON ${DB_DATABASE}.* TO ${DB_USER}@${JAIL_IP} IDENTIFIED BY '${!DB_PASSWORD}';"
    iocage exec "${!DB_JAIL}" mysqladmin reload
else
    echo "No config detected, doing clean install."
fi

iocage exec "${1}" "pw user add bitwarden -c bitwarden -u 725 -d /nonexistent -s /usr/bin/nologin"
iocage exec "${1}" chown -R bitwarden:bitwarden /usr/local/share/bitwarden /config
iocage exec "${1}" mkdir /usr/local/etc/rc.d /usr/local/etc/rc.conf.d
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/bitwarden/includes/bitwarden.rc /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/bitwarden
cp "${SCRIPT_DIR}"/blueprints/bitwarden/includes/bitwarden.rc.conf /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden
echo 'export DATABASE_URL="'"${DB_STRING}"'"' >> /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden
echo 'export ADMIN_TOKEN="'"${!ADMIN_TOKEN}"'"' >> /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden

if [ "${!ADMIN_TOKEN}" == "NONE" ]; then
    echo "Admin_token set to NONE, disabling admin portal"
else
    echo "Admin_token set and admin portal enabled"
    iocage exec "${1}" echo "${DB_NAME} Admin Token is ${!ADMIN_TOKEN}" > /root/"${1}"_admin_token.txt
fi

iocage exec "${1}" chmod u+x /usr/local/etc/rc.d/bitwarden
iocage exec "${1}" sysrc "bitwarden_enable=YES"
iocage exec "${1}" service bitwarden restart
echo "Jail ${1} finished Bitwarden install."
echo "Admin Token is ${!ADMIN_TOKEN}"
