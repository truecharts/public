---
slug: "news/common-release-schedule"
title: "New breaking common release"
authors: [ornias]
date: 2023-02-23
tags:
  - "2023"
---

One of the core components of TrueCharts is our "common" chart, which serves as the basis on which all other charts are built.

The common chart is a massive collection of thousands of lines of code that provide a wide range of features and optimizations for all apps running on the TrueCharts platform. From November of last year until now, the TrueCharts team has been working tirelessly to completely rewrite the common chart from scratch. They've also incorporated feedback from the community, including feature requests and bug reports, to ensure that the new common chart meets the needs of all users.

After many months of work, the TrueCharts team is excited to announce that the new common chart is almost here! However, there are some important things that users should be aware of before upgrading.
Firstly, deployment of the new common chart will take place in March 2023, and all container updates will be frozen for a month. The new common chart will be deployed in stages for the Enterprise, Dependency (except postgresql), Incubator, and April trains, and then to the stable train and postgresql dependency. This means that users may need to reinstall certain apps, and some settings such as replicas and securityContext will be reset.

Users with PostgreSQL apps will need to be aware that their databases will be nuked, so they will need to take appropriate backups before upgrading. Additionally, users will need to disable VPN before updating, as the new common chart uses a different database backend that allows for the implementation of much-requested backup features and exposes more PostgreSQL settings in the GUI in the future.

Despite these temporary inconveniences, the new common chart promises to deliver many improvements to the TrueCharts platform. For example, there is a new VPN addon based on "Gluetun," which offers more support for OpenVPN and Wireguard and is a maintained project. This addon will replace the old "OpenVPN" and "WireGuard" options. The new common chart also includes the option to mount a config folder for OpenVPN and the option to mount OpenVPN config directly in values.yaml for native helm users.

There is also an all-new PostgreSQL backend based on "CloudNative-PG," which supports backup, high-availability, connection pooling, and split RW/RO. Multi-pod support is also now available, which includes potential future GUI compatibility. The new common chart also features automatic detection for env-var conflicts, build-in support for jobs and cronjobs, and a completely new certificate backend based on the industry standard "Cert-Manager."

In conclusion, the new common chart is a significant update that promises to deliver many improvements and optimizations to the TrueCharts platform. Users should take note of the deployment schedule and be prepared for some temporary inconveniences. However, the long-term benefits of the new common chart should far outweigh any short-term disruptions.

\*_Summarised:_

March will be deployment month, which has the following consequences (until 01-04-2023):

- In March, we will code freeze all container updates for 1 month
- During March we will start deploying the new common in stages for the Enterprise, Dependency (except postgresql), Incubator and April trains and in that order.
- During we will start deploying the new common to the stable train and postgresql dependency.
- Users might have to reinstall certain apps
- All apps will have some settings reset such as: replica's, securityContext etc.
- Postgresql Apps will automatically nuke their databases
- Users will have to disable VPN before updating
- Users will be explained that this is due to moving to a different database backend that allows us to implement the much wanted backup features and expose more postgresql settings in the GUI in the future

A short example of some of the many improvements in the new common chart:

- A new VPN addon based on "Gluetun", which offers much more support for OpenVPN and Wireguard and is an actually maintained project (security etc.) It will replace the old "OpenVPN" and "WireGuard" options.
- The option to (also) mount a config folder instead of just a configfile for OpenVPN.
- The option to mount OpenVPN config directly in values.yaml, for native helm users
- An All-New Postgresql backend based on "CloudNative-PG", supporting things like: Backup, High-Availability, Connection Pooling, Split RW/RO
- Multi-Pod support, including potential future GUI compatibility.
- Automatic detection for Env-var conflicts, if user entered custom env-vars conflict with pre-defined ones
- Build-in support for Jobs and CronJobs, without customizations on a per-app basis.
- A completely new certificate backend based on the industry standard "Cert-Manager".
- Much more hardening of defaults, based on (now automated and required) security scans backed by Datree
- Much expanded testing suite, counting hundreds of tests for thousands of features
