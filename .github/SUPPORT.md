---
title: Support Policy
sidebar_position: 3
---

## TrueCharts on TrueNAS SCALE

TrueCharts aims to always support the latest version of TrueNAS SCALE.
However, sometimes new versions of either TrueNAS or TrueCharts introduces breaking changes.
This document highlights which versions of TrueCharts (or rather branches), support which versions of TrueNAS SCALE.

We also document which versions of TrueNAS will receive TrueCharts updates and for which versions we are accepting bug reports.

### Supported Versions of TrueNAS SCALE

| TrueNAS version    | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes                                                                                          |
| ------------------ | -------- | ---------------------- | ------------------------- | --------------------- | ---------------------------------------------------------------------------------------------- |
| 22.12.4.2 or prior | `master` | :x:                    | :x:                       | :x:                   | Update to 23.10.X Supported Version [TrueNAS SCALE](https://www.truenas.com/docs/scale/23.10/) |
| 23.10.0.1          | `master` | :white_check_mark:     | :x:                       | :x:                   | Update to 23.10.1 [TrueNAS SCALE](https://www.truenas.com/docs/scale/23.10/)                   |
| 23.10.1            | `master` | :white_check_mark:     | :white_check_mark:        | :white_check_mark:    | Stable Release as of 2023-12-19                                                                |
| Nightly            | `master` | :white_check_mark:     | :x:                       | :white_check_mark:    | Please only submit bug reports during code-freeze                                              |

## TrueCharts on Talos-OS

Support for Talos-OS with either Rancher or FluxCD are in early alpha.

### Supported Versions of Talos-OS

| Talos-OS version | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| ---------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 1.5              | `master` | :white_check_mark:     | :x:                       | :x:                   |       |
| 1.6              | `master` | :white_check_mark:     | :x:                       | :x:                   |       |

### Supported Versions of FluxCD

| FluxCD version | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| -------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| 1.2.1 or prior | `master` | :white_check_mark:     | :x:                       | :x:                   |       |

### Rancher Versions of Rancher

| TrueNAS version | Branch   | Supported with updates | Accepting Support tickets | Accepting Bug Reports | Notes |
| --------------- | -------- | ---------------------- | ------------------------- | --------------------- | ----- |
| v2.7.9 or prior | `master` | :white_check_mark:     | :x:                       | :x:                   |       |

:::caution[Support Guidelines]

Our [Discord](https://discord.gg/tVsPTHWTtr) support (the ticketing system inside #support) is primarily limited to what is covered by our written guides. This includes installing, linking and editing apps. This doesn't mean the actual setup of the application. All #support tickets covered by the staff are done so in a **best effort** policy.

:::

## Stable Train Charts

We provide direct support for getting `stable` train charts working on our [discord](https://discord.gg/tVsPTHWTtr) inside the **#support** channel.
That includes installation and guidance on getting it working with defaults or basic settings (not advanced customizations or remote smb shares, etc).
Bug reports aren't accepted on [discord](https://discord.gg/tVsPTHWTtr) so if you spot a bug (Charts in the stable train should work with mostly defaults configuration)
please report them to our [github](https://github.com/truecharts/charts/issues/new/choose). Bug reports that state something doesn't work without supporting items may be closed.

## Incubator Train Charts

Our support policy for `incubator` train charts is different for those on the `stable` train. Those charts are work in progress,
may break at anytime and we're still going through many of the charts from unRAID. We won't accept support tickets for `incubator` train
charts on our [discord](https://discord.gg/tVsPTHWTtr). However, we have an **#incubator-chat** channel for these apps to help get them running and/or receive feedback.
With enough positive feedback a chart can be promoted to `stable` train. Feedback about bugs is also accepted there which can be used to fix them.
Assume anything in the `incubator` train is in beta and you're testing it. As well, anything installed in `incubator` will have to be REINSTALLED once it moves to the `stable` train.
