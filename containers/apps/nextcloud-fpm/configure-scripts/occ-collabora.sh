#!/bin/sh
occ_collabora_install() {
  echo '## Configuring Collabora...'
  install_app richdocuments

  occ config:app:set richdocuments wopi_url --value="${NX_COLLABORA_URL:?"NX_COLLABORA_URL is unset"}"
  occ config:app:set richdocuments public_wopi_url --value="${NX_COLLABORA_URL:?"NX_COLLABORA_URL is unset"}"
  occ config:app:set richdocuments wopi_allowlist --value="${NX_COLLABORA_ALLOWLIST:?"NX_COLLABORA_ALLOWLIST is unset"}"
}

occ_collabora_remove() {
  echo '## Removing Collabora Configuration...'
  remove_app richdocuments

  occ config:app:delete richdocuments wopi_url
  occ config:app:delete richdocuments public_wopi_url
  occ config:app:delete richdocuments wopi_allowlist
}
