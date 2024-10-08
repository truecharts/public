#!/usr/bin/sudo bash

prompt_yn_node_health () {
read -p "Node healthcheck failed, is the currently updated node working correctly? please verify! (yes/no) " yn

case $yn in
    yes ) echo ok, we will proceed;;
    no ) echo exiting...;
        exit;;
    y ) echo ok, we will proceed;;
    n ) echo exiting...;
        exit;;
    * ) echo invalid response;
        prompt_yn_node_health;;
esac
}
export prompt_yn_node_health



check_node_health_probe(){
   echo "Waiting for a node to be online on ip ${1}..."
   sleep 5
   while ! ping -c1 ${1} &>/dev/null; do :; done
   echo "Waiting for a node to respond to machine status on ip ${1}..."
   isup=0
   until [ "${isup}" = 1 ] ; do
    sleep 1
    status=$(timeout 1 talosctl --talosconfig=talosconfig -e "${1}" -n "${1}" get machinestatus -o jsonpath={.spec.stage}) 2>&1
    if [ "$status" == "running" ]; then
      echo "detected running node ${1}, checking ready..."
      ready=$(timeout 1 talosctl --talosconfig=talosconfig -e "${1}" -n "${1}" get machinestatus -o jsonpath={.spec.status.ready}) 2>&1
          if [ "$ready" == "true" ]; then
            echo "node ready!"
            isup=1
          fi
    elif [ ! -z "${2}" ]; then
      if [ "$status" == "$2" ]; then
        echo "detected node ${1} in mode ${2} , continuing..."
        isup=1
      fi
    fi
   done

}
export check_node_health_probe

check_node_health(){
check_node_health_probe || prompt_yn_node_health
}
export check_node_health
