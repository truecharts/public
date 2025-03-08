---
slug: "news/cert-manager-operator"
title: "Cert-Manager Operator"
authors: [kqmaverick]
date: 2023-07-20
tags:
  - "2023"
---

After building our own MetalLB, CNPG and Prometheus operator charts, we've also now finished the work on building our own Cert-Manager operator chart. As of today this chart will be a requirement for new users if they want to use Cert-Manager and required for all users starting August 1, 2023.

If you have already installed clusterissuer follow the below guidance for installation of the Cert-Manager operator chart.

If you have not already done so add the operator train to TrueCharts [as outlined here](/

1. Run this in the system shell as **root**: <br />
   `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete4`
2. Install cert-manager from the operators train. (Deprecated 2025)
3. Update [clusterissuer](/charts/premium/clusterissuer/) to the latest version of (2.0.1+).

- If you are already on the latest version perform an empty edit of clusterissuer (Edit app and save without making any changes).

_If you run into additional issues, please file a ticket with our dedicated support staff via the **#support** channel of our [discord](/s/discord) as normal._
