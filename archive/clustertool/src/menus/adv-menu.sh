#!/usr/bin/sudo bash

adv_menu(){
    clear -x
	echo ""
    echo "ClusterTool: Advanced"
	echo ""
    echo -e "${bold}Available Utilities${reset}"
    echo -e "${bold}-------------------${reset}"
    echo -e "h)  Help"
    echo -e "1)  Talos Recovery"
    echo -e "2)  Manual Talos bootstrap"
    echo -e "3)  (Experimental) Bootstrap FluxCD Cluster"
    echo -e "4)  Install/Update included manifests"
    echo -e "5)  (Destructive) Remove included manifests"
    echo -e "0)  Back"
    read -rt 120 -p "Please select an option by number: " selection || { echo -e "${red}\nFailed to make a selection in time${reset}" ; menu; }


    case $selection in
        0)
            menu
            ;;

        1)
            parse_yaml_env_all
            recover_talos
            exit
            ;;
        2)
            parse_yaml_env_all
            bootstrap
            exit
            ;;
        3)
            parse_yaml_env_all
            bootstrap_flux
            exit
            ;;
        4)
            parse_yaml_env_all
            apply_manifests
            exit
            ;;
        5)
            parse_yaml_env_all
            remove_manifests
            exit
            ;;

        h)
            adv_help
            exit
            ;;

    esac
    echo
}
export -f adv_menu