#!/bin/sh
occ_logging() {
  echo '## Configuring Logging...'
  occ config:system:set log_type --value="file"
  occ config:system:set log_type_audit --value="file"
  occ config:system:set loglevel --value="${NX_LOG_LEVEL:-2}"
  occ config:system:set logfile --value="${NX_LOG_FILE:-"/var/www/html/data/nextcloud.log"}"
  occ config:system:set logfile_audit --value="${NX_LOG_FILE_AUDIT:-"/var/www/html/data/audit.log"}"
  occ config:system:set logdateformat --value="${NX_LOG_DATE_FORMAT:-"d/m/Y H:i:s"}"
  occ config:system:set logtimezone --value="${NX_LOG_TIMEZONE:-$TZ}"
}
