#!/bin/sh
occ_database() {
  echo '## Configuring Database...'

  occ config:system:set dbtype --value="pgsql"
  occ config:system:set dbhost --value="${NX_POSTGRES_HOST:?"NX_POSTGRES_HOST is unset"}"
  occ config:system:set dbname --value="${NX_POSTGRES_NAME:?"NX_POSTGRES_NAME is unset"}"
  occ config:system:set dbuser --value="${NX_POSTGRES_USER:?"NX_POSTGRES_USER is unset"}"
  occ config:system:set dbpassword --value="${NX_POSTGRES_PASSWORD:?"NX_POSTGRES_PASSWORD is unset"}"
  occ config:system:set dbport --value="${NX_POSTGRES_PORT:-5432}"
}
