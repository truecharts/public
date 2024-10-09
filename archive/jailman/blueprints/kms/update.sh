#!/usr/local/bin/bash
# This file contains the update script for KMS

iocage exec "$1" service py_kms stop
iocage exec "$1" svn checkout https://github.com/SystemRage/py-kms/trunk/py-kms /usr/local/share/py-kms
iocage exec "$1" chown -R kms:kms /usr/local/share/py-kms /config
# shellcheck disable=SC2154
cp "${SCRIPT_DIR}"/blueprints/kms/includes/py_kms.rc /mnt/"${global_dataset_iocage}"/jails/"$1"/root/usr/local/etc/rc.d/py_kms
iocage exec "$1" chmod u+x /usr/local/etc/rc.d/py_kms
iocage exec "$1" service py_kms start
