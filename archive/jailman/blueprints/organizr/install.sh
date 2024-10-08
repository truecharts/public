#!/usr/local/bin/bash
# This file contains the install script for Organizr

iocage exec "$1" sed -i '' -e 's?listen = 127.0.0.1:9000?listen = /var/run/php-fpm.sock?g' /usr/local/etc/php-fpm.d/www.conf
iocage exec "$1" sed -i '' -e 's/;listen.owner = www/listen.owner = www/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec "$1" sed -i '' -e 's/;listen.group = www/listen.group = www/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec "$1" sed -i '' -e 's/;listen.mode = 0660/listen.mode = 0600/g' /usr/local/etc/php-fpm.d/www.conf
iocage exec "$1" cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini
iocage exec "$1" sed -i '' -e 's?;date.timezone =?date.timezone = "Universal"?g' /usr/local/etc/php.ini
iocage exec "$1" sed -i '' -e 's?;cgi.fix_pathinfo=1?cgi.fix_pathinfo=0?g' /usr/local/etc/php.ini
# shellcheck disable=SC2154
mv /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/nginx/nginx.conf /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/nginx/nginx.conf.bak
cp "${SCRIPT_DIR}"/blueprints/organizr/includes/nginx.conf /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/nginx/nginx.conf
cp -Rf "${SCRIPT_DIR}"/blueprints/organizr/includes/custom /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/nginx/custom
# shellcheck disable=SC2154
if [ ! -d "/mnt/${global_dataset_config}/$1/ssl" ]; then
    echo "cert folder doesn't exist... creating..."
    iocage exec "$1" mkdir /config/ssl
fi

if [ -f "/mnt/${global_dataset_config}/$1/ssl/Organizr-Cert.crt" ]; then
    echo "certificate exists... Skipping cert generation"
else
    echo "No ssl certificate present, generating self signed certificate"
    openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=localhost" -keyout /mnt/"${global_dataset_config}"/"$1"/ssl/Organizr-Cert.key -out /mnt/"${global_dataset_config}"/"$1"/ssl/Organizr-Cert.crt
fi

iocage exec "$1" git clone https://github.com/causefx/Organizr.git /usr/local/www/Organizr
iocage exec "$1" chown -R www:www /usr/local/www /config /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/custom
iocage exec "$1" ln -s /config/config.php /usr/local/www/Organizr/api/config/config.php
iocage exec "$1" sysrc nginx_enable=YES
iocage exec "$1" sysrc php_fpm_enable=YES
iocage exec "$1" service nginx start
iocage exec "$1" service php-fpm start
