---
title: Installation Notes
---

:::caution

There is only one persistence configured in the standard template. Which is used to store the config of minio and is mounted to `/data`.
If you want the backup data on a different PVC/NFS share/.... Configure an extra persistence in your Helm values.

When minio is used to store backup data like your VOLSYNC data for example, make sure this deployment is not on the same server as where all other charts are running.

:::

:::note[Preparation]

1. CHMOD 600 is the minimal permission level required for storage
2. Make sure you have DNS setup for all buckets as S3 requires DNS to be set for each bucket. See "Using Ingress and API ingress is recommended"

:::

This is the minimal required settings for deployment via environment variables:

- `MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD` represent the username and password used to login to minio.

For detailed information regarding all environment variables, check documention upstream.
