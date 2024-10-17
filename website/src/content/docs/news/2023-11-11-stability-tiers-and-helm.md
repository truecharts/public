---
slug: "news/stability-tiers-and-helm"
title: "Stability Tiers and Helm Support"
authors: [ornias]
date: 2023-11-11
tags:
  - "2023"
---

We're very glad to announce a new step in our project: Stability Tiers.

**What are Stability Tiers?**

Stability Tiers is a tier list of platforms supported by TrueCharts, ranked by how well we think our Charts function on each platform.
Of course, all platforms get full access to community support, but we want to give realistic expectations on how many "snags" users can experience on the platform of their choice.

**Improved First-Tier Helm Support**

With the new tiers, we are also finally ready to announce that we've completed the required work to officially release our Normal Helm Charts as a first-tier supported platform.
This also means that our industry-leading community support is now available for Helm users!

We want to make clear that, just as with SCALE, not every setting we offer is going to work well with every Chart.
Sadly, we have not documented this very well, if at all. In the future, we want to document the release state (Experimental or GA) clearly for each Helm option in the documentation.

**TrueNAS SCALE and Its Tier**

While previously we've seen great effort and interest from the developers of TrueNAS SCALE, iXsystems, there's been a shift in priorities towards limiting Kubernetes support and prioritising their own catalogs at the cost of third parties like TrueCharts.
We've also noticed a shift away from their previous plans to support multi-node clusters, accompanied by a disappointing disregard for providing any decent backup utility for their platform.

At the same time, we've been working hard on hardening our pipelines by signing both our container builds and Helm Charts. Sadly, TrueNAS SCALE, due to explicit design choices by iXsystems, also does not offer any tooling to ensure Helm Charts have their signatures validated before installation.
This leads us to conclude that TrueNAS SCALE Apps are inherently less secure and professional than Helm Charts.

All in all, and after long deliberation, this has led us to decide to move TrueNAS SCALE to a "Second Tier" platform, as we cannot fully guarantee the same stability and reliability that normal Helm offers.
This, however, does _not_ mean a decrease in development efforts. We're still planning to fully support the platform where we can and expand both the catalog and our feature set on there in the future.

What it does mean is that some features might be slightly less reliable due to poorly designed "middleware" that is part of TrueNAS SCALE, which we, sadly enough, cannot do much against.

**Future Platforms**

However, there is more!
We're also glad to announce we're working on supporting two more ways of deploying our Helm charts:

- **FluxCD**
- **Rancher**

For FluxCD, we hope to create a catalog of pre-made `helm-release+kustomize` files that can be readily copy-pasted into your GitOps repository!
Even better, we're working hard to automate the deployment of GitOps with Flux, Sops-Encryption, and even a dedicated operating system: Talos-OS!

For Rancher, while you can already load our helm charts into Rancher and edit the YAML like any other Helm Chart, we are planning to add custom Rancher GUI elements to each and every published Helm chart. Just like with SCALE, but this time fully Kubernetes aware without complicated middleware!

**The Tier List**

This leads us to the following Stability Tier List, which will be documented on the website **insert link here** and adapted where needed:

1. Helm
2. TrueNAS SCALE

We hope this gives users more clarity on which platform to pick and what experience to expect. We're super stoked to expand this list in the future to support more awesome platforms!
