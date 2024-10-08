#!/bin/bash

# Fancy ascii title.
title(){
if [[ -z $titleShown ]]; then
  echo -e "${IRed}  _______               _____ _                _       ";
  echo " |__   __|             / ____| |              | |      ";
  echo "    | |_ __ _   _  ___| |    | |__   __ _ _ __| |_ ___ ";
  echo -e "${IYellow}    | | '__| | | |/ _ \ |    | '_ \ / _\` | '__| __/ __|";
  echo "    | | |  | |_| |  __/ |____| | | | (_| | |  | |_\__ \\";
  echo -e "${IGreen}  __|_|_|   \__,_|\___|\_____|_| |_|\__,_|_|   \__|___/";
  echo " |__   __|         |__   __|        | |                ";
  echo -e "${IBlue}    | |_ __ _   _  ___| | ___   ___ | |                ";
  echo "    | | '__| | | |/ _ \ |/ _ \ / _ \| |                ";
  echo -e "${IPurple}    | | |  | |_| |  __/ | (_) | (_) | |                ";
  echo "    |_|_|   \__,_|\___|_|\___/ \___/|_|                ";
  echo "                                                       ";
  echo -e "${Color_Off}                                                       ";
fi
titleShown='true'
}
export -f title
