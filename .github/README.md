
# TrueCharts:<br>Community App Catalog for TrueNAS SCALE
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/truecharts/master.svg)](https://github.com/truecharts/truecharts/commits) [![License](https://img.shields.io/badge/License-BSD%203--Clause-orange.svg)](https://github.com/truecharts/truecharts/blob/master/docs/LICENSE.BSD3)[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts?ref=badge_shield)

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
- Q: I tried to run TrueCharts on TrueNAS SCALE 20.12 and it doesn't work.
A: TrueNAS SCALE 20.12 has never supported custom charts in any way, shape or form. Hence TrueCharts is 21.02+ only

- Q: Please include app X<br>
A: Please file an issue about it, after checking the wiki to make sure it hasn't been discussed already:
https://github.com/truecharts/truecharts/wiki/k8s-at-home-to-SCALE-App-migration-list

- Q: Isn't there more documentation for app x<br>
A: No, currently during TrueNAS SCALE ALPHA/BETA we focus on the technical aspects. 

- Q: Function x doesn't seem to be working, should it be working?<br>
A: Maybe, please file an issue

- Q: I'm missing a lot of configuration opions in the install GUI.<br>
A: We try to aim for a balance in the amount of options vs the simplicity of installation. Suggestions are always welcome

- Q: The portal button isn't working.<br>
A: Portal buttons are current't not implemented very well and are considered "not supported" for the time being

- Q: I selected letsencrypt but still get a traefik certificate.<br>
A: Cert Manager might take up to 10 minutes to fetch the right certificate and requires free access to 1.1.1.1:53. Until the right certificate is fetched, it will use the Traefik Default cert.

- Q: Is my data guaranteed to be secure?<br>
A: ix_volumes (the auto generated storage) is considered relatively secure as long as you don't delete the App, but we can't give an absolute guarantee. data mounted using a hostPath, is as secure as the application that is using the data, our charts do not actively alter said dataset/folder. However: SCALE is still ALPHA, so breaking changes in the storage design are very likely.

- Q: sabnzbd isn't starting.<br>
A: SabNZBD has a weird security implementation that requires you to add the hostname or IP adress to their config file. In the future we might automate this proces, but currently we do not.

- Q: An app is asking for a password.<br>
A: We almost allways use the defaults from the upstream project, if we are forced to use a password and not add the option to change it in the install GUI.

## Getting into creating Apps

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior knowhow on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

The specifications of TrueNAS SCALE apps, is layed out in the [wiki](https://github.com/truecharts/truecharts/wiki/TrueNAS-SCALE-Chart-Structure)


## Licence

`SPDX-License-Identifier: BSD-3-Clause`

Truecharts as a whole, is based on a BSD-3-clause  license, this ensures almost everyone can use and modify our charts. However: As a lot of Apps are based on upstream Helm Charts, Licences can vary on a per-App basis. This can easily be seen by the presence of a "LICENSE" file in the App rootfolder.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts?ref=badge_large)
