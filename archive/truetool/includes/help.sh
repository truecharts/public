#!/bin/bash

help(){
[[ $help == "true" ]] && clear -x
echo ""
echo -e "${BWhite}Basic Utilities${Color_Off}"
echo "--mount          | Initiates mounting feature, choose between unmounting and mounting PVC data"
echo "--restore        | Opens a menu to restore a \"truetool\" backup that was taken on your \"ix-applications\" dataset"
echo "--delete-backup  | Opens a menu to delete backups on your system"
echo "--list-backups   | Prints a list of backups available"
echo "--helm-enable    | Enables Helm command access on SCALE"
echo "--apt-enable     | Enables Apt command access on SCALE"
echo "--kubeapi-enable | Enables external access to Kuberntes API port"
echo "--dns            | List all of your applications DNS names and their web ports"
echo
echo -e "${BWhite}Update Options${Color_Off}"
echo "-U | Update all applications, ignores versions"
echo "-u | Update all applications, does not update Major releases"
echo "-b | Back-up your ix-applications dataset, specify a number after -b"
echo "-i | Add application to ignore list, one by one, see example below."
echo "-v | verbose output"
echo "-t | Set a custom timeout in seconds when checking if either an App or Mountpoint correctly Started, Stopped or (un)Mounted. Defaults to 500 seconds"
echo "-s | sync catalog"
echo "-p | Prune unused/old docker images"
echo
echo -e "${BWhite}Examples${Color_Off}"
echo "bash truetool.sh -b 14 -i portainer -i arch -i sonarr -i radarr -t 600 -vsUp"
echo "bash /mnt/tank/scripts/truetool.sh -t 150 --mount"
echo "bash /mnt/tank/scripts/truetool.sh --dns"
echo "bash /mnt/tank/scripts/truetool.sh --restore"
echo "bash /mnt/tank/scripts/truetool.sh --delete-backup"
echo
exit
}
export -f help
