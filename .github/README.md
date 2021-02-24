# About TrueCharts:<br>
**Community App Catalog for TrueNAS SCALE**

[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/truecharts/master.svg)](https://github.com/truecharts/truecharts/commits) [![License](https://img.shields.io/badge/License-BSD%203--Clause-orange.svg)](https://github.com/truecharts/truecharts/blob/master/docs/LICENSE.BSD3)[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts?ref=badge_shield)
---
Truecharts is an innitiative to provide high quality Apps to use with the TrueNAS SCALE App Ecosystem.
Our primary goals are:
- Freedom
- Stability
- Consistancy

All our apps are supposed to work together, be easy to setup using the TrueNAS UI and, above all, give the average user more than enough options to tune things to their liking.


## Getting started using TrueCharts
Installing TrueCharts within TrueNAS SCALE, still requires the CLI. However it's not hard:
- Go to you shell of choice (either SSH or the TrueNAS webui shell)
- enter `cli`
- enter `app catalog create repository="https://github.com/truecharts/truecharts" label="TrueCharts"`

For more information, please visit our wiki:
https://wiki.truecharts.org

## FAQ

Please refer to our [FAQ](https://wiki.truecharts.org/faq) and Issue tracker before creating an issue.
There is a significant chance your issue has been reported before!

## Getting into creating Apps

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior knowhow on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

## Licence

`SPDX-License-Identifier: BSD-3-Clause`

Truecharts as a whole, is based on a BSD-3-clause  license, this ensures almost everyone can use and modify our charts. However: As a lot of Apps are based on upstream Helm Charts, Licences can vary on a per-App basis. This can easily be seen by the presence of a "LICENSE" file in the App rootfolder.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts?ref=badge_large)

---
![built-with-resentment](http://forthebadge.com/images/badges/built-with-resentment.svg)       ![contains-technical-debt](http://forthebadge.com/images/badges/contains-technical-debt.svg)
