---
slug: "news/docker-compose-talos"
title: "Truenas-Oriented Talos Docker-Compose"
authors: [alfi0812, privatepuffin]
date: 2025-05-28
tags:
  - "2025"
---

## TrueNAS Switches to Incus with Fangtooth Release — VM Support Now Experimental

With the release of TrueNAS SCALE Fangtooth, iXsystems has officially switched its virtualization backend from KVM to Incus.
This transition has introduced several limitations, and VM support is now also labeled as experimental. Leaving users without a stable VM-solution on TrueNAS.

Users have reported performance issues with the new Incus-based VM system,
and some previously supported configurations—such as running VMs with raw-file backed disks (making use of ZFS small-blocks special-vdevs) — are no longer functional.
Currently, there are no official Talos options available for Incus, making it difficult for users to control the VM threw TrueNAS UI.

In light of this, TrueCharts has reaffirmed its commitment to the TrueNAS community by releasing a new guide
on how to run Talos as a Docker container inside SCALE Apps.
This approach provides a practical alternative for those affected by the VM backend changes,
allowing continued experimentation and development with Talos despite the Incus limitations.
