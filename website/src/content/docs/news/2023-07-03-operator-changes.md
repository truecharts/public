---
slug: "news/operator-changes"
title: "Deprecating Old Operators"
authors: [kqmaverick]
date: 2023-07-03
tags:
  - "2023"
---

As part of limiting our promise not to introduce breaking changes to the charts within our Enterprise train, we've ensured both the new and old way of dealing with "operators" were both supported.

Starting August 1, 2023, we will completely drop support for the old (pre-July installs only, internal not user controlled) way of handling operators.

After August 1, 2023, additional checks for operators will be enabled, preventing users from making the mistake of installing charts without the right operator from the operator train present. This means that charts will prevent themselves from being updated when you're still using the old operators at that time.

If you have already installed the metallb, prometheus-operator, and cloudnative-pg operators then no further action is required.

## Prerequisites

Add the operator train to TrueCharts [as outlined here](/

## MetalLB

The MetalLB operator is only required for users of MetalLB, anyone who does not use or plan to use MetalLB can skip this section.

1. Uninstall current metallb from Enterprise train.
2. Run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete`
3. Complete MetalLB installation [as outlined here](/charts/premium/metallb-config/setup-guide/)

## Prometheus

The Prometheus operator is required for the use of app metrics. Its installation is recommended.

1. Run this in the system shell as **root**: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete3`
2. Install prometheus-operator from the operators train. (Deprecated 2025)

## CNPG

The cloudnative-pg operator is required for any applications that utilize postgres. Its installation is recommended.

1. Follow the [CNPG Operator Migration Guide](/ to migrate to the new CNPG operator. Ensure you follow the guide carefully as data loss can occur with this migration if proper steps are not followed.

_If you run into additional issues, please file a ticket with our dedicated support staff via the **#support** channel of our [discord](/s/discord) as normal._
