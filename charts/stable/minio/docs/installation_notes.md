---
title: Installation Notes
---

## TrueNAS SCALE

:::note[Written for]

- Platform: TrueNAS SCALE Cobia 23.10.1
- App Version: 2023.12.23
- Chart Version: 9.1.0

:::

:::caution

When using a PVC the backup data will be stored on the dataset that holds the app data. If minio is used to store backup data to safe guard your application data it is recommended to configure it on a different zpool, this can be done with a hostpath.

:::

:::note[Preparation]

1. Create a dataset for the data mount of minio referred to as <minio_data>
2. Set the proper owner and permissions required for the hostpath, 600 is the minimal permission level required
3. Make sure you have DNS setup for all buckets as S3 requires DNS to be set for each bucket. See "Using Ingress and API ingress is recommended"

:::

This is a guide containing the minimal required settings for installation:

- Workload->Settings->Containers->Main Container->Image Environment
  - `MINIO_ROOT_USER` and `MINIO_ROOT_PASSWORD` represent the username and password used to login to minio
- Storage and Persistence->Integrated Persistent Storage->App Config Storage
  - `Type of Storage` set to host path
  - `Host Path` select the dataset <minio_data>
- Using Ingress and API ingress is recommended
  - Main Ingress (Also the Console) : minio.mydomain.com
  - API ingress: bucket_name.minio.mydomain.com (one entry for each bucket)
