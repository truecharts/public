---
slug: "news/clustertool-update"
title: "SCALE Migration Path Update"
authors: [ornias]
date: 2024-06-24
tags:
  - "2024"
---
As previously announced, we will share more detailed information on the road forward for our SCALE users on July 1st. We are well into this work and can finally share some preliminary information ahead of the official announcement.

## Introducing: Talos Linux

Our alternative will be based on Talos, an immutable and lightweight operating system designed to run Kubernetes efficiently. Talos is open-source, production-quality software supported by a reliable and honest company.

Contrary to some reports, Talos is not limited to deployment on virtual machines. It runs excellently on both virtual machines and bare-metal hardware.

Our guides will cover setting up virtual machines, as they are standardized enough for us to ensure accuracy. These guides are already online, validated, and ready to use! Just visit the `docs`, `clustertool`, and `virtual-machines` sections and get started.

## Introducing: ClusterTool

While Talos is a robust system, its default interaction method is quite command-line heavy. We understand that our users may not want to dive into numerous custom CLI commands.

We are excited to introduce our Talos cluster maintenance utility: **ClusterTool**.

ClusterTool simplifies the setup of a functional Kubernetes cluster, whether single or multi-node, into a single command! Additionally, we are incorporating the Kubernetes Dashboard and KubeApps to provide a GUI for managing and installing applications, similar to the SCALE experience.

Thanks to integration with [Talhelper](https://budimanjojo.github.io/talhelper/latest/), all Talos configuration is stored in just two files. Even the most critical configuration elements for your core-cluster components are just a single file edit away!

After setup, the complete cluster is truly yours. You can modify anything you like, including the core components we installed.

ClusterTool also supports SOPS encryption, allowing you to safely store your cluster data anywhere. Beyond all of this, we've even added advanced tools to upgrade and alter your entire Talos cluster with just a single command.

## Migrating from TrueNAS SCALE

ClusterTool will eventually feature automated tooling to migrate all TrueCharts TrueNAS SCALE Apps directly into your new cluster, making the transition seamless. Our current goal is to ensure cluster deployment is rock-solid before introducing migration tooling. Once the ALPHA of ClusterTool is stable, we will prioritize developing reliable migration tools as quickly as possible.

## ClusterTool: Roadmap

ClusterTool is not fully ready yet. Here is the official roadmap (please note that these dates may change without prior notice):

- July 1st: v1.0.0-ALPHA-1
- August 1st: v1.0.0-BETA-1
- September 1st: v1.0.0-RC-1
- October 1st: v1.0.0-RELEASE

**ALPHA**

- Not feature-complete; some minor features may malfunction.
- Only available for testing on throwaway clusters.
- Will not contain any SCALE Migration Tooling.

**BETA**

- Mostly feature-complete with no major changes expected.
- Will include SCALE Migration tooling.
- Suitable for permanent migration, but without guarantees.

**RC**

- Ready for deployment on smaller setups after internal testing.
- No major changes requiring redeployment expected.
- No guarantees, but support will be available where possible.

**RELEASE**

- Ready for full deployment.

## What to Expect on July 1st

Alongside releasing the ALPHA build of ClusterTool, we will provide a more in-depth explanation of our new tooling and its capabilities. Documentation for all ClusterTool features will be up-to-date and well-polished.

Additionally, there will be changes to our support scope, as we will need to be stricter about what is and isn't supported on DIY clusters.

Hang tight and see you on July 1st!
The TrueCharts Team
