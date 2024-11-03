---
slug: "news/chart-backups-and-restores"
title: "Enhanced Chart Backup and Restore Solutions"
authors: [bitpushr]
date: 2024-05-29
tags:
  - "2024"
---

## Enhancing Backups and Restores for TrueCharts Users

Today, we are pleased to announce new solutions for backing up and restoring of TrueCharts CNPG and application/chart data. We hope you enjoy!

### Introducing CloudNativePG Backup and Restore Support for TrueCharts

We are excited to announce that TrueCharts now supports [CloudNativePG](https://cloudnative-pg.io/) backup and restore functionalities with S3 storage providers such as [MinIO](https://min.io/) hosts, [BackBlaze](https://www.backblaze.com/docs/cloud-storage-s3-compatible-api), [CloudFlare](https://www.cloudflare.com/en-au/developer-platform/r2/), [Amazon](https://aws.amazon.com/s3/) (coming soon) and more. This new feature offers TrueCharts users a seamless and efficient way to manage their database backups directly to the cloud, or to a local MinIO host.

By leveraging solutions provided by S3 storage providers, TrueCharts users can now

- Enhance data security by storing backups in secure, scalable and durable storage

- Optimize storage costs by taking advantage of the inherently cost-effective and scalable nature of S3 storage

- Ensure reliability by benefiting from the high availability and enhanced redundancy offers by S3 providers

- Simplify backup management by easily automating backup scheduled and managing them from an apps' TrueNAS SCALE GUI or other interface

With this addition, TrueCharts users can rest assured that their applications' CNPG data is easily recovered as needed, minimizing the risk of data loss and downtime.

### Simplifying PVC Backups with VolSync

In addition to the above CNPG enhancements, TrueCharts is proud to introduce [VolSync](https://github.com/backube/volsync)'s automatic backup and restore capabilities for PVC storage. VolSync simplifies the process of managing PVC backups, ensuring that your data is safeguarded.

Key features of VolSync include

- Automatic backups of a chart or apps' PVC data

- Effortless restoring of PVC containers to a prior state when an app is (re)installed

- Management on a per-app basis from an apps' TrueNAS SCALE GUI, Helm or other any interface

By integrating VolSync, TrueCharts users achieve a higher level of data resilience, making it easier than ever to safeguard or recover an application/charts' data.

### Expanding Backups and Restores on Helm

TrueCharts is a multi-platform project that builds Helm charts with multiple downstream targets, including TrueNAS SCALE among others. As such, we've also published the above CNPG and VolSync guides to the Helm platform [section](/general/support-policy/) of our docs. This allows TrueCharts users running Helm directly to also integrate these new features.

### Caveats

Currently, this new restore functionality isn't yet functional on TrueNAS SCALE due to an [upstream bug](https://github.com/openebs/zfs-localpv/issues/536) with OpenEBS. We've submitted a bug report and will update the docs page linked below once this is resolved. For users of our charts on other Helm platforms, this does not apply, so backup and restore functionality should work fine.

### Documentation and Instructions

You can find our initial guides and documentation for how to take advantage of the above exciting new solutions for SCALE [here](/, and in the Helm section linked above. Please note that these pages will evolve and be updated in the near future, especially once functionality on SCALE is _restored_, and we welcome discussion in our [Discord](https://discord.gg/tVsPTHWTtr) [channel](https://discord.com/channels/830763548678291466/1234481318499323956).

## Closing Out

We're committed to providing continual improvements and features to our users, thanks largely to those who have generously donated towards our project 💙. You allow TrueCharts to continue evolving.

If you find our documentation/guides helpful or want to join the ranks of the over 250 people helping buy us Coffee ☕ you can do this via our Open Collective page here:

[One time or recurring Coffee donations 🫶](https://opencollective.com/truecharts)

Thank you for choosing TrueCharts. Happy charting!
