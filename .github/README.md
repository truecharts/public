
# TrueCharts:<br>Community App Catalog for TrueNAS SCALE
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/truecharts/dev.svg)](https://github.com/truecharts/truecharts/commits/dev) [![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://github.com/truecharts/truecharts/blob/master/docs/LICENSE.GPLV2) [![License](https://img.shields.io/badge/License-BSD%202--Clause-orange.svg)](https://github.com/truecharts/truecharts/blob/master/docs/LICENSE.BSD2)

Truecharts is an innitiative to provide high quality Apps to use with the TrueNAS SCALE App Ecosystem.
Our primary goals are:
- Freedom
- Stability
- Consistancy

All our apps are supposed to work together, be easy to setup using the TrueNAS UI and, above all, give the average user more than enough options to tune things to their liking.


## Getting started using TrueCharts
Sadly enough, the TrueNAS SCALE UI currently is not usable with anything except the default apps. Due to much of it being hardcoded. None the less, we are already hard at work preparing as many apps as possible, to be ready when UI support drops.


## Getting into creating Apps

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior knowhow on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

The specifications of TrueNAS SCALE apps, is layed out in the [wiki](https://github.com/truecharts/truecharts/wiki/TrueNAS-SCALE-Chart-Structure)



## Licence

Truecharts as a whole, is based on a GPLv2-BSD dual license, this ensures almost everyone can use and modify our charts. However: As a lot of Apps are based on upstream Helm Charts, Licences can be altered on a PR-App basis. This can easily be seen by the presence of a "LICENSE" file in the App rootfolder.
