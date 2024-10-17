---
slug: "news/clustertool-public-alpha-release"
title: "ClusterTool Public Alpha Release and Updated Support Scope"
authors: [bitpushr]
date: 2024-07-05
tags:
  - "2024"
---
We're back to share some new updates with our users around ClusterTool, an updated support policy and further updates on the status of TrueNAS SCALE support.

## ClusterTool Public Alpha Release

First up, we are excited to announce the public Alpha release of ClusterTool! This marks a significant step forward in our mission to provide powerful tools for bootstrapping and managing your own Kubernetes clusters on [Talos](https://www.talos.dev/), our platform of choice going forward.

Please note that [KubeApps](https://kubeapps.dev/) is not yet compatible with ClusterTool, and we currently do not offer any migration tooling to facilitate the transition of TrueNAS SCALE apps to Talos. This will come in a future release, per the timeline we previously outlined [here](/news/clustertool-update).

You can find and download the latest releases of ClusterTool [here](https://github.com/truecharts/clustertool-public/releases). We also have a `clustertool` channel available on our [Discord](https://discord.gg/tVsPTHWTtr) which users can use to discuss usage of the tool, and users can find our ClusterTool documentation [here](/clustertool).

## Updated Support Policy

We have updated our support policy in an effort to provide clearer, more defined guidelines for our users going forward. The updated policy includes information on our expectations around assumed/prior knowledge for users going forward, what's not covered by TrueCharts support and more.

We would like to note that, in general, using our Charts with Kubernetes running on Talos will be a radically different experience compared to the prior experience afforded by TrueNAS SCALE. We are expecting some users that might have previously been comfortable running TrueCharts charts on SCALE, will not be comfortable with continuing to use TrueCharts on Talos.

In the future, we will post a news article outlining alternative options for TrueCharts users who do not wish to continue on Talos. These options may include

- Migrating to iX/TrueNAS "official" apps
- Migrating to unRAID
- Migrating to a sandbox or "DIY Docker" setup
- Options afforded by [ElfHosted](https://elfhosted.com/).

Going forward, we will assume users that wish to continue using TrueCharts on Talos have prior knowledge of the following:

- How to use a shell, terminal or console
- How to use basic shell commands to manage or perform actions on platforms such as Talos
- How to use `kubectl` to get pods or services, describe issues, etc.
- Basic knowledge of Talos including what "applying" does, what a "machineconfig" is and how "upgrades" work vs `k8s-upgrade`
- Basic knowledge of Kubernetes including what a "pod" or "container" is
- Others outlined below.

TrueCharts support will also **not** assist users with (including but not limited to) the below:

- Network configuration
- CloudFlare proxying
- How to install or use `kubectl` or `talosctl`
- Helm 101 (how to install, upgrade or edit a Helm Chart)
- Configuring specific apps/software in TrueCharts Charts, e.g. Plex/Sonarr/etc. configuration.

For more information, please review the updated support policy [here](/general/support-policy).

## Discontinuation of Support for TrueCharts App Installs on TrueNAS SCALE

As part of our commitment to the path forward away from running TrueCharts apps on TrueNAS SCALE, we have discontinued **support** for new TrueCharts app installs on TrueNAS SCALE. TrueNAS SCALE is now a deprecated platform as far as TrueCharts apps are concerned, and this change is to ensure users are not left without support for new app installations.

Code related to the building of, development of, and other aspects of TrueNAS SCALE apps/charts support has been removed from the TrueCharts project backend.

To clarify: users *can* still install existing versions of TrueCharts apps/charts on TrueNAS SCALE, but they will **not** be eligible for support.

We advise users to await further migration updates as outlined in our roadmap linked above.

Thank you for your continued support and understanding as we work to provide the best tools and services for our community. Stay tuned for more exciting updates in the months ahead!
