#!/usr/local/bin/bash
# This script installs the current release of Nextcloud into a create jail
# Based on the example by danb35: https://github.com/danb35/freenas-iocage-nextcloud

# Initialise defaults
# General Defaults
JAIL_IP="jail_${1}_ip4_addr"
JAIL_IP="${!JAIL_IP%/*}"
HOST_NAME="jail_${1}_host_name"
TIME_ZONE="jail_${1}_time_zone"
INCLUDES_PATH="${SCRIPT_DIR}/blueprints/nextcloud/includes"

# SSL/CERT Defaults
CERT_TYPE="jail_${1}_cert_type"
CERT_TYPE="${!CERT_TYPE:-SELFSIGNED_CERT}"
CERT_EMAIL="jail_${1}_cert_email"
CERT_EMAIL="${!CERT_EMAIL:-placeholder@email.fake}"
DNS_PLUGIN="jail_${1}_dns_plugin"
DNS_ENV="jail_${1}_dns_env"

# Database Defaults
DB_TYPE="jail_${1}_db_type"
DB_TYPE="${!DB_TYPE:-mariadb}"
DB_JAIL="jail_${1}_db_jail"
# shellcheck disable=SC2154
DB_HOST="jail_${!DB_JAIL}_ip4_addr"
DB_HOST="${!DB_HOST%/*}:3306"

DB_PASSWORD="jail_${1}_db_password"

DB_DATABASE="jail_${1}_db_database"
DB_DATABASE="${!DB_DATABASE:-$1}"

DB_USER="jail_${1}_db_user"
DB_USER="${!DB_USER:-$DB_DATABASE}"

ADMIN_PASSWORD="jail_${1}_admin_password"

#####
# 
# Input Sanity Check 
#
#####


# Check that necessary variables were set by nextcloud-config
if [ -z "${JAIL_IP}" ]; then
  echo 'Configuration error: The Nextcloud jail does NOT accept DHCP'
  echo 'Please reinstall using a fixed IP adress'
  exit 1
fi

if [ -z "${!ADMIN_PASSWORD}" ]; then
  echo 'Configuration error: The Nextcloud jail requires a admin_password'
  echo 'Please reinstall using a fixed IP adress'
  exit 1
fi

if [ -z "${!DB_PASSWORD}" ]; then
  echo 'Configuration error: The Nextcloud Jail needs a database password'
  echo 'Please reinstall with a defifined: db_password'
  exit 1
fi

# shellcheck disable=SC2154
if [ -z "${!TIME_ZONE}" ]; then
  echo 'Configuration error: !TIME_ZONE must be set'
  exit 1
fi
if [ -z "${!HOST_NAME}" ]; then
  echo 'Configuration error: !HOST_NAME must be set'
  exit 1
fi



if [ "$CERT_TYPE" != "STANDALONE_CERT" ] && [ "$CERT_TYPE" != "DNS_CERT" ] && [ "$CERT_TYPE" != "NO_CERT" ] && [ "$CERT_TYPE" != "SELFSIGNED_CERT" ]; then
  echo 'Configuration error, cert_type options: STANDALONE_CERT, DNS_CERT, NO_CERT or SELFSIGNED_CERT'
  exit 1
fi

if [ "$CERT_TYPE" == "DNS_CERT" ]; then
	if [ -z "${!DNS_PLUGIN}" ] ; then
		echo "DNS_PLUGIN must be set to a supported DNS provider."
		echo "See https://caddyserver.com/docs under the heading of \"DNS Providers\" for list."
		echo "Be sure to omit the prefix of \"tls.dns.\"."
		exit 1
	elif [ -z "${!DNS_ENV}" ] ; then
		echo "DNS_ENV must be set to a your DNS provider\'s authentication credentials."
		echo "See https://caddyserver.com/docs under the heading of \"DNS Providers\" for more."
		exit 1
	else
		DL_FLAGS="tls.dns.${DNS_PLUGIN}"
		DNS_SETTING="dns ${DNS_PLUGIN}"
	fi 
fi  

# Make sure DB_PATH is empty -- if not, MariaDB will choke
# shellcheck disable=SC2154
if [ "$(ls -A "/mnt/${global_dataset_config}/${1}/config")" ]; then
	echo "Reinstall of Nextcloud detected... "
	REINSTALL="true"
fi


#####
	# 
# Fstab And Mounts
#
#####

# Create and Mount Nextcloud, Config and Files
createmount "${1}" "${global_dataset_config}"/"${1}"/config /usr/local/www/nextcloud/config
createmount "${1}" "${global_dataset_config}"/"${1}"/themes /usr/local/www/nextcloud/themes
createmount "${1}" "${global_dataset_config}"/"${1}"/files /config/files

# Install includes fstab
iocage exec "${1}" mkdir -p /mnt/includes
iocage fstab -a "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0


iocage exec "${1}" chown -R www:www /config/files
iocage exec "${1}" chmod -R 770 /config/files


#####
# 
# Basic dependency install
#
#####

