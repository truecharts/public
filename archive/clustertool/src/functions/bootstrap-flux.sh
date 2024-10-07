#!/usr/bin/sudo bash

bootstrap_flux(){
 echo "Bootstrapping FluxCD on existing Cluster..."

 check_health

 echo "Ensure kubeconfig is set..."
 talosctl kubeconfig --force --talosconfig clusterconfig/talosconfig -n $VIP -e $VIP

 echo "Running FluxCD Pre-check..."
 flux check --pre > /dev/null
 FLUX_PRE=$?
 if [ $FLUX_PRE != 0 ]; then
   echo -e "Error: flux prereqs not met:\n"
   flux check --pre
   exit 1
 fi
 if [ -z "$GITHUB_TOKEN" ]; then
   echo "ERROR: GITHUB_TOKEN is not set!"
   exit 1
 fi

 echo "Executing FluxCD Bootstrap..."
 flux bootstrap github \
   --token-auth=false \
   --owner=$GITHUB_USER \
   --repository=$GITHUB_REPOSITORY \
   --branch=main \
   --path=./cluster/main \
   --personal \
   --network-policy=false

  FLUX_INSTALLED=$?
  if [ $FLUX_INSTALLED != 0 ]; then
    echo -e "ERROR: flux did not install correctly, aborting!"
    exit 1
  fi
}
export -f bootstrap_flux