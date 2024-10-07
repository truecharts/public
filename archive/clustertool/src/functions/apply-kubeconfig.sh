#!/usr/bin/sudo bash

apply_kubeconfig(){
  echo "Applying kubeconfig..."
  if [ -f BOOTSTRAPPED ]; then
    talosctl kubeconfig --force --talosconfig clusterconfig/talosconfig -n $VIP >>/dev/null
  else
    finished=false
    echo "Waiting to for kubeconfig to be applied..."
    while ! $finished; do
      talosctl kubeconfig --force --talosconfig clusterconfig/talosconfig -n $VIP >>/dev/null && finished=true
    done
  fi

}
export apply_kubeconfig
