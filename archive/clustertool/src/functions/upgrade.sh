#!/usr/bin/sudo bash

upgrade_talos_nodes () {

  talhelper gencommand upgrade --extra-flags=--preserve=true | bash
  
  prompt_yn_manifests

  check_health
  echo "updating kubernetes to latest version..."
  talhelper gencommand upgrade-k8s -n ${MASTER1IP}
  check_health
  prompt_yn_manifests
}
export upgrade_talos_nodes