---
title: Adding Storage
---

## What is persistence?

Persistence defines all forms of "storage" that can be added to a chart. This can be config text mounted to a file, RAMdisks, or most frequently, actual data storage.

## Requirements

For PVC storage to function correctly, it's important to already have a storageClass defined and a "Container Storage Interface" setup. Some platforms ship with this (SCALE, Harvester) while others need you to set this up manually (TalOS).

## How to Setup

To setup persistence, add the following section to your values.yaml manually and adapt as needed:

```yaml
// values.yaml
persistence:
  config:
    enabled: true
    type: pvc
    mountPath: /mystorage
```

```yaml
// values.yaml
persistence:
  config:
    enabled: true
    type: nfs
    path: /mnt/data/media
    mountPath: /media
    server: 192.168.0.100
```

In some cases an ingress might already been partly defined. That means you should append the information as you need it, but not touch, for example, the mountPath.

## More info

For more info, check out the common-chart [persistence options](/common/persistence/)
