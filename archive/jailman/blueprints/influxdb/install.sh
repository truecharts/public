#!/usr/local/bin/bash
# This script installs the current release of InfluxDB

#####
#
# Init and Mounts
#
#####

# Initialise variables
# shellcheck disable=SC2154
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
INCLUDES_PATH="${SCRIPT_DIR}/blueprints/influxdb/includes"

# Mount and configure proper configuration location
# shellcheck disable=SC2154
cp -rf "${INCLUDES_PATH}/influxd.conf" "/mnt/${global_dataset_config}/${1}/influxd.conf"
iocage exec "${1}" mkdir -p /config/db/data /config/db/meta /config/db/wal
iocage exec "${1}" chown -R influxd:influxd /config/db
iocage exec "${1}" sysrc influxd_conf="/config/influxd.conf"
iocage exec "${1}" sysrc influxd_enable="YES"

# Start influxdb and wait for it to startup
iocage exec "${1}" service influxd start
sleep 15

# Done!
echo "Installation complete!"
echo "You may connect InfluxDB plugins to the InfluxDB jail at http://${JAIL_IP}:8086."
echo ""