if [ "${DB_TYPE}" = "mariadb" ]; then
  iocage exec "${1}" pkg install -qy mariadb104-client php74-pdo_mysql php74-mysqli
fi

fetch -o /tmp https://getcaddy.com
if ! iocage exec "${1}" bash -s personal "${DL_FLAGS}" < /tmp/getcaddy.com
then
	echo "Failed to download/install Caddy"
	exit 1
fi

iocage exec "${1}" sysrc redis_enable="YES"
iocage exec "${1}" sysrc php_fpm_enable="YES"


#####
# 
# Install Nextcloud
#
#####

FILE="latest-19.tar.bz2"
if ! iocage exec "${1}" fetch -o /tmp https://download.nextcloud.com/server/releases/"${FILE}" https://download.nextcloud.com/server/releases/"${FILE}".asc https://nextcloud.com/nextcloud.asc
then
	echo "Failed to download Nextcloud"
	exit 1
fi
iocage exec "${1}" gpg --import /tmp/nextcloud.asc
if ! iocage exec "${1}" gpg --verify /tmp/"${FILE}".asc
then
	echo "GPG Signature Verification Failed!"
	echo "The Nextcloud download is corrupt."
	exit 1
fi
iocage exec "${1}" tar xjf /tmp/"${FILE}" -C /usr/local/www/
iocage exec "${1}" chown -R www:www /usr/local/www/nextcloud/
iocage exec "${1}" pw usermod www -G redis


# Generate and install self-signed cert, if necessary
if [ "$CERT_TYPE" == "SELFSIGNED_CERT" ] && [ ! -f "/mnt/${global_dataset_config}/${1}/ssl/privkey.pem" ]; then
	echo "No ssl certificate present, generating self signed certificate"
	if [ ! -d "/mnt/${global_dataset_config}/${1}/ssl" ]; then
		echo "cert folder not existing... creating..."
		iocage exec "${1}" mkdir /config/ssl
	fi
	openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${!HOST_NAME}" -keyout "${INCLUDES_PATH}"/privkey.pem -out "${INCLUDES_PATH}"/fullchain.pem
	iocage exec "${1}" cp /mnt/includes/privkey.pem /config/ssl/privkey.pem
	iocage exec "${1}" cp /mnt/includes/fullchain.pem /config/ssl/fullchain.pem
fi

# Copy and edit pre-written config files
iocage exec "${1}" cp -f /mnt/includes/php.ini /usr/local/etc/php.ini
iocage exec "${1}" cp -f /mnt/includes/redis.conf /usr/local/etc/redis.conf
iocage exec "${1}" cp -f /mnt/includes/www.conf /usr/local/etc/php-fpm.d/


if [ "$CERT_TYPE" == "STANDALONE_CERT" ] && [ "$CERT_TYPE" == "DNS_CERT" ]; then
	iocage exec "${1}" cp -f /mnt/includes/remove-staging.sh /root/
fi

if [ "$CERT_TYPE" == "NO_CERT" ]; then
	echo "Copying Caddyfile for no SSL"
	iocage exec "${1}" cp -f /mnt/includes/Caddyfile-nossl /usr/local/www/Caddyfile
elif [ "$CERT_TYPE" == "SELFSIGNED_CERT" ]; then
	echo "Copying Caddyfile for self-signed cert"
	iocage exec "${1}" cp -f /mnt/includes/Caddyfile-selfsigned /usr/local/www/Caddyfile
else
	echo "Copying Caddyfile for Let's Encrypt cert"
	iocage exec "${1}" cp -f /mnt/includes/Caddyfile /usr/local/www/
fi


iocage exec "${1}" cp -f /mnt/includes/caddy.rc /usr/local/etc/rc.d/caddy


iocage exec "${1}" sed -i '' "s/yourhostnamehere/${!HOST_NAME}/" /usr/local/www/Caddyfile
iocage exec "${1}" sed -i '' "s/DNS-PLACEHOLDER/${DNS_SETTING}/" /usr/local/www/Caddyfile
iocage exec "${1}" sed -i '' "s/JAIL-IP/${JAIL_IP}/" /usr/local/www/Caddyfile
iocage exec "${1}" sed -i '' "s|mytimezone|${!TIME_ZONE}|" /usr/local/etc/php.ini

iocage exec "${1}" sysrc caddy_enable="YES"
iocage exec "${1}" sysrc caddy_cert_email="${CERT_EMAIL}"
iocage exec "${1}" sysrc caddy_SNI_default="${!HOST_NAME}"
iocage exec "${1}" sysrc caddy_env="${!DNS_ENV}"

iocage restart "${1}"

if [ "${REINSTALL}" == "true" ]; then
	echo "Reinstall detected, skipping generaion of new config and database"
