#!/bin/bash

helmEnable(){
echo -e "${BWhite}Enabling Helm${Color_Off}"
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml && echo -e "${IGreen}Helm Enabled${Color_Off}"|| echo -e "${IRed}Helm Enable FAILED${Color_Off}"
}
export -f helmEnable

aptEnable(){
echo -e "${BWhite}Enabling Apt-Commands${Color_Off}"
chmod +x /usr/bin/apt* && echo -e "${IGreen}APT enabled${Color_Off}"|| echo -e "${IRed}APT Enable FAILED${Color_Off}"
}
export -f aptEnable

kubeapiEnable(){
local -r comment='iX Custom Rule to drop connection requests to k8s cluster from external sources'
echo -e "${BWhite}Enabling Kubernetes API${Color_Off}"
if iptables -t filter -L INPUT 2> /dev/null | grep -q "${comment}" ; then
  iptables -D INPUT -p tcp -m tcp --dport 6443 -m comment --comment "${comment}" -j DROP && echo -e "${IGreen}Kubernetes API enabled${Color_Off}"|| echo -e "${IRed}Kubernetes API Enable FAILED${Color_Off}"
else
  echo -e "${IGreen}Kubernetes API already enabled${Color_Off}"
fi
}
export -f kubeapiEnable

# Prune unused docker images to prevent dataset/snapshot bloat related slowdowns on SCALE
prune(){
echo -e "🄿 🅁 🅄 🄽 🄴"
if (( "$scaleVersion" >= 22120 )); then
  cli -c 'app container config prune prune_options={"remove_unused_images": true, "remove_stopped_containers": true}' | head -n -4 || echo "Failed to Prune Docker Images"
else
  docker image prune -af | grep "^Total" || echo "Failed to Prune Docker Images"
fi
}
export -f prune

middlewareRestart() {
  echo "We need to restart middlewared."
  echo "This will cause a short downtime for the webui approximately 10-30 seconds"
  echo "Restarting middlewared"
  service middlewared restart &
  wait $!
  echo "Restarted middlewared"
}
export -f middlewareRestart


sync(){
echo_sync+=("🅂 🅈 🄽 🄲")
cli -c 'app catalog sync_all' &> /dev/null && echo_sync+=("Catalog sync complete")

#Dump the echo_array, ensures all output is in a neat order.
for i in "${echo_sync[@]}"
do
    echo -e "$i"
done
echo
echo
}
export -f sync
