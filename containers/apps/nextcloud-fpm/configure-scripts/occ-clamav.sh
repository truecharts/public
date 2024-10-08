#!/bin/sh
occ_clamav_install() {
  echo '## Configuring ClamAV...'
  install_app files_antivirus

  occ config:app:set files_antivirus av_mode --value="daemon"
  occ config:app:set files_antivirus av_host --value="${NX_CLAMAV_HOST:?"NX_CLAMAV_HOST is unset"}"
  occ config:app:set files_antivirus av_port --value="${NX_CLAMAV_PORT:-3310}"
  occ config:app:set files_antivirus av_stream_max_length --value="${NX_CLAMAV_STREAM_MAX_LENGTH:-26214400}"
  occ config:app:set files_antivirus av_max_file_size --value="${NX_CLAMAV_MAX_FILE_SIZE:-"-1"}"
  occ config:app:set files_antivirus av_infected_action --value="${NX_CLAMAV_INFECTED_ACTION:-"only_log"}"
}

occ_clamav_remove() {
  echo '## Removing ClamAV Configuration...'
  remove_app files_antivirus

  occ config:app:delete files_antivirus av_mode
  occ config:app:delete files_antivirus av_host
  occ config:app:delete files_antivirus av_port
  occ config:app:delete files_antivirus av_stream_max_length
  occ config:app:delete files_antivirus av_max_file_size
  occ config:app:delete files_antivirus av_infected_action
}
