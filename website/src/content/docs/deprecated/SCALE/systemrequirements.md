---
title: System Requirements
sidebar:
  order: 3
---

:::danger

TrueNAS SCALE Apps are considered Deprecated. We heavily recommend using a more mature Kubernetes platform such as "TalosOS" instead, and no longer offer an apps/charts catalogue for SCALE users to install. The below docs exist purely as historical references and may be removed at any time.

:::

All of the below recommendations assume the TrueNAS system in question is not used for anything other than running apps and storage. Adding VMs, network shares or other services may significantly increase overall system requirements.

## Minimum System Specifications

Systems complying with these minimum specifications will be able to run **some** of our apps and will likely be limited to just a few at the same time. Experiences in terms of performance and which apps work may vary.

**CPU:** 4 *Physical* Cores

**RAM:** 16GB+

**GPU:** None

**Apps Storage:** 250GB HDD apps Pool **with** a supporting SSD metadata/8K-smallblocks "special" VDEV or 250GB+ SSD apps Pool.

:::note

To be clear: An apps pool residing on HDD-based storage **without** a supporting SSD-based small-blocks/metadata aka "special" VDEV is **NOT** supported.

:::

## Recommended System Specifications

Systems complying with these recommended specifications will likely be able to run almost any app we offer and likely many at the same time, depending on system load and the specific apps in deployment.

**CPU:** 8 *Physical* Cores

**RAM:** 32GB+

**GPU:** Intel iGPU (some Nvidia and AMD GPUs are supported, albeit with potential caveats)

**Apps Storage:** 1TB+ SSD-based apps pool or HDD **with** a supporting SSD metadata/16K-smallblocks special VDEV.
