---
slug: "news/docker-compose-talos"
title: "Truenas-Oriented Talos Docker-Compose"
authors: [alfi0812, privatepuffin]
date: 2025-05-28
tags:
  - "2025"
---

With the release of TrueNAS SCALE Fangtooth, iXsystems has officially switched its virtualization backend from KVM to Incus.
This transition has introduced several limitations, and VM support is now also labeled as experimental, leaving users without a stable VM solution on TrueNAS.

Users have reported performance issues with the new Incus-based VM system,
and some previously supported configurations such as running VMs with raw-file backed disks
(making use of ZFS small-blocks special-vdevs) are no longer functional.
Currently, there is no official Incus-Guest-Agent available on Talos, making it difficult for users to control the VM through the TrueNAS UI.

Users have been requesting a Kubernetes solution within the iX-supported Apps/Instances system for quite some time.
Traditional containerization approaches like LXC/LXD or jails were never viable options for us
as they lack support for Talos and present significant management challenges.
However, after careful testing and evaluation, we've concluded that integrating Talos in container form within the existing Docker Compose-based Apps system presents a compelling solution.
This approach enables users to run Kubernetes on TrueNAS SCALE without the added complexity of virtual machines or the maintenance burden of homegrown setups,
striking a practical balance between performance, simplicity and native integration.

In light of this, we have reaffirmed our commitment to the TrueNAS community by releasing a new guide
on how to run Talos as a Docker container inside SCALE Apps.
This approach provides a practical alternative for those affected by the VM backend changes,
allowing continued experimentation and development with Talos despite the Incus limitations.

To get started with Talos as a Docker-Compose App following the following [this](/guides/talos/docker).
