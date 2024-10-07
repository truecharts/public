#!/usr/local/bin/bash
# This file contains the update script for Organizr

iocage exec "$1" service nginx stop
iocage exec "$1" service php-fpm stop
# TODO setup cli update for Organizr here.
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/organizr/includes/nginx.conf /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/nginx/nginx.conf
iocage exec "$1" "cd /usr/local/www/Organizr && git pull"
iocage exec "$1" chown -R www:www /usr/local/www /config /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/custom
iocage exec "$1" service nginx start
iocage exec "$1" service php-fpm start