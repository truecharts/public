---
hide:
  - navigation
  - toc
---
# TrueCharts<br>
**Community App Catalog for TrueNAS SCALE**

[![docs](https://img.shields.io/badge/docs-rtfm-yellow?logo=gitbook&logoColor=white&style=for-the-badge)](https://truecharts.org/)
[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=for-the-badge)](https://discord.gg/tVsPTHWTtr)
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/apps?color=brightgreen&logoColor=white&style=for-the-badge)](https://github.com/truecharts/apps/commits)

---
TrueCharts is a catalog of highly optimised TrueNAS SCALE Apps. Made for the community, By the community!

Our primary goals are:

- Micro-Service Centered

- Native Kubernetes

- Stability

- Consistency

All our apps are supposed to work together, be easy to setup using the TrueNAS UI and, above all, give the average user more than enough options to tune things to their liking.

<br>

## Getting started using TrueCharts
[![docs](https://img.shields.io/badge/docs-rtfm-yellow?logo=gitbook&logoColor=white&style=for-the-badge)](https://truecharts.org/)

---

Installing TrueCharts within TrueNAS SCALE, is possible using the TrueNAS SCALE Catalog list.

For more information:
https://truecharts.org/manual/Quick-Start%20Guides/02-Adding-TrueCharts/

### Support

Please check our [FAQ](https://truecharts.org/about/), [manual](https://truecharts.org/manual/SUPPORT/) and [Issue tracker](https://github.com/truecharts/apps/issues) There is a significant chance your issue has been reported before!

Still something not working as expected? [Contact us!](https://truecharts.org/about/contact/) and we'll figure it out together!

### Roadmap

For big changes we do have a roadmap, every spot on the roadmap is synced to a TrueNAS SCALE Release and should be read as "Should be added at or before this release"


<br>

**MariaDB and InfluxDB - TrueNAS SCALE "Angelfish" RC2**

_There are many community requested containers that cannot be run using just a postgresql servers, we'll aim to streamline support for a few more dependencies_

<br>

**Documentation and External-DNS - TrueNAS SCALE "Angelfish" RELEASE**

_While preparing for the formal release of TrueNAS SCALE, we still have some things to polish and some improved support for External-DNS to be added_

<br>

**Multi-Pod support for Common - TrueNAS SCALE "Bluefin" 22.xx ALPHA 1**

_Our current common library is not fully supporting with multi-pod containers, while we cannot add everything we should support some basic multi-pod containers on common._

<br>

**Prometheus Support - TrueNAS SCALE "Bluefin" 22.xx ALPHA 2**

_By this date it would be about a year after we first started considering adding Prometheus support, it's time to get it done._

<br>

**Mail server - TrueNAS SCALE "Bluefin" 22.xx BETA 1**

_Great mail-server deployments require support for multi-pod containers, high availability and a solid backend. By this date, all those boxes should start to become checked and we should check the "mail server" box as well_

<br>

## Development
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)
[![renovate](https://img.shields.io/badge/renovate-enabled-brightgreen?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjUgNSAzNzAgMzcwIj48Y2lyY2xlIGN4PSIxODkiIGN5PSIxOTAiIHI9IjE4NCIgZmlsbD0iI2ZlMiIvPjxwYXRoIGZpbGw9IiM4YmIiIGQ9Ik0yNTEgMjU2bC0zOC0zOGExNyAxNyAwIDAxMC0yNGw1Ni01NmMyLTIgMi02IDAtN2wtMjAtMjFhNSA1IDAgMDAtNyAwbC0xMyAxMi05LTggMTMtMTNhMTcgMTcgMCAwMTI0IDBsMjEgMjFjNyA3IDcgMTcgMCAyNGwtNTYgNTdhNSA1IDAgMDAwIDdsMzggMzh6Ii8+PHBhdGggZmlsbD0iI2Q1MSIgZD0iTTMwMCAyODhsLTggOGMtNCA0LTExIDQtMTYgMGwtNDYtNDZjLTUtNS01LTEyIDAtMTZsOC04YzQtNCAxMS00IDE1IDBsNDcgNDdjNCA0IDQgMTEgMCAxNXoiLz48cGF0aCBmaWxsPSIjYjMwIiBkPSJNMjg1IDI1OGw3IDdjNCA0IDQgMTEgMCAxNWwtOCA4Yy00IDQtMTEgNC0xNiAwbC02LTdjNCA1IDExIDUgMTUgMGw4LTdjNC01IDQtMTIgMC0xNnoiLz48cGF0aCBmaWxsPSIjYTMwIiBkPSJNMjkxIDI2NGw4IDhjNCA0IDQgMTEgMCAxNmwtOCA3Yy00IDUtMTEgNS0xNSAwbC05LThjNSA1IDEyIDUgMTYgMGw4LThjNC00IDQtMTEgMC0xNXoiLz48cGF0aCBmaWxsPSIjZTYyIiBkPSJNMjYwIDIzM2wtNC00Yy02LTYtMTctNi0yMyAwLTcgNy03IDE3IDAgMjRsNCA0Yy00LTUtNC0xMSAwLTE2bDgtOGM0LTQgMTEtNCAxNSAweiIvPjxwYXRoIGZpbGw9IiNiNDAiIGQ9Ik0yODQgMzA0Yy00IDAtOC0xLTExLTRsLTQ3LTQ3Yy02LTYtNi0xNiAwLTIybDgtOGM2LTYgMTYtNiAyMiAwbDQ3IDQ2YzYgNyA2IDE3IDAgMjNsLTggOGMtMyAzLTcgNC0xMSA0em0tMzktNzZjLTEgMC0zIDAtNCAybC04IDdjLTIgMy0yIDcgMCA5bDQ3IDQ3YTYgNiAwIDAwOSAwbDctOGMzLTIgMy02IDAtOWwtNDYtNDZjLTItMi0zLTItNS0yeiIvPjxwYXRoIGZpbGw9IiMxY2MiIGQ9Ik0xNTIgMTEzbDE4LTE4IDE4IDE4LTE4IDE4em0xLTM1bDE4LTE4IDE4IDE4LTE4IDE4em0tOTAgODlsMTgtMTggMTggMTgtMTggMTh6bTM1LTM2bDE4LTE4IDE4IDE4LTE4IDE4eiIvPjxwYXRoIGZpbGw9IiMxZGQiIGQ9Ik0xMzQgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em0tMzUgMzZsMTgtMTggMTggMTgtMTggMTh6Ii8+PHBhdGggZmlsbD0iIzJiYiIgZD0iTTExNiAxNDlsMTgtMTggMTggMTgtMTggMTh6bTU0LTU0bDE4LTE4IDE4IDE4LTE4IDE4em0tODkgOTBsMTgtMTggMTggMTgtMTggMTh6bTEzOS04NWwyMyAyM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTI0LTI0Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS01IDEyLTUgMTYgMHoiLz48cGF0aCBmaWxsPSIjM2VlIiBkPSJNMTM0IDk1bDE4LTE4IDE4IDE4LTE4IDE4em0tNTQgMThsMTgtMTcgMTggMTctMTggMTh6bTU1LTUzbDE4LTE4IDE4IDE4LTE4IDE4em05MyA0OGwtOC04Yy00LTUtMTEtNS0xNiAwTDEwMyAyMDFjLTQgNC00IDExIDAgMTVsOCA4Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS00IDEyLTQgMTYgMHoiLz48cGF0aCBmaWxsPSIjOWVlIiBkPSJNMjcgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em01NC01M2wxOC0xOCAxOCAxOC0xOCAxOHoiLz48cGF0aCBmaWxsPSIjMGFhIiBkPSJNMjMwIDExMGwxMyAxM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTEzLTEzYzQgNCAxMSA0IDE1IDBsMTAxLTEwMWM1LTUgNS0xMSAwLTE2eiIvPjxwYXRoIGZpbGw9IiMxYWIiIGQ9Ik0xMzQgMjQ4Yy00IDAtOC0yLTExLTVsLTIzLTIzYTE2IDE2IDAgMDEwLTIzTDIwMSA5NmExNiAxNiAwIDAxMjIgMGwyNCAyNGM2IDYgNiAxNiAwIDIyTDE0NiAyNDNjLTMgMy03IDUtMTIgNXptNzgtMTQ3bC00IDItMTAxIDEwMWE2IDYgMCAwMDAgOWwyMyAyM2E2IDYgMCAwMDkgMGwxMDEtMTAxYTYgNiAwIDAwMC05bC0yNC0yMy00LTJ6Ii8+PC9zdmc+)](https://github.com/renovatebot/renovate)
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/apps?color=brightgreen&logoColor=white&style=for-the-badge)](https://github.com/truecharts/apps/commits)

---

Our development process is fully distributed and agile, so every chart-maintainer is free to set their own roadmap and development speed and does not have to comply to a centralised roadmap.
This ensures freedom and flexibility for everyone involved and makes sure you, the end user, always has the latest and greatest of every App installed.


### Getting into creating Apps

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior know-how on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

For more information on creating SCALE Apps and Helm charts, please check out our [development manual](https://truecharts.org/)

### Automation and you

We provide a lot of tools to make it easier to develop charts, templates, automated testing, automated fixes, automated docs. Even automated update is included. We also actively try to collaborate with other k8s community projects on tooling, for the betterment of all!

Those tools do, however, take time to develop and are certainly not bug free. If you find mistakes in our tooling, please feel free to repost issues or submit any fixes you feel appropriate!

<br>


## Contact and Support
[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=for-the-badge)](https://discord.gg/tVsPTHWTtr)

---

To contact the TrueCharts project:

- Create an issue on [Github issues](https://github.com/truecharts/apps/issues)

- Open a discussion on [GitHub Discussions](https://github.com/truecharts/apps/discussions)

- Send us an [email](mailto://info@truecharts.org)

- Or [join our Discord server](https://truecharts.org/discord)

<br>

<iframe src="https://discord.com/widget?id=830763548678291466&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe>

<br>


## Featured Projects

A lot of our work is based on the great effort of others. We would love to extend special thanks to these projects we owe a lot to:

| <a href="https://www.truenas.com/truenas-scale/"> <img src="https://user-images.githubusercontent.com/7613738/113836934-a1764e00-978d-11eb-8e19-a087c5c1f99b.png" width="150" height="150" /> </a> | <a href="https://k8s-at-home.com/"> <img src="https://user-images.githubusercontent.com/7613738/113837194-e26e6280-978d-11eb-9632-2e1529946302.png" width="150" height="150" /> </a> | <a href="https://traefik.io/traefik/"> <img src="https://user-images.githubusercontent.com/7613738/113837353-0b8ef300-978e-11eb-873e-14769acfe1f1.png" width="150" height="150" /> </a> | <a href="https://www.authelia.com/"> <img src="https://avatars.githubusercontent.com/u/59122411?s=200&v=4" width="150" height="150" /> </a> |
| :---------------: | :---------------: | :---------------: | :---------------: |
| <a href="https://www.truenas.com/truenas-scale/">TrueNAS SCALE</a> |  <a href="https://k8s-at-home.com/">K8S-At-Home</a> | <a href="https://traefik.io/traefik/">Traefik</a> | <a href="https://www.authelia.com/">Authelia</a> |

<br>


## Contributors ✨

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-14-orange.svg?style=for-the-badge)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

---

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="http://schouten-lebbing.nl"><img src="https://avatars.githubusercontent.com/u/7613738?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Kjeld Schouten-Lebbing</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=Ornias1993" title="Code">💻</a> <a href="#infra-Ornias1993" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/truecharts/apps/commits?author=Ornias1993" title="Documentation">📖</a></td>
    <td align="center"><a href="http://sqlitebrowser.org"><img src="https://avatars.githubusercontent.com/u/406299?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Justin Clift</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=justinclift" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/whiskerz007"><img src="https://avatars.githubusercontent.com/u/2713522?v=4?s=100" width="100px;" alt=""/><br /><sub><b>whiskerz007</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=whiskerz007" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/stavros-k"><img src="https://avatars.githubusercontent.com/u/47820033?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Stavros Kois</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=stavros-k" title="Code">💻</a> <a href="https://github.com/truecharts/apps/commits?author=stavros-k" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/allen-4"><img src="https://avatars.githubusercontent.com/u/65494904?v=4?s=100" width="100px;" alt=""/><br /><sub><b>allen-4</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=allen-4" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/tprelog"><img src="https://avatars.githubusercontent.com/u/35702532?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Troy Prelog</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=tprelog" title="Code">💻</a> <a href="https://github.com/truecharts/apps/commits?author=tprelog" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/djs52"><img src="https://avatars.githubusercontent.com/u/1466018?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Dan Sheridan</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=djs52" title="Code">💻</a></td>
  </tr>
  <tr>
    <td align="center"><a href="https://www.cetic.be/Sebastien-Dupont?lang=en"><img src="https://avatars.githubusercontent.com/u/2684865?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Sebastien Dupont</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=banzo" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/angelnu"><img src="https://avatars.githubusercontent.com/u/4406403?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Vegetto</b></sub></a><br /><a href="https://github.com/truecharts/apps/pulls?q=is%3Apr+reviewed-by%3Aangelnu" title="Reviewed Pull Requests">👀</a></td>
    <td align="center"><a href="http://nieuwdorp.me"><img src="https://avatars.githubusercontent.com/u/12896549?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Luuk Nieuwdorp</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=luuknieuwdorp" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/natewalck"><img src="https://avatars.githubusercontent.com/u/867868?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Nate Walck</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=natewalck" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/warllo54"><img src="https://avatars.githubusercontent.com/u/20650065?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Lloyd</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=warllo54" title="Code">💻</a></td>
    <td align="center"><a href="https://github.com/dwithnall"><img src="https://avatars.githubusercontent.com/u/5699800?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Dave Withnall</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=dwithnall" title="Documentation">📖</a></td>
    <td align="center"><a href="https://github.com/ksimm1"><img src="https://avatars.githubusercontent.com/u/1334526?v=4?s=100" width="100px;" alt=""/><br /><sub><b>ksimm1</b></sub></a><br /><a href="https://github.com/truecharts/apps/commits?author=ksimm1" title="Documentation">📖</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!



## Licence
[![License](https://img.shields.io/badge/License-BSD%203--Clause-orange.svg?style=for-the-badge)](https://github.com/truecharts/apps/blob/master/docs/LICENSE.BSD3)

---

Truecharts as a whole, is based on a BSD-3-clause  license, this ensures almost everyone can use and modify our charts. However: As a lot of Apps are based on upstream Helm Charts, Licences can vary on a per-App basis. This can easily be seen by the presence of a "LICENSE" file in the App root folder.

Some Apps may also contain parts in other licenses, such as libraries or templates, these files can be recognised by their individual headers.


`SPDX-License-Identifier: BSD-3-Clause`

---
![built-with-resentment](http://forthebadge.com/images/badges/built-with-resentment.svg)       ![contains-technical-debt](http://forthebadge.com/images/badges/contains-technical-debt.svg)
