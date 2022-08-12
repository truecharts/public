# Support Policy

TrueCharts aims to always support the lastest version of TrueNAS SCALE.
However, sometimes new versions of either TrueNAS or TrueCharts introduces breaking changes.
This document highlights which versions of TrueCharts (or rather branches), support which versions of TrueNAS SCALE.

We also document which versions of TrueNAS will recieve TrueCharts updates and for which versions we are accepting bug reports.

## Supported Versions

| TrueNAS version  | Branch   | Supported with updates | Accepting Support tickets | Accepting Bugreports | Notes                                                                                                          |
| ---------------- | -------- | ---------------------- | ------------------------- | -------------------- | -------------------------------------------------------------------------------------------------------------- |
| 22.02.2 or prior | `master` | :white_check_mark:     | :x:                       | :x:                  | Adviced to update to 22.02.3 release of [TrueNAS SCALE](https://www.truenas.com/docs/scale/scalereleasenotes/) |
| 22.02.3          | `master` | :white_check_mark:     | :white_check_mark:        | :white_check_mark:   | Most Stable Release as of 2022-08-09                                                                           |
| Nightly          | `master` | :white_check_mark:     | :x:                       | :white_check_mark:   | Please only submit bugreports during codefreeze                                                                |

## Stable Train Charts

We provide direct support for getting `stable` train charts working on our [discord](https://discord.gg/tVsPTHWTtr) inside the **#support** channel. That includes installation and guidance on getting it working with defaults or basic settings (not advanced customisations or remote smb shares, etc). Bug reports aren't accepted on [discord](https://discord.gg/tVsPTHWTtr) so if you spot a bug (all charts in the stable train should work with defaults) please report them to our [github](https://github.com/truecharts/charts/issues/new/choose). Bug reports that state something doesn't work without supporting items may be closed.

## Incubator Train Charts

Our support policy for `incubator` train charts is different for those on the `stable` train. Those charts are work in progress, may break at anytime and we're still going through many of the charts from unRAID. We won't respond to #support tickets on our discord for `incubator` train charts on our [discord](https://discord.gg/tVsPTHWTtr). However we have an **#incubator-chat** channel for these apps to help get them running. Assume anything in the `incubator` train is in beta and you're testing it. As well, anything installed in `incubator` will have to be REINSTALLED once it moves to the `stable` train.

## Specific TrueCharts Support Items (FAQ)

### 1. Checking the Advanced and Expert Networking boxes render your ticket ineligible for standard support. Charts will work with these boxes enabled but the support staff won't help you with your advanced setups, use **#tc-scale-apps**. If you find a bug with those boxes we always accept a report on our [github](https://github.com/truecharts/charts/issues/new/choose)

### 2. If you're using another loadbalancer in front of Traefik or the standard TrueNAS loadbalancer this also falls outside the realm of basic support and your support ticket will be closed

### 3. Certain applications require ingress for **#support** tickets. The current list is below. Failure to use ingress for these charts will render your support ticket closed

- Vaultwarden
- Nextcloud

### 4. We currently advise people to NOT use ACL's for hostpath storage. We cannot guide each user through setting up their ACL's for each chart, apart from a few exceptions user 568 (apps) must have access to their hostpath storage.

### 5. Along with above, we heavily suggest using PVC whenever possible and should be the main way your charts are installed. These PVC's can be mounted using [truetool](https://github.com/truecharts/truetool). User storage for user files can be mounted in the GUI and for certain charts there's specific sections for this storage. The reason for using PVC with charts is the Rollback support on a failed change or update to your chart. No PVC, no GUI rollback inside TrueNAS

### 6. TrueCharts uses [Semantic Versionning](https://semver.org/) on the aspects of the chart that TrueCharts has changed. All charts in `stable` begin at `1.0.0` and increase with updates from the common chart or if the chart is updated. Some chart use latest and/or poor versioning so updates aren't always clear upstream but be sure to check the **CHANGELOG** for each chart before updating. This is especially important for **MAJOR** changes, such as 13.2.1 -> 14.0.0 or if the upstream chart has undergone a major change itself. These are called `Breaking changes` (the semver first digit change). If charts undergo after a `breaking change` we cannot guarante that they will all update properly out of the box, therefore have backups beforehand (Truetool) or making sure the ability to rollback works for your chart. We try to help on a best effort basis, but support will be limited as they are expected to be more-or-less breaking and we cannot control all scenarios.