---
sidebar:
  order: 2
title: genconfig
---

:::caution[Work In Progress]

This program, all its features and its general design, are all a Work-In-Progress. It is not done and not widely available.

All code and docs are considered Pre-Beta drafts

:::

After all your settings are entered into talconfig.yaml and clusterenv.yaml, Clustertool generates a complete clusterconfiguration using TalHelper and various other tools.

It's important to note that running `clustertool genconfig`, again after each settings change, is absolutely imperative to be able to deploy said settings to your cluster.

This does not only generate the Talos "Machine Config" files, but also ensures an updated configmap containing your "clusterenv.yaml" settings, is added to the /manifests/ directory, for consumption by FluxCD when added.
It also ensures the same configmap is always added by updating the patches.
