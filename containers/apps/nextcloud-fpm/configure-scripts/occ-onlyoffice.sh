#!/bin/sh
occ_onlyoffice_install() {
  echo '## Configuring OnlyOffice...'
  install_app onlyoffice

  occ config:app:set onlyoffice DocumentServerUrl --value="${NX_ONLYOFFICE_URL:?"NX_ONLYOFFICE_URL is unset"}"
  occ config:app:set onlyoffice DocumentServerInternalUrl --value="${NX_ONLYOFFICE_INTERNAL_URL:?"NX_ONLYOFFICE_INTERNAL_URL is unset"}"
  occ config:app:set onlyoffice StorageUrl --value="${NX_ONLYOFFICE_NEXTCLOUD_INTERNAL_URL:?"NX_ONLYOFFICE_NEXTCLOUD_INTERNAL_URL is unset"}"
  if [ "${NX_ONLYOFFICE_VERIFY_SSL:-"true"}" = "false" ]; then
    occ config:app:set onlyoffice verify_peer_off --value="true"
  else
    occ config:app:set onlyoffice verify_peer_off --value="false"
  fi
  occ config:system:set onlyoffice jwt_secret --value="${NX_ONLYOFFICE_JWT:?"NX_ONLYOFFICE_JWT is unset"}"
  occ config:system:set onlyoffice jwt_header --value="${NX_ONLYOFFICE_JWT_HEADER:-"Authorization"}"
}

occ_onlyoffice_remove() {
  echo '## Removing OnlyOffice Configuration...'
  remove_app onlyoffice

  occ config:app:delete onlyoffice DocumentServerUrl
  occ config:app:delete onlyoffice DocumentServerInternalUrl
  occ config:app:delete onlyoffice StorageUrl
  occ config:app:delete onlyoffice verify_peer_off
  occ config:system:delete onlyoffice jwt_secret
  occ config:system:delete onlyoffice jwt_header
}
