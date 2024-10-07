#!/usr/bin/sudo bash

prompt_yn_manifests () {
read -p "Do you want to update/reinstall the included helm-charts and manifests? (yes/no) " yn

case $yn in
    yes ) echo "ok, we will proceed";
	    apply_manifests;
	    ;;
    no ) echo "not installing...";
	    apply_kubeconfig
        ;;
    y ) echo "ok, we will proceed";
	    apply_manifests;
	    ;;
    n ) echo "not installing...";
	    apply_kubeconfig
        ;;
    * ) echo "invalid response";
        prompt_yn_manifests;;
esac
}
export prompt_yn_manifests

apply_manifests(){
  echo "Deploying included helm charts..."
  apply_kubeconfig
  deploy_cni
  deploy_metallb
  deploy_metallb_config
  deploy_openebs
  deploy_kubeapps

}
export -f apply_manifests