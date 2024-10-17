---
slug: "news/updates-recontinued"
title: "Updates recontinued, common-migration mostly done"
authors: [ornias]
date: 2023-05-01
tags:
  - "2023"
---

We're glad to finally announce the end of our code-freeze. Since a few days we've re-enabled our automatic updates and within a few weeks everything should balance out again automatically!

At the same time, we've not completely finished porting _all_ stable-train charts to the new common, 65 are still missing. But we've clearly label those updates as breaking in the changelog when they come in.
Most of those are charts that have more complications than anticipated, so need a little quality time with our maintainers which takes a while.

### Known Issues

Now that we're mostly done, we also need to report a few known issues with the new backend:

1. **DO NOT USE THE STOP BUTTON**

The Stop button should **not** be used on any TrueNAS SCALE Apps that uses postgreSQL. Due to severe design mistakes by iXsystems, it will get into an endless loop and never finish. We're reported the issue to iXsystems and they are not interested in fixing this.

2. PostgreSQL breaking on reboot

We've seen some edge cases where the new database backend breaks after a reboot. Often after the STOP button was used, though we cannot trace the issue down back to the use of the stop button itself.
These issues are reported to the folks over at CNPG and we've also thrown them an email to discuss whether we can fund them to fix these issues.

3. hostNetworking changes

After much R&D, our staff have discovered quite a few nasty kubernetes-level bugs with hostNetworking. As a result, we've decided to never enable it by default anymore on any of our charts/apps, as we cannot guarantee its stability.
For some charts that, often, require this setting (like tailscale), users would have to manually and explicitly enable it from now on.

The setting has also moved in the GUI.

4. Deprecated certificate system and you

With most Charts ported, we want to highlight the fact that the "TrueNAS SCALE (Deprecated)" certificate option, should _not_ be used anymore.
We cannot guarantee it's stability nor can do anything at-all to help out. It will also be removed as an option in the future, though that will be months rather than weeks.

### The future

With the charts slowly all being ported, we can start working on our long-term plans again.
One of those plans is a renewed focus on native Helm Charts.

For May and June, we're planning to go all-in on improving documentation for use of our charts as normal Helm charts.
At the same time we're going to work on ensuring all our SCALE specific tricks (of which only a few are left, luckily), will have automatic alternatives for normal kubernetes clusters.

To highlight this, we've asked Artifact hub, to highlight our Common-Library chart, as an "official" TrueCharts Helm chart.
All users of helm should be able to use the power of this advanced common-library, to build the Helm Charts they please... Without even relying on TrueCharts to host their charts for them!

Check it out [here](https://artifacthub.io/packages/helm/truecharts-library-charts/common) and also check out the [docs](/common/) as always.