else
	
	# Secure database, set root password, create Nextcloud DB, user, and password
	if  [ "${DB_TYPE}" = "mariadb" ]; then
		iocage exec "mariadb" mysql -u root -e "CREATE DATABASE ${DB_DATABASE};"
		iocage exec "mariadb" mysql -u root -e "GRANT ALL ON ${DB_DATABASE}.* TO ${DB_USER}@${JAIL_IP} IDENTIFIED BY '${!DB_PASSWORD}';"
		iocage exec "mariadb" mysqladmin reload
	fi
	
	
	# Save passwords for later reference
	iocage exec "${1}" echo "${DB_NAME} root password is ${DB_ROOT_PASSWORD}" > /root/"${1}"_db_password.txt
	iocage exec "${1}" echo "Nextcloud database password is ${!DB_PASSWORD}" >> /root/"${1}"_db_password.txt
	iocage exec "${1}" echo "Nextcloud Administrator password is ${!ADMIN_PASSWORD}" >> /root/"${1}"_db_password.txt
	
	# CLI installation and configuration of Nextcloud
	if [ "${DB_TYPE}" = "mariadb" ]; then
		iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ maintenance:install --database=\"mysql\" --database-name=\"${DB_DATABASE}\" --database-user=\"${DB_USER}\" --database-pass=\"${!DB_PASSWORD}\" --database-host=\"${DB_HOST}\" --admin-user=\"admin\" --admin-pass=\"${!ADMIN_PASSWORD}\" --data-dir=\"/config/files\""
		iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set mysql.utf8mb4 --type boolean --value=\"true\""
	fi
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ db:add-missing-indices"
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ db:convert-filecache-bigint --no-interaction"
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set logtimezone --value=\"${!TIME_ZONE}\""
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set log_type --value="file"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set logfile --value="/var/log/nextcloud.log"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set loglevel --value="2"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set logrotate_size --value="104847600"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set memcache.local --value="\OC\Memcache\APCu"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set redis host --value="/var/run/redis/redis.sock"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set redis port --value=0 --type=integer'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set memcache.locking --value="\OC\Memcache\Redis"'
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set overwritehost --value=\"${!HOST_NAME}\""
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set overwriteprotocol --value=\"https\""
	if [ "$CERT_TYPE" == "NO_CERT" ]; then
		iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set overwrite.cli.url --value=\"http://${!HOST_NAME}/\""
	else
		iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set overwrite.cli.url --value=\"https://${!HOST_NAME}/\""
	fi
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ config:system:set htaccess.RewriteBase --value="/"'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ maintenance:update:htaccess'
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set trusted_domains 1 --value=\"${!HOST_NAME}\""
	iocage exec "${1}" su -m www -c "php /usr/local/www/nextcloud/occ config:system:set trusted_domains 2 --value=\"${JAIL_IP}\""
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ app:enable encryption'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ encryption:enable'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ encryption:disable'
	iocage exec "${1}" su -m www -c 'php /usr/local/www/nextcloud/occ background:cron'
	
fi

iocage exec "${1}" touch /var/log/nextcloud.log
iocage exec "${1}" chown www /var/log/nextcloud.log
iocage exec "${1}" su -m www -c 'php -f /usr/local/www/nextcloud/cron.php'
iocage exec "${1}" crontab -u www /mnt/includes/www-crontab

# Don't need /mnt/includes any more, so unmount it
iocage fstab -r "${1}" "${INCLUDES_PATH}" /mnt/includes nullfs rw 0 0

# Done!
echo "Installation complete!"
if [ "$CERT_TYPE" == "NO_CERT" ]; then
  echo "Using your web browser, go to http://${!HOST_NAME} to log in"
else
  echo "Using your web browser, go to https://${!HOST_NAME} to log in"
fi

if [ "${REINSTALL}" == "true" ]; then
	echo "You did a reinstall, please use your old database and account credentials"
else

	echo "Default user is admin, password is ${!ADMIN_PASSWORD}"
	echo ""

	echo "Database Information"
	echo "--------------------"
	echo "Database user = ${DB_USER}"
	echo "Database password = ${!DB_PASSWORD}"
	echo ""
	echo "All passwords are saved in /root/${1}_db_password.txt"
fi

echo ""
if [ "$CERT_TYPE" == "STANDALONE_CERT" ] && [ "$CERT_TYPE" == "DNS_CERT" ]; then
  echo "You have obtained your Let's Encrypt certificate using the staging server."
  echo "This certificate will not be trusted by your browser and will cause SSL errors"
  echo "when you connect.  Once you've verified that everything else is working"
  echo "correctly, you should issue a trusted certificate.  To do this, run:"
  echo "iocage exec ${1}/root/remove-staging.sh"
  echo ""
elif [ "$CERT_TYPE" == "SELFSIGNED_CERT" ]; then
  echo "You have chosen to create a self-signed TLS certificate for your Nextcloud"
  echo "installation.  This certificate will not be trusted by your browser and"
  echo "will cause SSL errors when you connect.  If you wish to replace this certificate"
  echo "with one obtained elsewhere, the private key is located at:"
  echo "/config/ssl/privkey.pem"
  echo "The full chain (server + intermediate certificates together) is at:"
  echo "/config/ssl/fullchain.pem"
  echo ""
fi

