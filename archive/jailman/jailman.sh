#!/usr/local/bin/bash

# Important defines:
# shellcheck disable=SC2046
SCRIPT_NAME=$(basename $(test -L "${BASH_SOURCE[0]}" && readlink "${BASH_SOURCE[0]}" || echo "${BASH_SOURCE[0]}"));
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd);
export SCRIPT_NAME
export SCRIPT_DIR

echo "Working directory for jailman.sh is: ${SCRIPT_DIR}"

#Includes
# shellcheck source=global.sh
source "${SCRIPT_DIR}/global.sh"

# Check for root privileges
if ! [ "$(id -u)" = 0 ]; then
   echo "This script must be run with root privileges"
   exit 1
fi

# Auto Update
gitupdate $(git for-each-ref --format='%(upstream:short)' "$(git symbolic-ref -q HEAD)") || exit 1

# If no option is given, point to the help menu
if [ $# -eq 0 ]
then
echo "Missing options!"
        echo "(run $0 -h for help)"
        echo ""
        exit 0
fi

# Go through the options and put the jails requested in an array
unset -v sub
while getopts ":i:r:u:d:g:h" opt
   do
   #Shellcheck on wordsplitting will be disabled. Wordsplitting can't happen, because it's already split using OPTIND.
     case $opt in
        i ) installjails=("$OPTARG")
            # shellcheck disable=SC2046
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                # shellcheck disable=SC2207
                installjails+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
        r ) redojails=("$OPTARG")
            # shellcheck disable=SC2046
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                # shellcheck disable=SC2207
                redojails+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
        u ) updatejails=("$OPTARG")
            # shellcheck disable=SC2046
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                # shellcheck disable=SC2207
                updatejails+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
        d ) destroyjails=("$OPTARG")
            # shellcheck disable=SC2046
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                # shellcheck disable=SC2207
                destroyjails+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
    g ) upgradejails=("$OPTARG")
            # shellcheck disable=SC2046
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]; do
                # shellcheck disable=SC2207
                upgradejails+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
    h )
        echo "Usage:"
            echo "$0 -i "
            echo "$0 -r "
            echo "$0 -u "
            echo "$0 -d  "
            echo "$0 -g "
            echo ""
            echo "   -i to install jails, listed by name, space seperated like this: jackett plex sonarr"
            echo "   -r to reinstall jails, listed by name, space seperated like this: jackett plex sonarr"
            echo "   -u to update jails, listed by name, space seperated like this: jackett plex sonarr"
            echo "   -d to destroy jails, listed by name, space seperated like this: jackett plex sonarrt"
            echo "   -g to upgrade jails, listed by name, space seperated like this: jackett plex sonarr"
            echo "   -h help (this output)"
            exit 0
            ;;
    ? ) echo "Error: Invalid option was specified -$OPTARG"
            exit 0
            ;;
     esac
done

