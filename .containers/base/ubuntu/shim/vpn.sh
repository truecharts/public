#!/usr/bin/env bash

WAIT_FOR_VPN=${WAIT_FOR_VPN:-"false"}

if
    [[ "${WAIT_FOR_VPN}" == "true" ]];
then
    echo "Waiting for VPN to be connected..."
    while ! grep -s -q "connected" /shared/vpnstatus;
    do
        echo "VPN not connected"
        sleep 2
    done
    echo "VPN Connected, starting application..."
fi
