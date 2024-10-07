#!/usr/bin/sudo bash

menu(){
    clear -x
    title
    echo -e "${bold}Available Utilities${reset}"
    echo -e "${bold}-------------------${reset}"
    echo -e "h)  Help"
    echo -e "1)  Install/Update Dependencies"
    echo -e "2)  Encryption Options"
    echo -e "3)  (re)Generate Cluster Config"
    echo -e "4)  Bootstrap/Apply Talos Cluster Config"
    echo -e "5)  Upgrade Talos Cluster Nodes"
    echo -e "6)  Advanced Options"
    echo -e "0)  Exit"
    read -rt 120 -p "Please select an option by number: " selection || { echo -e "${red}\nFailed to make a selection in time${reset}" ; exit; }


    case $selection in
        0)
            echo -e "Exiting.."
            exit
            ;;

        1)
            install_deps
            ;;
        2)
            enc_menu
            exit
            ;;
        3)
            parse_yaml_env_all
            regen
            exit
            ;;
        4)
            parse_yaml_env_all
            apply_talos_config
            exit
            ;;
        5)
            parse_yaml_env_all
            upgrade_talos_nodes
            exit
            ;;
        6)
            adv_menu
            exit
            ;;
        h)
            main_help
            exit
            ;;

    esac
    echo
}
export -f menu