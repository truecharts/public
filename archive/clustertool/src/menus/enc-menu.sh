#!/usr/bin/sudo bash

enc_menu(){
    clear -x
	echo ""
    echo "ClusterTool: Encryption"
	echo ""
    echo -e "${bold}Available Utilities${reset}"
    echo -e "${bold}-------------------${reset}"
    echo -e "h)  Help"
    echo -e "1)  Talos Recovery"
    echo -e "2)  Manual Talos bootstrap"
    echo -e "3)  (Experimental) Bootstrap FluxCD Cluster"
	
    echo -e "0)  Back"
    read -rt 120 -p "Please select an option by number: " selection || { echo -e "${red}\nFailed to make a selection in time${reset}" ; menu; }


    case $selection in
        0)
            menu
            ;;

        1)
            decrypt
            exit
            ;;
        2)
            encrypt
            exit
            ;;
        h)
            enc_help
            exit
            ;;

    esac
    echo
}
export -f enc_menu