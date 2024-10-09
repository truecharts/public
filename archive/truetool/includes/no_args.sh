#!/bin/bash
# shellcheck disable=SC2034

no_args(){
  echo "0  Show Help"
  echo "1  List Internal Service DNS Names"
  echo "2  Mount and Unmount PVC storage for easy access"
  echo "3  List Backups"
  echo "4  Create a Backup"
  echo "5  Restore a Backup"
  echo "6  Delete a Backup"
  echo "7  Enable Helm Commands"
  echo "8  Enable Apt and Apt-Get Commands"
  echo "9  Update All Apps"
  echo "10 Enable external access to Kuberntes API port"
  read -rt 600 -p "Please select an option by number: " selection

  case $selection in
    0)
      help="true"
      ;;
    1)
      dns="true"
      ;;
    2)
      mountPVC="true"
      ;;
    3)
      listBackups="true"
      ;;
    4)
      read -rt 600 -p "Please type the max number of backups to keep: " backups
      re='^[0-9]+$'
      number_of_backups=$backups
      ! [[ $backups =~ $re  ]] && echo -e "Error: -b needs to be assigned an interger\n\"""$number_of_backups""\" is not an interger" >&2 && exit
      [[ "$number_of_backups" -le 0 ]] && echo "Error: Number of backups is required to be at least 1" && exit
      ;;
    5)
      restore="true"
      ;;
    6)
      deleteBackup="true"
      ;;
    7)
      helmEnable="true"
      ;;
    8)
      aptEnable="true"
      ;;
    9)
      echo ""
      echo "1  Update Apps Excluding likely breaking major changes"
      echo "2  Update Apps Including likely breaking major changes"
      read -rt 600 -p "Please select an option by number: " updateType
      if [[ "$updateType" == "1" ]]; then
        update_apps="true"
      elif [[ "$updateType" == "2" ]]; then
        update_all_apps="true"
      else
        echo "INVALID ENTRY" && exit 1
      fi
      ;;
    10)
      kubeapiEnable="true"
      ;;
    *)
      echo "Unknown option" && exit 1
      ;;
  esac
  echo ""
}
export -f no_args
