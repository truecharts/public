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
