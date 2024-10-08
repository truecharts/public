#!/usr/bin/sudo bash

source ./src/functions/functions.sh
source ./src/menus/menus.sh

export FILES

if [[ $EUID -ne 0 ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2
else
  menu
fi
