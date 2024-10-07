#!/bin/bash

## Simple shortcut to just list the backups without promts and such
listBackups(){
echo -e "${BWhite}Backup Listing Tool${Color_Off}"
clear -x && echo "pulling all restore points.."
list_backups=$(cli -c 'app kubernetes list_backups' | grep -v system-update | sort -t '_' -Vr -k2,7 | tr -d " \t\r"  | awk -F '|'  '{print $2}' | nl | column -t)
[[ -z "$list_backups" ]] && echo -e "${IRed}No restore points available${Color_Off}" && exit || echo "Detected Backups:" && echo "$list_backups"
}
export -f listBackups
