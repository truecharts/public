---
slug: "news/clustertool-public-beta-release"
title: "ClusterTool Public Beta Release"
authors: [bitpushr]
date: 2024-07-25
tags:
  - "2024"
---

Howdy everyone! I'm back to share some exciting progress updates with you all regarding ClusterTool development, a brief recap on some minor announcements from our part in recent weeks, updated docs and more.

This will be a packed news article from us, so let's get into it!

## ClusterTool Public Beta Update

Over the course of the last month and since our [last update](/news/clustertool-public-alpha-release), ClusterTool has undergone *much* development effort. As we previously outlined in our TrueNAS SCALE migration path roadmap [post](/news/clustertool-update#clustertool-roadmap), ClusterTool's public Beta release will be *mostly* feature-complete, includes SCALE migration tooling (already implemented and awaiting testing) and will be suitable for users to migrate to semi-permanent Talos clusters from TrueNAS SCALE app environments, with Talos running in a Virtual Machine (atop SCALE itself).

ClusterTool has also seen the addition of FluxCD functionality, among others, and new builds are regularly being posted for testing [here](https://github.com/truecharts/clustertool-public/releases). We invite discussion and feedback in the `#clustertool` channel of our [Discord](https://discord.gg/tVsPTHWTtr), or you can simply follow the development of ClusterTool there.

Additionally, through collaborative efforts, we're onboarding additional developers to work on ClusterTool directly throughout its Beta period. The more feedback we get from users, the better we can make the experience for all! We invite our users to test ClusterTool thoroughly throughout this phase and discuss or report any feedback/issues using threads in the above-mentioned Discord channel.

:::caution

Please note that in the early Beta phase, issues and bugs may still arise that lead to users needing a fresh reinstall of their Talos cluster. Thus backups are, as always, **strongly** encouraged

:::

## Docs Updates

In tandem with ClusterTool development, over the course of the last month we've been focused on docs for our users to read regarding Talos, ClusterTool, minimum and recommended system requirements, and more. Here are some links to these docs, though please note some of them are continuing to evolve as we gather feedback throughout this transitory phase.

- [Link](/guides/) to our new Helm-specific guides, including a quick-start guide for installing *charts*, guides for adding storage and backup/restore functionality to *charts*, example VPN setup instructions for your *charts* and more

- [Link](/clustertool) to our all-new ClusterTool docs section which includes various sections on what ClusterTool is, what the various functions of it do and more

- [Link](/clustertool/getting-started) to our ClusterTool getting started guide

- Link to our TrueNAS SCALE -> ClusterTool/Talos migration guide which includes instructions for **prerequisite steps to be performed by users on TrueNAS SCALE prior to migrating to Talos via ClusterTool** *(2025 note: Migration is no longer possible or supported)*

- [Link](/general/systemrequirements) to our Talos VM system requirements section, which leads into platform-specific, start-to-finish guides on how to setup a Talos VM for our users be it on [SCALE](/clustertool/virtual-machines/truenas-scale), [Proxmox](/clustertool/virtual-machines/proxmox), [unRAID](/clustertool/virtual-machines/unraid) or other host platforms.

As always, we welcome feedback and additions to our docs which you can submit by opening a PR in [this](https://github.com/truecharts/website) repo for review. Specifically, we welcome instructions for setting up a Talos VM on platforms other than the ones we've already written guides for.

## Recent Project Recaps

In addition to the above, we've been posting announcements and project-related updates in the `#announcements` channel of our [Discord](https://discord.gg/tVsPTHWTtr). To recap and quickly get up to speed, you will want to read from [this](https://discord.com/channels/830763548678291466/830763549156573216/1245385683921797161) post onwards but to summarise:

- iX-Systems has [decided](https://forums.truenas.com/t/the-future-of-electric-eel-and-apps/5409) to move TrueNAS SCALE to a Docker-based apps backend, which is inherently incompatbile with our Helm-based project, beginning with Electric Eel later this year

- We [released](/news/chart-backups-and-restores) VolSync Backup/Restore functionality for our charts to help facilitate cloud-based backup and restoration of data for TrueCharts users, if desired

- We [released](/news/scale-deprecation) a statement on our decision to deprecate our TrueNAS SCALE apps

- Updates to chart-specific changelogs on our website now happen much faster

- We clarified that TrueNAS SCALE users will **not** be required to be on DragonFish prior to migrating to our Talos VM solution for our *charts* going forward, as Cobia is suitable for migration

- We have removed the TrueNAS SCALE apps catalogue from our project, and associated SCALE-specific code, tooling, etc. has been removed. While the TrueCharts SCALE apps catalogue can no longer be added to SCALE systems, an archived version of our TrueNAS SCALE apps catalogue is available [here](https://github.com/truecharts/archive/tree/main/scale-catalog) for historical purposes. Users with TrueCharts apps still installed in SCALE environments continue to have their apps function ahead of the upcoming migration to Talos, however these apps are strictly in an as-is state and no longer receive **any** updates or support

- We clarified (after some recent confusion from a YouTube video) that the project is still alive, that users should continue to wait for ClusterTool to reach RC or final status before deciding whether to migrate to Talos using it, or switch to an alternative apps platform such as iX/TrueNAS "official" apps, Plain Docker or something else.

This serves as a summary of recent project-related news, and with the rest of this news post, should get you up to speed on the status of things in one go. As always, we very much appreciate you sticking with us through this transition period and we're certain that our project will come out the other side continuing to lead and provide a first-class charts experience for our users.

Thank you for your continued support and understanding as we work to provide the best tools and services for our community. Stay tuned for more exciting updates in the months ahead!
