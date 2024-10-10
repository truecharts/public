---
title: PostgreSQL Database Exporting
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

The information below is to help with current or future migration of the Postgres databases on your SCALE system running TrueCharts apps.

## Prerequisites

The user running the scripts must have permissions to access the TrueNAS SCALE host shell and execute `kubectl` commands.

## How to list database login info for TrueCharts apps

You can use these details to login to e.g. `pgadmin`, one of the TC apps that lets you manage databases.

```bash title="tcdbinfo.sh"
#!/bin/bash

# get namespaces
namespaces=$(k3s kubectl get secrets -A | grep -E "dbcreds|cnpg-main-urls" | awk '{print $1, $2}')

# iterate over namespaces
( printf "Application | Username | Password | Address | Port\n"
echo "$namespaces" | while read ns secret; do
    # extract application name
    app_name=$(echo "$ns" | sed 's/^ix-//')
    if [ "$secret" = "dbcreds" ]; then
        creds=$(k3s kubectl get secret/$secret --namespace "$ns" -o jsonpath='{.data.url}' | base64 -d)
    else
        creds=$(k3s kubectl get secret/$secret --namespace "$ns" -o jsonpath='{.data.std}' | base64 -d)
    fi

    # get username, password, addresspart, and port
    username=$(echo "$creds" | awk -F '//' '{print $2}' | awk -F ':' '{print $1}')
    password=$(echo "$creds" | awk -F ':' '{print $3}' | awk -F '@' '{print $1}')
    addresspart=$(echo "$creds" | awk -F '@' '{print $2}' | awk -F ':' '{print $1}')
    port=$(echo "$creds" | awk -F ':' '{print $4}' | awk -F '/' '{print $1}')

    # construct full address
    full_address="${addresspart}.${ns}.svc.cluster.local"

    # print results with aligned columns
    printf "%s | %s | %s | %s | %s\n" "$app_name" "$username" "$password" "$full_address" "$port"
done ) | column -t -s "|"
```

## Setting up the files

In TrueNAS SCALE, create a dataset that can house the script files. Put the `.sh` files in that dataset. Navigate to the dataset from the host shell. Make the files executable.

```bash
cd /mnt/tank/scripts/databases
chmod +x tcdbinfo.sh
```