# auto detect iocage install location
global_dataset_iocage=$(zfs get -H -o value mountpoint $(iocage get -p)/iocage)
global_dataset_iocage=${global_dataset_iocage#/mnt/}
export global_dataset_iocage

# Parse the Config YAML
# shellcheck disable=SC2046
for configpath in "${SCRIPT_DIR}"/blueprints/*/config.yml; do ! eval $(parse_yaml "${configpath}"); done
eval "$(parse_yaml config.yml)"

# shellcheck disable=SC2154
if [ "${global_version}" != "1.2" ]; then
    echo "You are using old config.yml synatx."
    echo "Please check the wiki for required changes"
    exit 1
fi

# Check and Execute requested jail destructions
if [ ${#destroyjails[@]} -eq 0 ]; then
    echo "No jails to destroy"
else
    # shellcheck disable=SC2124,SC2145
    echo "jails to destroy ${destroyjails[@]}"
    for jail in "${destroyjails[@]}"
    do
        echo "destroying $jail"
        iocage destroy -f "${jail}"
    done

fi

# Check and Execute requested jail Installs
if [ ${#installjails[@]} -eq 0 ]; then
    echo "No jails to install"
else
    # shellcheck disable=SC2124,SC2145
    echo "jails to install ${installjails[@]}"
    for jail in "${installjails[@]}"
    do
        blueprint=jail_${jail}_blueprint
        if [ -z "${!blueprint}" ]
        then
            echo "Config for ${jail} in config.yml incorrect. Please check your config."
            exit 1
        elif [ -f "${SCRIPT_DIR}/blueprints/${!blueprint}/install.sh" ]
        then
            echo "Installing $jail"
            jailcreate "${jail}" "${!blueprint}" && "${SCRIPT_DIR}"/blueprints/"${!blueprint}"/install.sh "${jail}"
        else
            echo "Missing blueprint ${!blueprint} for $jail in ${SCRIPT_DIR}/blueprints/${!blueprint}/install.sh"
            exit 1
        fi
    done
fi

# Check and Execute requested jail Reinstalls
if [ ${#redojails[@]} -eq 0 ]; then
    echo "No jails to ReInstall"
else
    # shellcheck disable=SC2124,SC2145
    echo "jails to reinstall ${redojails[@]}"
    for jail in "${redojails[@]}"
    do
        blueprint=jail_${jail}_blueprint
        if [ -z "${!blueprint}" ]
        then
            echo "Config for ${jail} in config.yml incorrect. Please check your config."
            exit 1
        elif [ -f "${SCRIPT_DIR}/blueprints/${!blueprint}/install.sh" ]
        then
            echo "Reinstalling $jail"
            iocage destroy -f "${jail}" && jailcreate "${jail}" "${!blueprint}" && "${SCRIPT_DIR}"/blueprints/"${!blueprint}"/install.sh "${jail}"
        else
            echo "Missing blueprint ${!blueprint} for $jail in ${SCRIPT_DIR}/blueprints/${!blueprint}/install.sh"
            exit 1
        fi
    done
fi


# Check and Execute requested jail Updates
if [ ${#updatejails[@]} -eq 0 ]; then
    echo "No jails to Update"
else
    # shellcheck disable=SC2124,SC2145
    echo "jails to update ${updatejails[@]}"
    for jail in "${updatejails[@]}"
    do
        blueprint=jail_${jail}_blueprint
        if [ -z "${!blueprint}" ]
        then
            echo "Config for ${jail} in config.yml incorrect. Please check your config."
            exit 1
        elif [ -f "${SCRIPT_DIR}/blueprints/${!blueprint}/update.sh" ]
        then
            echo "Updating $jail"
            iocage update "${jail}"
            iocage exec "${jail}" "pkg update && pkg upgrade -y" && "${SCRIPT_DIR}"/blueprints/"${!blueprint}"/update.sh "${jail}"
            iocage restart "${jail}"
            iocage start "${jail}"
        else
            echo "Missing blueprint ${!blueprint} for $jail in ${SCRIPT_DIR}/blueprints/${!blueprint}/install.sh"
            exit 1
        fi
    done
fi

# Check and Execute requested jail Upgrades
if [ ${#upgradejails[@]} -eq 0 ]; then
    echo "No jails to Upgrade"
else
    # shellcheck disable=SC2124,SC2145
    echo "jails to update ${upgradejails[@]}"
    for jail in "${upgradejails[@]}"
    do
        blueprint=jail_${jail}_blueprint
        if [ -z "${!blueprint}" ]
            then
            echo "Config for ${jail} in config.yml incorrect. Please check your config."
            exit 1
        elif [ -f "${SCRIPT_DIR}/blueprints/${!blueprint}/update.sh" ]
        then
            echo "Currently Upgrading is not yet included in this script."
        else
            echo "Currently Upgrading is not yet included in this script."
            exit 1
        fi
    done
fi
