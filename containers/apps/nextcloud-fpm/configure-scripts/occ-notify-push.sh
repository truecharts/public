#!/bin/sh
occ_notify_push_install() {
  echo '## Configuring Notify Push...'
  install_app notify_push

  echo '## Configuring Notify Push Base Endpoint...'
  occ config:app:set notify_push base_endpoint --value="${NX_NOTIFY_PUSH_ENDPOINT:?"NX_NOTIFY_PUSH_ENDPOINT is unset"}"
}

occ_notify_push_remove() {
  echo '## Removing Notify Push...'
  remove_app notify_push

  echo '## Removing Notify Push Base Endpoint...'
  occ config:app:delete notify_push base_endpoint
}
