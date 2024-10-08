#!/usr/local/bin/bash
# This file contains the update script for bitwarden
# Due to it being build from scratch or downloaded directly to execution dir,
# Update for Bitwarden is pretty similair to installation

# Initialise defaults
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
HOST_NAME="jail_${1}_host_name"
DB_DATABASE="jail_${1}_db_database"
DB_USER="jail_${1}_db_user"
# shellcheck disable=SC2154
INSTALL_TYPE="jail_${1}_type"
DB_JAIL="jail_${1}_db_jail"
DB_JAIL="${!DB_JAIL}"
# shellcheck disable=SC2154
DB_HOST="${DB_JAIL}_ip4_addr"
DB_HOST="${!DB_HOST%/*}:3306"
# shellcheck disable=SC2154
DB_PASSWORD="jail_${1}_db_password"
DB_STRING="mysql://${!DB_USER}:${!DB_PASSWORD}@${DB_HOST}/${!DB_DATABASE}"
# shellcheck disable=SC2154
ADMIN_TOKEN="jail_${1}_admin_token"

if [ -z "${!DB_USER}" ]; then
    echo "db_user can't be empty"
    exit 1
fi

if [ -z "${!DB_DATABASE}" ]; then
    echo "db_database can't be empty"
    exit 1
fi

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

iocage exec "${1}" service bitwarden stop

# install latest rust version, pkg version is outdated and can't build bitwarden_rs
iocage exec "${1}" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

# Install Bitwarden_rs
iocage exec "${1}" "git -C /usr/local/share/bitwarden/src fetch"
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

iocage exec "${1}" chown -R bitwarden:bitwarden /usr/local/share/bitwarden /config
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/"${1}"/includes/bitwarden.rc /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/bitwarden
cp "${SCRIPT_DIR}"/blueprints/"${1}"/includes/bitwarden.rc.conf /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden
echo 'export DATABASE_URL="'"${DB_STRING}"'"' >> /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden
echo 'export ADMIN_TOKEN="'"${!ADMIN_TOKEN}"'"' >> /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.conf.d/bitwarden

if [ "${!ADMIN_TOKEN}" == "NONE" ]; then
    echo "Admin_token set to NONE, disabling admin portal"
else
    echo "Admin_token set and admin portal enabled"
    iocage exec "${1}" echo "${DB_NAME} Admin Token is ${!ADMIN_TOKEN}" > /root/"${1}"_admin_token.txt
fi


iocage exec "${1}" chmod u+x /usr/local/etc/rc.d/bitwarden
iocage exec "${1}" service bitwarden restart
echo "Jail ${1} finished Bitwarden update."
echo "Admin Token is ${!ADMIN_TOKEN}"
