#!/usr/bin/sudo bash

prompt_yn_manifests_remove () {
read -p "Do you want to remove the included helm-charts and manifests? THIS IS DESTRUCTIVE. (yes/no) (this will still skip installing the CNI) " yn

case $yn in
    yes ) echo "ok, we will proceed";
        remove_manifests;
        ;;
    no ) echo "not removing...";
        exit;;
    y ) echo "ok, we will proceed";
        remove_manifests;
        ;;
    n ) echo "not removing...";
        exit;;
    * ) echo "invalid response";
        prompt_yn_manifests_remove;;
esac
}
export prompt_yn_manifests_remove

remove_manifests(){
  echo "NOT IMPLEMENTED..."
  apply_kubeconfig
  # deploy_metallb
  # deploy_metallb_config
  # deploy_openebs
  # deploy_kubeapps

}
export -f remove_manifests
