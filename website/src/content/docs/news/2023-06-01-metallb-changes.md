---
slug: "news/metallb-changes"
title: "New MetalLB chart and our own operator charts."
authors: [ornias]
date: 2023-06-01
tags:
  - "2023"
---

**Introdocution: Our own Operator Charts**

The last few months, we've experimented with injecting so-called "operators" into the cluster directly when using our charts. Manifests for things like: MetalLB, Cert-Manager and CNPG where always loaded.
While this system guaranteed users where always running the latest operator versions, we've also encountered some downsides. Primarily:

- Loading manifests from the web is a security issue
- Loading manifests required a pre-install job, with full-cluster permissions. Which is also a security issue.
- Mistakes in the manifests, directly affect all users regardless of version
- It requires creating namespaces outside of the `ix-something` style, while not an issue that's something _somehow_ iX developers voiced annoyance with.
- It lacks any configurability for users that need a customization
- It prevents users from using these operators outside of the TrueCharts scope on non-scale systems

To fix all of these issues, we've had quite the challenge. First off we needed to figure out a way of preventing users from installing multiple instances of the same operator.
But we also needed to ensure ourselves that users always had the correct operators installed for the charts they want to install.

We've by now designed an industry leading helm logic, that scans your cluster for references of installed operators and compares those to the required operators.

Besides this logic, we also need to write the Helm Charts ourselves. This is a lot of work, as operators are often notoriosly complex to write helm charts for.
Luckily we've enough experienced Kubernetes developers that we're certain to pull this off!

**First chart: MetalLB**

As a first example of our new logic, we're super happy to introduce our first self-build operator helm chart: MetalLB.
It will be completely self-contained within it's own namespace, not load dynamic manifests from the web and doesn't contain risky security practices.

Obviously this chart, in the `operators` train, has a naming conflict with the old `metallb` chart in the `enterprise` train, so the later has been renamed to `metallb-config` requiring a reinstall.
We want to point out that only the new `metallb-config` chart is compatible with the new self-build `metallb` operator.

We are very happy to also announce that the `metallb-config` chart, is fully compatible with our old **and** new ways of installing/managing metallb.
However, new installs of the old way of handling metallb (without the chart from the `operators` train), will be actively disabled from now on.

To use MetalLB on new installs, one needs to install both `metallb` **and** `metallb-config`, in that order.

**Updating to the new MetalLB helm chart**

We want to point out though, that users should update the new MetalLB Helm chart _as soon as possible_.
To update a current install using MetalLB to the new system, the following procedure can be used:

- remove the old `metallb` chart coming from the `enterprise` train
- run this in a **root** shell: `k3s kubectl delete  --grace-period 30 --v=4 -k https://github.com/truecharts/manifests/delete`
- install the new `metallb` chart from the `operators` train
- wait a few minutes
- install or update `metallb-config` to the latest version
- wait a few minutes
- Hit `edit` on `metallb-config` and save without changes if you where already on the latest version or it isn't working yet
- wait a few minutes

_If you run into additional issues, please file a ticket with our dedicated support staff via the **#support** channel of our [discord](/s/discord) as normal._
