#!/usr/bin/sudo bash

prompt_yn_cluster_health () {
read -p "Cluster healthcheck failed, is the currently updated node working correctly? please verify! (yes/no) " yn

case $yn in
    yes ) echo ok, we will proceed;;
    no ) echo exiting...;
        exit;;
    y ) echo ok, we will proceed;;
    n ) echo exiting...;
        exit;;
    * ) echo invalid response;
        prompt_yn_cluster_health;;
esac
}
export prompt_yn_cluster_health



check_cluster_health_probe(){
   check_node_health ${VIP}
   echo "Checking Cluster Health..."
   talosctl health --talosconfig clusterconfig/talosconfig -n ${VIP}

}
export check_cluster_health_probe

check_cluster_health(){
   check_cluster_health_probe || prompt_yn_cluster_health
}
export check_cluster_health