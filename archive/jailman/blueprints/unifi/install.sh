#!/usr/local/bin/bash
# This file contains the install script for unifi-controller & unifi-poller

# Initialize variables
# shellcheck disable=SC2154
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"

# shellcheck disable=SC2154
DB_JAIL="jail_${1}_db_jail"

POLLER="jail_${1}_unifi_poller"

# shellcheck disable=SC2154
DB_IP="jail_${!DB_JAIL}_ip4_addr"
DB_IP="${!DB_IP%/*}"

# shellcheck disable=SC2154
DB_NAME="jail_${1}_up_db_name"
DB_NAME="${!DB_NAME:-$1}"

# shellcheck disable=SC2154
DB_USER="jail_${1}_up_db_user"
DB_USER="${!DB_USER:-$DB_NAME}"

# shellcheck disable=SC2154
DB_PASS="jail_${1}_up_db_password"

# shellcheck disable=SC2154
UP_USER="jail_${1}_up_user"
UP_USER="${!UP_USER:-$1}"

# shellcheck disable=SC2154
UP_PASS="jail_${1}_up_password"
INCLUDES_PATH="${SCRIPT_DIR}/blueprints/unifi/includes"

if [ -z "${!DB_PASS}" ]; then
    echo "up_db_password can't be empty"
    exit 1
fi

if [ -z "${!DB_JAIL}" ]; then
    echo "db_jail can't be empty"
    exit 1
fi

if [ -z "${!UP_PASS}" ]; then
    echo "up_password can't be empty"
    exit 1
fi

# Enable persistent Unifi Controller data
iocage exec "${1}" mkdir -p /config/controller/mongodb
iocage exec "${1}" cp -Rp /usr/local/share/java/unifi /config/controller
iocage exec "${1}" chown -R mongodb:mongodb /config/controller/mongodb
# shellcheck disable=SC2154
cp "${INCLUDES_PATH}"/mongodb.conf /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc
# shellcheck disable=SC2154
cp "${INCLUDES_PATH}"/rc/mongod.rc /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/mongod
# shellcheck disable=SC2154
cp "${INCLUDES_PATH}"/rc/unifi.rc /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/unifi
iocage exec "${1}" sysrc unifi_enable=YES
iocage exec "${1}" service unifi start

# shellcheck disable=SC2154
if [ "${!POLLER}" == true ]; then
  # Check if influxdb container exists, create unifi database if it does, error if it is not.
  echo "Checking if the database jail and database exist..."
  if [[ -d /mnt/"${global_dataset_iocage}"/jails/"${!DB_JAIL}" ]]; then
    DB_EXISTING=$(iocage exec "${!DB_JAIL}" curl -G http://"${DB_IP}":8086/query --data-urlencode 'q=SHOW DATABASES' | jq '.results [] | .series [] | .values []' | grep "$DB_NAME" | sed 's/"//g' | sed 's/^ *//g')
    if [[ "$DB_NAME" == "$DB_EXISTING" ]]; then
      echo "${!DB_JAIL} jail with database ${DB_NAME} already exists. Skipping database creation... "
    else
      echo "${!DB_JAIL} jail exists, but database ${DB_NAME} does not. Creating database ${DB_NAME}."
      if [[ -z "${DB_USER}" ]] || [[ -z "${!DB_PASS}" ]]; then
        echo "Database username and password not provided. Cannot create database without credentials. Exiting..."
        exit 1
      else
        # shellcheck disable=SC2027,2086
        iocage exec "${!DB_JAIL}" "curl -XPOST -u ${DB_USER}:${!DB_PASS} http://"${DB_IP}":8086/query --data-urlencode 'q=CREATE DATABASE ${DB_NAME}'"
        echo "Database ${DB_NAME} created with username ${DB_USER} with password ${!DB_PASS}."
      fi
    fi
  else
    echo "Influxdb jail does not exist. Unifi-Poller requires Influxdb jail. Please install the Influxdb jail."
    exit 1
  fi

  # Download and install Unifi-Poller
  FILE_NAME=$(curl -s https://api.github.com/repos/unifi-poller/unifi-poller/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.txz\")) | .name")
  DOWNLOAD=$(curl -s https://api.github.com/repos/unifi-poller/unifi-poller/releases/latest | jq -r ".assets[] | select(.name | contains(\"amd64.txz\")) | .browser_download_url")
  iocage exec "${1}" fetch -o /config "${DOWNLOAD}"

  # Install downloaded Unifi-Poller package, configure and enable
  iocage exec "${1}" pkg install -qy /config/"${FILE_NAME}"
  # shellcheck disable=SC2154
  cp "${INCLUDES_PATH}"/up.conf /mnt/"${global_dataset_config}"/"${1}"
  # shellcheck disable=SC2154
  cp "${INCLUDES_PATH}"/rc/unifi_poller.rc /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/unifi_poller
  chmod +x /mnt/"${global_dataset_iocage}"/jails/"${1}"/root/usr/local/etc/rc.d/unifi_poller
  iocage exec "${1}" sed -i '' "s|influxdbuser|${DB_USER}|" /config/up.conf
  iocage exec "${1}" sed -i '' "s|influxdbpass|${!DB_PASS}|" /config/up.conf
  iocage exec "${1}" sed -i '' "s|unifidb|${DB_NAME}|" /config/up.conf
  iocage exec "${1}" sed -i '' "s|unifiuser|${UP_USER}|" /config/up.conf
  iocage exec "${1}" sed -i '' "s|unifipassword|${!UP_PASS}|" /config/up.conf
  iocage exec "${1}" sed -i '' "s|dbip|http://${DB_IP}:8086|" /config/up.conf


  iocage exec "${1}" sysrc unifi_poller_enable=YES
  iocage exec "${1}" service unifi_poller start

  echo "Installation complete!"
  echo "Unifi Controller is accessible at https://${JAIL_IP}:8443."
  echo "Please login to the Unifi Controller and add ${UP_USER} as a read-only user."
  echo "In Grafana, add Unifi-Poller as a data source."
else
  echo "Installation complete!"
  echo "Unifi Controller is accessible at https://${JAIL_IP}:8443."
fi
