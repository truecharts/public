---
title: Run Talos in a Dockerfile
---

:::caution[Disclaimer]

This guide is not covered by the Support Policy and some features wont work when running Talos as a dockerfile.

:::

Talos can be run as a docker container. This has a couple of downsides like:

- No system-extensions
- No TalosCTL  reset -> restart  the containers and/or wipe container storage instead
- Dependance on host-kernel -> host kernel might not be optimised for talos
- No MetalLB -> use ServiceLB or node port instead
- No TalosCTL Upgrade -> update the container instead
- Nvidia GPU Assignment
- Warning spam in container logs that it cant alter bpf related stuff
- CEPH and such can hijack drives -> Be careful!

## Dockerfile

Following you will find a dockerfile on how to run Talos as a docker container.

```yaml
services:
  talos-control-1:
    container_name: talos-control-1
    environment:
      - PLATFORM=container
    hostname: talos-control-1
    image: ghcr.io/siderolabs/talos:v1.10.2
    networks:
      talosnet:
        ipv4_address: 192.168.10.50
    privileged: true
    read_only: true
    tmpfs:
      - /run
      - /system
      - /tmp
    volumes:
      - /dev/zfs:/dev/zfs
      - /mnt/tank/apps/talos/control/system/state:/system/state
      - /mnt/tank/apps/talos/control/system/var:/var
      - /mnt/tank/apps/talos/control/system/cni:/etc/cni
      - /mnt/tank/apps/talos/control/system/kubernetes:/etc/kubernetes
      - /mnt/tank/apps/talos/control/system/libexec:/usr/libexec/kubernetes
      - /mnt/tank/apps/talos/control/system/opt:/opt
      - /mnt/tank/apps/talos/control/data/openebs:/var/openebs/local
  talos-worker-1:
    container_name: talos-worker-1
    environment:
      - PLATFORM=container
    hostname: talos-worker-1
    image: ghcr.io/siderolabs/talos:v1.10.2
    networks:
      talosnet:
        ipv4_address: 192.168.10.51
    privileged: true
    read_only: true
    tmpfs:
      - /run
      - /system
      - /tmp
    volumes:
      - /dev/zfs:/dev/zfs
      - /mnt/tank/apps/talos/worker/system/state:/system/state
      - /mnt/tank/apps/talos/worker/system/var:/var
      - /mnt/tank/apps/talos/worker/system/cni:/etc/cni
      - /mnt/tank/apps/talos/worker/system/kubernetes:/etc/kubernetes
      - /mnt/tank/apps/talos/worker/system/libexec:/usr/libexec/kubernetes
      - /mnt/tank/apps/talos/worker/system/opt:/opt
      - /mnt/tank/apps/talos/worker/data/openebs:/var/openebs/local
networks:
  talosnet:
    driver: macvlan
    driver_opts:
      parent: br0
    ipam:
      driver: default
      config:
        - subnet: 192.168.10.0/24
          gateway: 192.168.10.1

```

## Modifications to your Machineconfig

Running Talos inside a dockerfile requires some modifications to talos machine config:

```yaml

machine:
  features:
    hostDNS:
      enabled: true
      forwardKubeDNSToHost: true

```

## Modifications to your talhelper/clustertool talconfig

```yaml

nodes:
    - hostname: k8s-control-0
      ipAddress: ${MASTER1IP}
      controlPlane: true
      nameservers:
        - 192.168.10.21
        - 1.1.1.1
      installDiskSelector:
        size:  ">= 100GB"
      networkInterfaces:
        # suffix is the adapter mac adres.
        - deviceSelector:
            hardwareAddr: "02:*"
```
