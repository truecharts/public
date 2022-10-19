# TrueCharts

**Community Chart Catalog for TrueNAS SCALE**

[![docs](https://img.shields.io/badge/docs-rtfm-yellow?logo=gitbook&logoColor=white&style=for-the-badge)](https://truecharts.org/)
[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=for-the-badge)](https://discord.gg/Js6xv9nGuU)
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/charts?color=brightgreen&logoColor=white&style=for-the-badge)](https://github.com/truecharts/charts/commits)

---

TrueCharts is a catalog of highly optimised TrueNAS SCALE Charts. Made for the community, By the community!

Our primary goals are:

- Micro-Service Centered

- Native Kubernetes

- Stability

- Consistency

All our charts are supposed to work together, be easy to setup using the TrueNAS UI and, above all, give the average user more than enough options to tune things to their liking.

<br />

## Getting started using TrueCharts

[![docs](https://img.shields.io/badge/docs-rtfm-yellow?logo=gitbook&logoColor=white&style=for-the-badge)](https://truecharts.org/)

---

Installing TrueCharts within TrueNAS SCALE, is possible using the TrueNAS SCALE Catalog list.

Check TrueCharts [Quick-Start Guides](https://truecharts.org/docs/manual/SCALE%20Apps/Adding-TrueCharts) for more information.

### Support

Please check our [FAQ](https://truecharts.org/docs/about/intro), [manual](https://truecharts.org/docs/manual/SUPPORT/) and [Issue tracker](https://github.com/truecharts/charts/issues) There is a significant chance your issue has been reported before!

Still something not working as expected? [Contact us!](https://truecharts.org/docs/about/contact/) and we'll figure it out together!

### Roadmap

For big changes we do have a roadmap, every spot on the roadmap is synced to a TrueNAS SCALE Release and should be read as "Should be added at or before this release"

<br />

**Restructure of the Project - TrueNAS SCALE "Bluefin" 22.xx ALPHA 1**

_The current project is hitting internal performance issues, for this reason we need to rework the structure and split some parts of the project into seperate repositories._

<br />

**Refactor the Common Chart - TrueNAS SCALE "Bluefin" 22.xx ALPHA 2**

_The shared Common (chart) basis, used by all our Charts, needs some significant code cleanup. Primarily all code needs to follow a standardised format and comply to the same standard_

<br />

**Increased test coverage - TrueNAS SCALE "Bluefin" 22.xx BETA 1**

_With most parts of our project somewhat cleaned up, we need to work on increasing the coverage of our test system. Our unittests should cover all features and we should also take upgrades into account when testing Chart changes_

<br />

## Development

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)
[![renovate](https://img.shields.io/badge/renovate-enabled-brightgreen?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjUgNSAzNzAgMzcwIj48Y2lyY2xlIGN4PSIxODkiIGN5PSIxOTAiIHI9IjE4NCIgZmlsbD0iI2ZlMiIvPjxwYXRoIGZpbGw9IiM4YmIiIGQ9Ik0yNTEgMjU2bC0zOC0zOGExNyAxNyAwIDAxMC0yNGw1Ni01NmMyLTIgMi02IDAtN2wtMjAtMjFhNSA1IDAgMDAtNyAwbC0xMyAxMi05LTggMTMtMTNhMTcgMTcgMCAwMTI0IDBsMjEgMjFjNyA3IDcgMTcgMCAyNGwtNTYgNTdhNSA1IDAgMDAwIDdsMzggMzh6Ii8+PHBhdGggZmlsbD0iI2Q1MSIgZD0iTTMwMCAyODhsLTggOGMtNCA0LTExIDQtMTYgMGwtNDYtNDZjLTUtNS01LTEyIDAtMTZsOC04YzQtNCAxMS00IDE1IDBsNDcgNDdjNCA0IDQgMTEgMCAxNXoiLz48cGF0aCBmaWxsPSIjYjMwIiBkPSJNMjg1IDI1OGw3IDdjNCA0IDQgMTEgMCAxNWwtOCA4Yy00IDQtMTEgNC0xNiAwbC02LTdjNCA1IDExIDUgMTUgMGw4LTdjNC01IDQtMTIgMC0xNnoiLz48cGF0aCBmaWxsPSIjYTMwIiBkPSJNMjkxIDI2NGw4IDhjNCA0IDQgMTEgMCAxNmwtOCA3Yy00IDUtMTEgNS0xNSAwbC05LThjNSA1IDEyIDUgMTYgMGw4LThjNC00IDQtMTEgMC0xNXoiLz48cGF0aCBmaWxsPSIjZTYyIiBkPSJNMjYwIDIzM2wtNC00Yy02LTYtMTctNi0yMyAwLTcgNy03IDE3IDAgMjRsNCA0Yy00LTUtNC0xMSAwLTE2bDgtOGM0LTQgMTEtNCAxNSAweiIvPjxwYXRoIGZpbGw9IiNiNDAiIGQ9Ik0yODQgMzA0Yy00IDAtOC0xLTExLTRsLTQ3LTQ3Yy02LTYtNi0xNiAwLTIybDgtOGM2LTYgMTYtNiAyMiAwbDQ3IDQ2YzYgNyA2IDE3IDAgMjNsLTggOGMtMyAzLTcgNC0xMSA0em0tMzktNzZjLTEgMC0zIDAtNCAybC04IDdjLTIgMy0yIDcgMCA5bDQ3IDQ3YTYgNiAwIDAwOSAwbDctOGMzLTIgMy02IDAtOWwtNDYtNDZjLTItMi0zLTItNS0yeiIvPjxwYXRoIGZpbGw9IiMxY2MiIGQ9Ik0xNTIgMTEzbDE4LTE4IDE4IDE4LTE4IDE4em0xLTM1bDE4LTE4IDE4IDE4LTE4IDE4em0tOTAgODlsMTgtMTggMTggMTgtMTggMTh6bTM1LTM2bDE4LTE4IDE4IDE4LTE4IDE4eiIvPjxwYXRoIGZpbGw9IiMxZGQiIGQ9Ik0xMzQgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em0tMzUgMzZsMTgtMTggMTggMTgtMTggMTh6Ii8+PHBhdGggZmlsbD0iIzJiYiIgZD0iTTExNiAxNDlsMTgtMTggMTggMTgtMTggMTh6bTU0LTU0bDE4LTE4IDE4IDE4LTE4IDE4em0tODkgOTBsMTgtMTggMTggMTgtMTggMTh6bTEzOS04NWwyMyAyM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTI0LTI0Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS01IDEyLTUgMTYgMHoiLz48cGF0aCBmaWxsPSIjM2VlIiBkPSJNMTM0IDk1bDE4LTE4IDE4IDE4LTE4IDE4em0tNTQgMThsMTgtMTcgMTggMTctMTggMTh6bTU1LTUzbDE4LTE4IDE4IDE4LTE4IDE4em05MyA0OGwtOC04Yy00LTUtMTEtNS0xNiAwTDEwMyAyMDFjLTQgNC00IDExIDAgMTVsOCA4Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS00IDEyLTQgMTYgMHoiLz48cGF0aCBmaWxsPSIjOWVlIiBkPSJNMjcgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em01NC01M2wxOC0xOCAxOCAxOC0xOCAxOHoiLz48cGF0aCBmaWxsPSIjMGFhIiBkPSJNMjMwIDExMGwxMyAxM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTEzLTEzYzQgNCAxMSA0IDE1IDBsMTAxLTEwMWM1LTUgNS0xMSAwLTE2eiIvPjxwYXRoIGZpbGw9IiMxYWIiIGQ9Ik0xMzQgMjQ4Yy00IDAtOC0yLTExLTVsLTIzLTIzYTE2IDE2IDAgMDEwLTIzTDIwMSA5NmExNiAxNiAwIDAxMjIgMGwyNCAyNGM2IDYgNiAxNiAwIDIyTDE0NiAyNDNjLTMgMy03IDUtMTIgNXptNzgtMTQ3bC00IDItMTAxIDEwMWE2IDYgMCAwMDAgOWwyMyAyM2E2IDYgMCAwMDkgMGwxMDEtMTAxYTYgNiAwIDAwMC05bC0yNC0yMy00LTJ6Ii8+PC9zdmc+)](https://github.com/renovatebot/renovate)
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/charts?color=brightgreen&logoColor=white&style=for-the-badge)](https://github.com/truecharts/charts/commits)

---

Our development process is fully distributed and agile, so every chart-maintainer is free to set their own roadmap and development speed and does not have to comply to a centralised roadmap.
This ensures freedom and flexibility for everyone involved and makes sure you, the end user, always has the latest and greatest of every Chart installed.

### Getting into creating Charts

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior know-how on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

For more information on creating SCALE Apps and Helm charts, please check out our [development manual](https://truecharts.org/docs/manual/development/License-headers)

### Automation and you

We provide a lot of tools to make it easier to develop charts, templates, automated testing, automated fixes, automated docs. Even automated update is included. We also actively try to collaborate with other k8s community projects on tooling, for the betterment of all!

Those tools do, however, take time to develop and are certainly not bug free. If you find mistakes in our tooling, please feel free to repost issues or submit any fixes you feel appropriate!

<br />

## Contact and Support

[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=for-the-badge)](https://discord.gg/tVsPTHWTtr)

---

To contact the TrueCharts project:

- Create an issue on [Github issues](https://github.com/truecharts/charts/issues)

- Open a [Support Ticket](https://discord.com/channels/830763548678291466/936275413179723826)

- Send us an [email](mailto://info@truecharts.org)

- Or [join our Discord server](https://discord.gg/tVsPTHWTtr)

<br />

<!-- INSERT-DISCORD-WIDGET -->

<br />

## Featured Projects

A lot of our work is based on the great effort of others. We would love to extend special thanks to these projects we owe a lot to:

| <a href="https://www.truenas.com/truenas-scale/"> <img src="https://user-images.githubusercontent.com/7613738/113836934-a1764e00-978d-11eb-8e19-a087c5c1f99b.png" width="150" height="150" /> </a> | <a href="https://k8s-at-home.com/"> <img src="https://user-images.githubusercontent.com/7613738/113837194-e26e6280-978d-11eb-9632-2e1529946302.png" width="150" height="150" /> </a> | <a href="https://traefik.io/traefik/"> <img src="https://user-images.githubusercontent.com/7613738/113837353-0b8ef300-978e-11eb-873e-14769acfe1f1.png" width="150" height="150" /> </a> | <a href="https://www.authelia.com/"> <img src="https://avatars.githubusercontent.com/u/59122411?s=200&v=4" width="150" height="150" /> </a> |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-----------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                 <a href="https://www.truenas.com/truenas-scale/">TrueNAS SCALE</a>                                                                 |                                                                  <a href="https://k8s-at-home.com/">K8S-At-Home</a>                                                                  |                                                                    <a href="https://traefik.io/traefik/">Traefik</a>                                                                    |                                              <a href="https://www.authelia.com/">Authelia</a>                                               |

<br />

## Contributors ✨

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-125-orange.svg?style=for-the-badge)](#contributors)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

---

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center"><a href="http://schouten-lebbing.nl"><img src="https://avatars.githubusercontent.com/u/7613738?v=4?s=100" width="100px;" alt="Kjeld Schouten-Lebbing"/><br /><sub><b>Kjeld Schouten-Lebbing</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=Ornias1993" title="Code">💻</a> <a href="#infra-Ornias1993" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a> <a href="https://github.com/truecharts/charts/commits?author=Ornias1993" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/pulls?q=is%3Apr+reviewed-by%3AOrnias1993" title="Reviewed Pull Requests">👀</a> <a href="#financial-Ornias1993" title="Financial">💵</a></td>
      <td align="center"><a href="http://sqlitebrowser.org"><img src="https://avatars.githubusercontent.com/u/406299?v=4?s=100" width="100px;" alt="Justin Clift"/><br /><sub><b>Justin Clift</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=justinclift" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/whiskerz007"><img src="https://avatars.githubusercontent.com/u/2713522?v=4?s=100" width="100px;" alt="whiskerz007"/><br /><sub><b>whiskerz007</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=whiskerz007" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/stavros-k"><img src="https://avatars.githubusercontent.com/u/47820033?v=4?s=100" width="100px;" alt="Stavros Kois"/><br /><sub><b>Stavros Kois</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=stavros-k" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=stavros-k" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Astavros-k" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/pulls?q=is%3Apr+reviewed-by%3Astavros-k" title="Reviewed Pull Requests">👀</a> <a href="#financial-stavros-k" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/allen-4"><img src="https://avatars.githubusercontent.com/u/65494904?v=4?s=100" width="100px;" alt="allen-4"/><br /><sub><b>allen-4</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=allen-4" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/tprelog"><img src="https://avatars.githubusercontent.com/u/35702532?v=4?s=100" width="100px;" alt="Troy Prelog"/><br /><sub><b>Troy Prelog</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=tprelog" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=tprelog" title="Documentation">📖</a> <a href="#financial-tprelog" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/djs52"><img src="https://avatars.githubusercontent.com/u/1466018?v=4?s=100" width="100px;" alt="Dan Sheridan"/><br /><sub><b>Dan Sheridan</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=djs52" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://www.cetic.be/Sebastien-Dupont?lang=en"><img src="https://avatars.githubusercontent.com/u/2684865?v=4?s=100" width="100px;" alt="Sebastien Dupont"/><br /><sub><b>Sebastien Dupont</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=banzo" title="Documentation">📖</a> <a href="#financial-banzo" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/angelnu"><img src="https://avatars.githubusercontent.com/u/4406403?v=4?s=100" width="100px;" alt="Vegetto"/><br /><sub><b>Vegetto</b></sub></a><br /><a href="https://github.com/truecharts/charts/pulls?q=is%3Apr+reviewed-by%3Aangelnu" title="Reviewed Pull Requests">👀</a></td>
      <td align="center"><a href="https://github.com/ellienieuwdorp"><img src="https://avatars.githubusercontent.com/u/12896549?v=4?s=100" width="100px;" alt="Ellie Nieuwdorp"/><br /><sub><b>Ellie Nieuwdorp</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=ellienieuwdorp" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/natewalck"><img src="https://avatars.githubusercontent.com/u/867868?v=4?s=100" width="100px;" alt="Nate Walck"/><br /><sub><b>Nate Walck</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=natewalck" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/warllo54"><img src="https://avatars.githubusercontent.com/u/20650065?v=4?s=100" width="100px;" alt="Lloyd"/><br /><sub><b>Lloyd</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=warllo54" title="Code">💻</a> <a href="#financial-warllo54" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/dwithnall"><img src="https://avatars.githubusercontent.com/u/5699800?v=4?s=100" width="100px;" alt="Dave Withnall"/><br /><sub><b>Dave Withnall</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=dwithnall" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/ksimm1"><img src="https://avatars.githubusercontent.com/u/1334526?v=4?s=100" width="100px;" alt="ksimm1"/><br /><sub><b>ksimm1</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=ksimm1" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Aksimm1" title="Bug reports">🐛</a> <a href="#financial-ksimm1" title="Financial">💵</a> <a href="#mentoring-ksimm1" title="Mentoring">🧑‍🏫</a></td>
    </tr>
    <tr>
      <td align="center"><a href="http://aaronjohnson.io"><img src="https://avatars.githubusercontent.com/u/1386238?v=4?s=100" width="100px;" alt="Aaron Johnson"/><br /><sub><b>Aaron Johnson</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=acjohnson" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/ralphte"><img src="https://avatars.githubusercontent.com/u/2996680?v=4?s=100" width="100px;" alt="Ralph"/><br /><sub><b>Ralph</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=ralphte" title="Code">💻</a></td>
      <td align="center"><a href="http://www.abc-groep.be"><img src="https://avatars.githubusercontent.com/u/2351765?v=4?s=100" width="100px;" alt="Joachim Baten"/><br /><sub><b>Joachim Baten</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=joachimbaten" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Ajoachimbaten" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/mxyng"><img src="https://avatars.githubusercontent.com/u/2372640?v=4?s=100" width="100px;" alt="Michael Yang"/><br /><sub><b>Michael Yang</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=mxyng" title="Code">💻</a></td>
      <td align="center"><a href="http://cturtle98.com"><img src="https://avatars.githubusercontent.com/u/24465356?v=4?s=100" width="100px;" alt="Ciaran Farley"/><br /><sub><b>Ciaran Farley</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=cTurtle98" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/Heavybullets8"><img src="https://avatars.githubusercontent.com/u/20793231?v=4?s=100" width="100px;" alt="Heavybullets8"/><br /><sub><b>Heavybullets8</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=Heavybullets8" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/commits?author=Heavybullets8" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3AHeavybullets8" title="Bug reports">🐛</a> <a href="#video-Heavybullets8" title="Videos">📹</a> <a href="#mentoring-Heavybullets8" title="Mentoring">🧑‍🏫</a> <a href="#financial-Heavybullets8" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/662"><img src="https://avatars.githubusercontent.com/u/13599186?v=4?s=100" width="100px;" alt="662"/><br /><sub><b>662</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=662" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/alex171"><img src="https://avatars.githubusercontent.com/u/28484494?v=4?s=100" width="100px;" alt="alex171"/><br /><sub><b>alex171</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=alex171" title="Documentation">📖</a></td>
      <td align="center"><a href="https://www.youtube.com/channel/UCOk-gHyjcWZNj3Br4oxwh0A"><img src="https://avatars.githubusercontent.com/u/1322205?v=4?s=100" width="100px;" alt="Techno Tim"/><br /><sub><b>Techno Tim</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=timothystewart6" title="Documentation">📖</a></td>
      <td align="center"><a href="http://mingyaoliu.com"><img src="https://avatars.githubusercontent.com/u/3460335?v=4?s=100" width="100px;" alt="Mingyao Liu"/><br /><sub><b>Mingyao Liu</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=MingyaoLiu" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3AMingyaoLiu" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/NightShaman"><img src="https://avatars.githubusercontent.com/u/12952292?v=4?s=100" width="100px;" alt="NightShaman"/><br /><sub><b>NightShaman</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=NightShaman" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=NightShaman" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/issues?q=author%3ANightShaman" title="Bug reports">🐛</a> <a href="#financial-NightShaman" title="Financial">💵</a> <a href="#mentoring-NightShaman" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://espadav8.co.uk"><img src="https://avatars.githubusercontent.com/u/115825?v=4?s=100" width="100px;" alt="Andrew Smith"/><br /><sub><b>Andrew Smith</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=EspadaV8" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/commits?author=EspadaV8" title="Tests">⚠️</a></td>
      <td align="center"><a href="http://xilix.com"><img src="https://avatars.githubusercontent.com/u/2821?v=4?s=100" width="100px;" alt="Bob Klosinski"/><br /><sub><b>Bob Klosinski</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=fluxin" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/sukarn-m"><img src="https://avatars.githubusercontent.com/u/10946339?v=4?s=100" width="100px;" alt="Sukarn"/><br /><sub><b>Sukarn</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=sukarn-m" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=sukarn-m" title="Documentation">📖</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/sebsx"><img src="https://avatars.githubusercontent.com/u/735033?v=4?s=100" width="100px;" alt="sebs"/><br /><sub><b>sebs</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=sebsx" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/Dyllan2000alfa"><img src="https://avatars.githubusercontent.com/u/29694020?v=4?s=100" width="100px;" alt="Dyllan Tinoco"/><br /><sub><b>Dyllan Tinoco</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=Dyllan2000alfa" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/StevenMcElligott"><img src="https://avatars.githubusercontent.com/u/89483932?v=4?s=100" width="100px;" alt="StevenMcElligott"/><br /><sub><b>StevenMcElligott</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=StevenMcElligott" title="Code">💻</a> <a href="#financial-StevenMcElligott" title="Financial">💵</a> <a href="https://github.com/truecharts/charts/commits?author=StevenMcElligott" title="Documentation">📖</a> <a href="https://github.com/truecharts/charts/issues?q=author%3AStevenMcElligott" title="Bug reports">🐛</a> <a href="#mentoring-StevenMcElligott" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://github.com/brothergomez"><img src="https://avatars.githubusercontent.com/u/38558969?v=4?s=100" width="100px;" alt="brothergomez"/><br /><sub><b>brothergomez</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=brothergomez" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Abrothergomez" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Sagit-chu"><img src="https://avatars.githubusercontent.com/u/36596628?v=4?s=100" width="100px;" alt="sagit"/><br /><sub><b>sagit</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=Sagit-chu" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3ASagit-chu" title="Bug reports">🐛</a> <a href="#video-Sagit-chu" title="Videos">📹</a> <a href="https://github.com/truecharts/charts/commits?author=Sagit-chu" title="Documentation">📖</a> <a href="#mentoring-Sagit-chu" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://zhouyou.info"><img src="https://avatars.githubusercontent.com/u/8481484?v=4?s=100" width="100px;" alt="Nevan Chow"/><br /><sub><b>Nevan Chow</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=zzzhouuu" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/soilheart"><img src="https://avatars.githubusercontent.com/u/9056381?v=4?s=100" width="100px;" alt="Daniel Carlsson"/><br /><sub><b>Daniel Carlsson</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Asoilheart" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/dlouie-swir"><img src="https://avatars.githubusercontent.com/u/81386715?v=4?s=100" width="100px;" alt="Devon Louie"/><br /><sub><b>Devon Louie</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Adlouie-swir" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Alex-Orsholits"><img src="https://avatars.githubusercontent.com/u/56907127?v=4?s=100" width="100px;" alt="Alex-Orsholits"/><br /><sub><b>Alex-Orsholits</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AAlex-Orsholits" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Tails32"><img src="https://avatars.githubusercontent.com/u/2036401?v=4?s=100" width="100px;" alt="Tails32"/><br /><sub><b>Tails32</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ATails32" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Menaxerius"><img src="https://avatars.githubusercontent.com/u/25470894?v=4?s=100" width="100px;" alt="Menaxerius"/><br /><sub><b>Menaxerius</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AMenaxerius" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/hidefog"><img src="https://avatars.githubusercontent.com/u/13468236?v=4?s=100" width="100px;" alt="hidefog"/><br /><sub><b>hidefog</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ahidefog" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/dalgibbard"><img src="https://avatars.githubusercontent.com/u/1159620?v=4?s=100" width="100px;" alt="Darren Gibbard"/><br /><sub><b>Darren Gibbard</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Adalgibbard" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/barti04"><img src="https://avatars.githubusercontent.com/u/34000663?v=4?s=100" width="100px;" alt="Barti"/><br /><sub><b>Barti</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Abarti04" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/Sunii"><img src="https://avatars.githubusercontent.com/u/4595444?v=4?s=100" width="100px;" alt="Sunii"/><br /><sub><b>Sunii</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ASunii" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/trbmchs"><img src="https://avatars.githubusercontent.com/u/7928292?v=4?s=100" width="100px;" alt="trbmchs"/><br /><sub><b>trbmchs</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Atrbmchs" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/PylotLight"><img src="https://avatars.githubusercontent.com/u/7006124?v=4?s=100" width="100px;" alt="Light"/><br /><sub><b>Light</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3APylotLight" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Boostflow"><img src="https://avatars.githubusercontent.com/u/18465315?v=4?s=100" width="100px;" alt="Boostflow"/><br /><sub><b>Boostflow</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ABoostflow" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Trigardon"><img src="https://avatars.githubusercontent.com/u/98973534?v=4?s=100" width="100px;" alt="Trigardon"/><br /><sub><b>Trigardon</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ATrigardon" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/dbb12345"><img src="https://avatars.githubusercontent.com/u/52704517?v=4?s=100" width="100px;" alt="dbb12345"/><br /><sub><b>dbb12345</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Adbb12345" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=dbb12345" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/karypid"><img src="https://avatars.githubusercontent.com/u/1221101?v=4?s=100" width="100px;" alt="karypid"/><br /><sub><b>karypid</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Akarypid" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/eingemaischt"><img src="https://avatars.githubusercontent.com/u/151498?v=4?s=100" width="100px;" alt="Philipp"/><br /><sub><b>Philipp</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aeingemaischt" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/j0hnby"><img src="https://avatars.githubusercontent.com/u/18377483?v=4?s=100" width="100px;" alt="John"/><br /><sub><b>John</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aj0hnby" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/john-parton"><img src="https://avatars.githubusercontent.com/u/2071543?v=4?s=100" width="100px;" alt="John Parton"/><br /><sub><b>John Parton</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ajohn-parton" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Amasis"><img src="https://avatars.githubusercontent.com/u/7325217?v=4?s=100" width="100px;" alt="Marc"/><br /><sub><b>Marc</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AAmasis" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/fdzaebel"><img src="https://avatars.githubusercontent.com/u/46503230?v=4?s=100" width="100px;" alt="fdzaebel"/><br /><sub><b>fdzaebel</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Afdzaebel" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/kloeckwerx"><img src="https://avatars.githubusercontent.com/u/97212383?v=4?s=100" width="100px;" alt="kloeckwerx"/><br /><sub><b>kloeckwerx</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Akloeckwerx" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/BirdBare"><img src="https://avatars.githubusercontent.com/u/1051490?v=4?s=100" width="100px;" alt="Bradley Bare"/><br /><sub><b>Bradley Bare</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ABirdBare" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/alexthamm"><img src="https://avatars.githubusercontent.com/u/2556372?v=4?s=100" width="100px;" alt="Alexander Thamm"/><br /><sub><b>Alexander Thamm</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aalexthamm" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/rexit1982"><img src="https://avatars.githubusercontent.com/u/7585043?v=4?s=100" width="100px;" alt="rexit1982"/><br /><sub><b>rexit1982</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Arexit1982" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/iaxx"><img src="https://avatars.githubusercontent.com/u/13745514?v=4?s=100" width="100px;" alt="iaxx"/><br /><sub><b>iaxx</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aiaxx" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://xstar97.github.io"><img src="https://avatars.githubusercontent.com/u/9399967?v=4?s=100" width="100px;" alt="Xstar97"/><br /><sub><b>Xstar97</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AXstar97" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=Xstar97" title="Code">💻</a> <a href="#mentoring-Xstar97" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://github.com/Ornias"><img src="https://avatars.githubusercontent.com/u/20852677?v=4?s=100" width="100px;" alt="ornias"/><br /><sub><b>ornias</b></sub></a><br /><a href="#video-ornias" title="Videos">📹</a></td>
      <td align="center"><a href="http://joshasplund.com"><img src="https://avatars.githubusercontent.com/u/3958801?v=4?s=100" width="100px;" alt="Josh Asplund"/><br /><sub><b>Josh Asplund</b></sub></a><br /><a href="#financial-joshuata" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/midnight33233"><img src="https://avatars.githubusercontent.com/u/25982892?v=4?s=100" width="100px;" alt="midnight33233"/><br /><sub><b>midnight33233</b></sub></a><br /><a href="#financial-midnight33233" title="Financial">💵</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/kbftech"><img src="https://avatars.githubusercontent.com/u/77502706?v=4?s=100" width="100px;" alt="kbftech"/><br /><sub><b>kbftech</b></sub></a><br /><a href="#financial-kbftech" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/hogenf"><img src="https://avatars.githubusercontent.com/u/11094630?v=4?s=100" width="100px;" alt="hogenf"/><br /><sub><b>hogenf</b></sub></a><br /><a href="#financial-hogenf" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/hawkinzzz"><img src="https://avatars.githubusercontent.com/u/24587652?v=4?s=100" width="100px;" alt="Hawks"/><br /><sub><b>Hawks</b></sub></a><br /><a href="#financial-hawkinzzz" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/bodly2"><img src="https://avatars.githubusercontent.com/u/21004768?v=4?s=100" width="100px;" alt="Jim Russell"/><br /><sub><b>Jim Russell</b></sub></a><br /><a href="#financial-bodly2" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/TheGovnah"><img src="https://avatars.githubusercontent.com/u/1300101?v=4?s=100" width="100px;" alt="TheGovnah"/><br /><sub><b>TheGovnah</b></sub></a><br /><a href="#financial-TheGovnah" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/famewolf"><img src="https://avatars.githubusercontent.com/u/4558832?v=4?s=100" width="100px;" alt="famewolf"/><br /><sub><b>famewolf</b></sub></a><br /><a href="#financial-famewolf" title="Financial">💵</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Afamewolf" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/konradbjk"><img src="https://avatars.githubusercontent.com/u/31480935?v=4?s=100" width="100px;" alt="Konrad Bujak"/><br /><sub><b>Konrad Bujak</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=konradbjk" title="Documentation">📖</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/190n"><img src="https://avatars.githubusercontent.com/u/7763597?v=4?s=100" width="100px;" alt="190n"/><br /><sub><b>190n</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=190n" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=190n" title="Documentation">📖</a></td>
      <td align="center"><a href="https://alexejk.io"><img src="https://avatars.githubusercontent.com/u/104794?v=4?s=100" width="100px;" alt="Alexej Kubarev"/><br /><sub><b>Alexej Kubarev</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=alexejk" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/r-vanooyen"><img src="https://avatars.githubusercontent.com/u/45106123?v=4?s=100" width="100px;" alt="r-vanooyen"/><br /><sub><b>r-vanooyen</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=r-vanooyen" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/shadofall"><img src="https://avatars.githubusercontent.com/u/9327622?v=4?s=100" width="100px;" alt="shadofall"/><br /><sub><b>shadofall</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=shadofall" title="Documentation">📖</a> <a href="#mentoring-shadofall" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://github.com/agreppin"><img src="https://avatars.githubusercontent.com/u/26579013?v=4?s=100" width="100px;" alt="agreppin"/><br /><sub><b>agreppin</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=agreppin" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/stdedos"><img src="https://avatars.githubusercontent.com/u/133706?v=4?s=100" width="100px;" alt="Stavros Ntentos"/><br /><sub><b>Stavros Ntentos</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=stdedos" title="Code">💻</a> <a href="#ideas-stdedos" title="Ideas, Planning, & Feedback">🤔</a></td>
      <td align="center"><a href="https://github.com/VladFlorinIlie"><img src="https://avatars.githubusercontent.com/u/35900803?v=4?s=100" width="100px;" alt="Vlad-Florin Ilie"/><br /><sub><b>Vlad-Florin Ilie</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=VladFlorinIlie" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/huma2000"><img src="https://avatars.githubusercontent.com/u/9518124?v=4?s=100" width="100px;" alt="huma2000"/><br /><sub><b>huma2000</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ahuma2000" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/hugalafutro"><img src="https://avatars.githubusercontent.com/u/30209689?v=4?s=100" width="100px;" alt="hugalafutro"/><br /><sub><b>hugalafutro</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ahugalafutro" title="Bug reports">🐛</a> <a href="#financial-hugalafutro" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/yehia2amer"><img src="https://avatars.githubusercontent.com/u/6174059?v=4?s=100" width="100px;" alt="yehia Amer"/><br /><sub><b>yehia Amer</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=yehia2amer" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/tfrancis"><img src="https://avatars.githubusercontent.com/u/29070?v=4?s=100" width="100px;" alt="Tyler Stransky"/><br /><sub><b>Tyler Stransky</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Atfrancis" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/juggie"><img src="https://avatars.githubusercontent.com/u/2034757?v=4?s=100" width="100px;" alt="juggie"/><br /><sub><b>juggie</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ajuggie" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/btilford"><img src="https://avatars.githubusercontent.com/u/248725?v=4?s=100" width="100px;" alt="Ben Tilford"/><br /><sub><b>Ben Tilford</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Abtilford" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=btilford" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/I-nebukad-I"><img src="https://avatars.githubusercontent.com/u/16634069?v=4?s=100" width="100px;" alt="I-nebukad-I"/><br /><sub><b>I-nebukad-I</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AI-nebukad-I" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=I-nebukad-I" title="Code">💻</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/packruler"><img src="https://avatars.githubusercontent.com/u/770373?v=4?s=100" width="100px;" alt="Ethan Leisinger"/><br /><sub><b>Ethan Leisinger</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=packruler" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=packruler" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/CullenShane"><img src="https://avatars.githubusercontent.com/u/597786?v=4?s=100" width="100px;" alt="Cullen Murphy"/><br /><sub><b>Cullen Murphy</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=CullenShane" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3ACullenShane" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/jthat"><img src="https://avatars.githubusercontent.com/u/1931222?v=4?s=100" width="100px;" alt="Jason Thatcher"/><br /><sub><b>Jason Thatcher</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=jthat" title="Code">💻</a> <a href="https://github.com/truecharts/charts/issues?q=author%3Ajthat" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=jthat" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/stefanschramek"><img src="https://avatars.githubusercontent.com/u/921342?v=4?s=100" width="100px;" alt="Stefan Schramek"/><br /><sub><b>Stefan Schramek</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Astefanschramek" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/nokaka"><img src="https://avatars.githubusercontent.com/u/101942715?v=4?s=100" width="100px;" alt="nokaka"/><br /><sub><b>nokaka</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Anokaka" title="Bug reports">🐛</a></td>
      <td align="center"><a href="http://code.lockszmith.com"><img src="https://avatars.githubusercontent.com/u/905716?v=4?s=100" width="100px;" alt="Gal Szkolnik"/><br /><sub><b>Gal Szkolnik</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3ALockszmith-GH" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/undsoft"><img src="https://avatars.githubusercontent.com/u/1481270?v=4?s=100" width="100px;" alt="Evgeny Stepanovych"/><br /><sub><b>Evgeny Stepanovych</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aundsoft" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/sonicaj"><img src="https://avatars.githubusercontent.com/u/17968138?v=4?s=100" width="100px;" alt="Waqar Ahmed"/><br /><sub><b>Waqar Ahmed</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Asonicaj" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/DrSKiZZ"><img src="https://avatars.githubusercontent.com/u/50158917?v=4?s=100" width="100px;" alt="DrSKiZZ"/><br /><sub><b>DrSKiZZ</b></sub></a><br /><a href="#financial-DrSKiZZ" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/janpuc"><img src="https://avatars.githubusercontent.com/u/8539508?v=4?s=100" width="100px;" alt="Jan Puciłowski"/><br /><sub><b>Jan Puciłowski</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=janpuc" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=janpuc" title="Tests">⚠️</a></td>
      <td align="center"><a href="https://github.com/shauncoyne"><img src="https://avatars.githubusercontent.com/u/13672807?v=4?s=100" width="100px;" alt="Shaun Coyne"/><br /><sub><b>Shaun Coyne</b></sub></a><br /><a href="#financial-shauncoyne" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/ich777"><img src="https://avatars.githubusercontent.com/u/28066518?v=4?s=100" width="100px;" alt="Christoph"/><br /><sub><b>Christoph</b></sub></a><br /><a href="#financial-ich777" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/UnDifferential"><img src="https://avatars.githubusercontent.com/u/17625468?v=4?s=100" width="100px;" alt="Brandon Rutledge"/><br /><sub><b>Brandon Rutledge</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AUnDifferential" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/mikeNG"><img src="https://avatars.githubusercontent.com/u/1216752?v=4?s=100" width="100px;" alt="Michael Bestas"/><br /><sub><b>Michael Bestas</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AmikeNG" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://rudaks.lv"><img src="https://avatars.githubusercontent.com/u/4631864?v=4?s=100" width="100px;" alt="Jurģis Rudaks"/><br /><sub><b>Jurģis Rudaks</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Ajurgisrudaks" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/brunofatia"><img src="https://avatars.githubusercontent.com/u/67926902?v=4?s=100" width="100px;" alt="brunofatia"/><br /><sub><b>brunofatia</b></sub></a><br /><a href="#financial-brunofatia" title="Financial">💵</a></td>
      <td align="center"><a href="https://github.com/TopicsLP"><img src="https://avatars.githubusercontent.com/u/9019121?v=4?s=100" width="100px;" alt="TopicsLP"/><br /><sub><b>TopicsLP</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=TopicsLP" title="Documentation">📖</a></td>
      <td align="center"><a href="https://schnerring.net"><img src="https://avatars.githubusercontent.com/u/3743342?v=4?s=100" width="100px;" alt="Michael Schnerring"/><br /><sub><b>Michael Schnerring</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aschnerring" title="Bug reports">🐛</a> <a href="https://github.com/truecharts/charts/commits?author=schnerring" title="Code">💻</a></td>
      <td align="center"><a href="https://tamasnagy.com"><img src="https://avatars.githubusercontent.com/u/1661487?v=4?s=100" width="100px;" alt="Tamas Nagy"/><br /><sub><b>Tamas Nagy</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Atlnagy" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://OpenSpeedTest.com"><img src="https://avatars.githubusercontent.com/u/51720450?v=4?s=100" width="100px;" alt="OpenSpeedTest™️"/><br /><sub><b>OpenSpeedTest™️</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=openspeedtest" title="Code">💻</a></td>
      <td align="center"><a href="https://richardjacton.github.io/"><img src="https://avatars.githubusercontent.com/u/6893043?v=4?s=100" width="100px;" alt="Richard James Acton"/><br /><sub><b>Richard James Acton</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=RichardJActon" title="Documentation">📖</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/lps-rocks"><img src="https://avatars.githubusercontent.com/u/10893911?v=4?s=100" width="100px;" alt="lps-rocks"/><br /><sub><b>lps-rocks</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Alps-rocks" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Faustvii"><img src="https://avatars.githubusercontent.com/u/4357216?v=4?s=100" width="100px;" alt="Faust"/><br /><sub><b>Faust</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AFaustvii" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/uranderu"><img src="https://avatars.githubusercontent.com/u/71091366?v=4?s=100" width="100px;" alt="uranderu"/><br /><sub><b>uranderu</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Auranderu" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/heytcass"><img src="https://avatars.githubusercontent.com/u/11260288?v=4?s=100" width="100px;" alt="Tom Cassady"/><br /><sub><b>Tom Cassady</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aheytcass" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/Huftierchen"><img src="https://avatars.githubusercontent.com/u/16015778?v=4?s=100" width="100px;" alt="Huftierchen"/><br /><sub><b>Huftierchen</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AHuftierchen" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://github.com/ZasX"><img src="https://avatars.githubusercontent.com/u/806452?v=4?s=100" width="100px;" alt="ZasX"/><br /><sub><b>ZasX</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=ZasX" title="Documentation">📖</a> <a href="#mentoring-ZasX" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://github.com/aeolus811tw"><img src="https://avatars.githubusercontent.com/u/4956319?v=4?s=100" width="100px;" alt="Kevin T."/><br /><sub><b>Kevin T.</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Aaeolus811tw" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/Chowarmaan"><img src="https://avatars.githubusercontent.com/u/175738?v=4?s=100" width="100px;" alt="Steven Scott"/><br /><sub><b>Steven Scott</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=Chowarmaan" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/piwi3910"><img src="https://avatars.githubusercontent.com/u/12539757?v=4?s=100" width="100px;" alt="Watteel Pascal"/><br /><sub><b>Watteel Pascal</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=piwi3910" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/JamesOsborn-SE"><img src="https://avatars.githubusercontent.com/u/3580335?v=4?s=100" width="100px;" alt="JamesOsborn-SE"/><br /><sub><b>JamesOsborn-SE</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=JamesOsborn-SE" title="Code">💻</a> <a href="https://github.com/truecharts/charts/commits?author=JamesOsborn-SE" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/neoestremi"><img src="https://avatars.githubusercontent.com/u/1340877?v=4?s=100" width="100px;" alt="NeoToxic"/><br /><sub><b>NeoToxic</b></sub></a><br /><a href="#mentoring-neoestremi" title="Mentoring">🧑‍🏫</a></td>
      <td align="center"><a href="https://github.com/jab416171"><img src="https://avatars.githubusercontent.com/u/345752?v=4?s=100" width="100px;" alt="jab416171"/><br /><sub><b>jab416171</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=jab416171" title="Documentation">📖</a></td>
      <td align="center"><a href="http://www.zioniyes.me"><img src="https://avatars.githubusercontent.com/u/16231288?v=4?s=100" width="100px;" alt="Anna"/><br /><sub><b>Anna</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=HumbleDeer" title="Documentation">📖</a></td>
      <td align="center"><a href="https://github.com/ChaosBlades"><img src="https://avatars.githubusercontent.com/u/7530545?v=4?s=100" width="100px;" alt="ChaosBlades"/><br /><sub><b>ChaosBlades</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3AChaosBlades" title="Bug reports">🐛</a></td>
    </tr>
    <tr>
      <td align="center"><a href="https://github.com/TrueBrain"><img src="https://avatars.githubusercontent.com/u/1663690?v=4?s=100" width="100px;" alt="Patric Stout"/><br /><sub><b>Patric Stout</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=TrueBrain" title="Code">💻</a></td>
      <td align="center"><a href="https://github.com/SuperQ"><img src="https://avatars.githubusercontent.com/u/1320667?v=4?s=100" width="100px;" alt="Ben Kochie"/><br /><sub><b>Ben Kochie</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=SuperQ" title="Code">💻</a></td>
      <td align="center"><a href="https://www.cepheid.org/~jeff/"><img src="https://avatars.githubusercontent.com/u/3298329?v=4?s=100" width="100px;" alt="Jeff Bachtel"/><br /><sub><b>Jeff Bachtel</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=jeffb4" title="Documentation">📖</a></td>
      <td align="center"><a href="https://www.woods.am/"><img src="https://avatars.githubusercontent.com/u/7113557?v=4?s=100" width="100px;" alt="Ben Woods"/><br /><sub><b>Ben Woods</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=woodsb02" title="Code">💻</a></td>
      <td align="center"><a href="http://karlshea.com"><img src="https://avatars.githubusercontent.com/u/40136?v=4?s=100" width="100px;" alt="Karl Shea"/><br /><sub><b>Karl Shea</b></sub></a><br /><a href="https://github.com/truecharts/charts/issues?q=author%3Akarlshea" title="Bug reports">🐛</a></td>
      <td align="center"><a href="https://www.linkedin.com/in/gouthamkumaran"><img src="https://avatars.githubusercontent.com/u/9553104?v=4?s=100" width="100px;" alt="Balakumaran MN"/><br /><sub><b>Balakumaran MN</b></sub></a><br /><a href="https://github.com/truecharts/charts/commits?author=gouthamkumaran" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!

## Licence

[![License](https://img.shields.io/badge/License-BSD%203--Clause-orange.svg?style=for-the-badge)](https://github.com/truecharts/charts/blob/master/docs/LICENSE.BSD3)

---

Truecharts, is primarily based on a BSD-3-clause license, this ensures almost everyone can use and modify our charts.
As a lot of Charts are based on upstream Helm Charts, Licences can vary on a per-Chart basis. This can easily be seen by the presence of a "LICENSE" file in said folder.

An exception to this, has been made for every document inside folders labeled as `docs` or `doc` and their subfolders: those folders are not licensed under BSD-3-clause and are considered "all rights reserved". Said content can be modified and changes submitted per PR, in accordance to the github End User License Agreement.

`SPDX-License-Identifier: BSD-3-Clause`

---

![built-with-resentment](http://forthebadge.com/images/badges/built-with-resentment.svg) ![contains-technical-debt](http://forthebadge.com/images/badges/contains-technical-debt.svg)
