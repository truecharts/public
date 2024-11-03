---
slug: "news/traefik-changes"
title: "Traefik Changes"
authors: [ornias]
date: 2023-05-24
tags:
  - "2023"
---

BLUF: Traefik (Stable) is Deprecated. Users need to add the Enterprise channel and install Traefik.
[See how to get started](/

The use of TrueNAS Scale Certificates is also deprecated and you must migrate to [Clusterissuer](/charts/premium/clusterissuer/how-to).
(note: Clusterissuer replaced Cert-Manager)

As some of you might've noticed, Traefik has been a bit outdated the last few weeks.
The reason behind this, was a multitude of potentially breaking todo's where left and we don't want to bother users with continues manual intervention on breaking changes.
By now we've fixed the remaining issues and will soon release a breaking-change release for traefik and a patch for all the charts.

In short we've ensured that we only use our signature "tc-system" namespace for storing configuration and middlewares for traefik. This ensures consistent behavior for users using ingressClasses and allowed us to, cleanly, fix the known bug where a port got appended to the TrueNAS SCALE "portal" button.

This also means that charts that do not get patches because they are not ported to new common, most notably: Nextcloud
Will inherently not work anymore. Though, users would've been ill-advised using it at all currently... due to the big ongoing nextcloud rework.

**Unrelated new issue**

We also got the request from iX-systems staff a while ago to limit our use of non-ix-prefixed namespaces on kubernetes. While the other work to do so, requires a **lot** of work building our own operator helm-charts, these Traefik changes are the initial step to comply to those wishes. The "low hanging fruit".

As we're working hard on building separate operator helm-charts, instead of handling it in the background.This work leads to a unrelated temporary issue, which has been created on purpose: CNPG will currently only be installed on new systems, if one of our "enterprise" charts is being installed.
More news about this will be released later.

_For any help, please file a ticket with our dedicated support staff via the **#support** channel of our [discord](/s/discord) as normal._
