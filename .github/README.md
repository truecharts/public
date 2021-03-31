# About TrueCharts<br>
**Community App Catalog for TrueNAS SCALE**

[![docs](https://img.shields.io/badge/docs-rtfm-yellow?logo=gitbook&logoColor=white&style=for-the-badge)](https://truecharts.org/)
[![GitHub last commit](https://img.shields.io/github/last-commit/truecharts/apps?color=brightgreen&logoColor=white&style=for-the-badge)](https://github.com/truecharts/apps/commits)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)
[![renovate](https://img.shields.io/badge/renovate-enabled-brightgreen?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjUgNSAzNzAgMzcwIj48Y2lyY2xlIGN4PSIxODkiIGN5PSIxOTAiIHI9IjE4NCIgZmlsbD0iI2ZlMiIvPjxwYXRoIGZpbGw9IiM4YmIiIGQ9Ik0yNTEgMjU2bC0zOC0zOGExNyAxNyAwIDAxMC0yNGw1Ni01NmMyLTIgMi02IDAtN2wtMjAtMjFhNSA1IDAgMDAtNyAwbC0xMyAxMi05LTggMTMtMTNhMTcgMTcgMCAwMTI0IDBsMjEgMjFjNyA3IDcgMTcgMCAyNGwtNTYgNTdhNSA1IDAgMDAwIDdsMzggMzh6Ii8+PHBhdGggZmlsbD0iI2Q1MSIgZD0iTTMwMCAyODhsLTggOGMtNCA0LTExIDQtMTYgMGwtNDYtNDZjLTUtNS01LTEyIDAtMTZsOC04YzQtNCAxMS00IDE1IDBsNDcgNDdjNCA0IDQgMTEgMCAxNXoiLz48cGF0aCBmaWxsPSIjYjMwIiBkPSJNMjg1IDI1OGw3IDdjNCA0IDQgMTEgMCAxNWwtOCA4Yy00IDQtMTEgNC0xNiAwbC02LTdjNCA1IDExIDUgMTUgMGw4LTdjNC01IDQtMTIgMC0xNnoiLz48cGF0aCBmaWxsPSIjYTMwIiBkPSJNMjkxIDI2NGw4IDhjNCA0IDQgMTEgMCAxNmwtOCA3Yy00IDUtMTEgNS0xNSAwbC05LThjNSA1IDEyIDUgMTYgMGw4LThjNC00IDQtMTEgMC0xNXoiLz48cGF0aCBmaWxsPSIjZTYyIiBkPSJNMjYwIDIzM2wtNC00Yy02LTYtMTctNi0yMyAwLTcgNy03IDE3IDAgMjRsNCA0Yy00LTUtNC0xMSAwLTE2bDgtOGM0LTQgMTEtNCAxNSAweiIvPjxwYXRoIGZpbGw9IiNiNDAiIGQ9Ik0yODQgMzA0Yy00IDAtOC0xLTExLTRsLTQ3LTQ3Yy02LTYtNi0xNiAwLTIybDgtOGM2LTYgMTYtNiAyMiAwbDQ3IDQ2YzYgNyA2IDE3IDAgMjNsLTggOGMtMyAzLTcgNC0xMSA0em0tMzktNzZjLTEgMC0zIDAtNCAybC04IDdjLTIgMy0yIDcgMCA5bDQ3IDQ3YTYgNiAwIDAwOSAwbDctOGMzLTIgMy02IDAtOWwtNDYtNDZjLTItMi0zLTItNS0yeiIvPjxwYXRoIGZpbGw9IiMxY2MiIGQ9Ik0xNTIgMTEzbDE4LTE4IDE4IDE4LTE4IDE4em0xLTM1bDE4LTE4IDE4IDE4LTE4IDE4em0tOTAgODlsMTgtMTggMTggMTgtMTggMTh6bTM1LTM2bDE4LTE4IDE4IDE4LTE4IDE4eiIvPjxwYXRoIGZpbGw9IiMxZGQiIGQ9Ik0xMzQgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em0tMzUgMzZsMTgtMTggMTggMTgtMTggMTh6Ii8+PHBhdGggZmlsbD0iIzJiYiIgZD0iTTExNiAxNDlsMTgtMTggMTggMTgtMTggMTh6bTU0LTU0bDE4LTE4IDE4IDE4LTE4IDE4em0tODkgOTBsMTgtMTggMTggMTgtMTggMTh6bTEzOS04NWwyMyAyM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTI0LTI0Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS01IDEyLTUgMTYgMHoiLz48cGF0aCBmaWxsPSIjM2VlIiBkPSJNMTM0IDk1bDE4LTE4IDE4IDE4LTE4IDE4em0tNTQgMThsMTgtMTcgMTggMTctMTggMTh6bTU1LTUzbDE4LTE4IDE4IDE4LTE4IDE4em05MyA0OGwtOC04Yy00LTUtMTEtNS0xNiAwTDEwMyAyMDFjLTQgNC00IDExIDAgMTVsOCA4Yy00LTQtNC0xMSAwLTE1bDEwMS0xMDFjNS00IDEyLTQgMTYgMHoiLz48cGF0aCBmaWxsPSIjOWVlIiBkPSJNMjcgMTMxbDE4LTE4IDE4IDE4LTE4IDE4em01NC01M2wxOC0xOCAxOCAxOC0xOCAxOHoiLz48cGF0aCBmaWxsPSIjMGFhIiBkPSJNMjMwIDExMGwxMyAxM2M0IDQgNCAxMSAwIDE2TDE0MiAyNDBjLTQgNC0xMSA0LTE1IDBsLTEzLTEzYzQgNCAxMSA0IDE1IDBsMTAxLTEwMWM1LTUgNS0xMSAwLTE2eiIvPjxwYXRoIGZpbGw9IiMxYWIiIGQ9Ik0xMzQgMjQ4Yy00IDAtOC0yLTExLTVsLTIzLTIzYTE2IDE2IDAgMDEwLTIzTDIwMSA5NmExNiAxNiAwIDAxMjIgMGwyNCAyNGM2IDYgNiAxNiAwIDIyTDE0NiAyNDNjLTMgMy03IDUtMTIgNXptNzgtMTQ3bC00IDItMTAxIDEwMWE2IDYgMCAwMDAgOWwyMyAyM2E2IDYgMCAwMDkgMGwxMDEtMTAxYTYgNiAwIDAwMC05bC0yNC0yMy00LTJ6Ii8+PC9zdmc+)](https://github.com/renovatebot/renovate)
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-18-orange.svg?style=for-the-badge)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
---
Truecharts is an innitiative to provide high quality Apps to use with the TrueNAS SCALE App Ecosystem.
Our primary goals are:
- Micro-Service Centered
- Native Kubernetes
- Stability
- Consistancy

All our apps are supposed to work together, be easy to setup using the TrueNAS UI and, above all, give the average user more than enough options to tune things to their liking.


## Getting started using TrueCharts
Installing TrueCharts within TrueNAS SCALE, is possible using the TrueNAS SCALE Catalog list.

For more information:
https://truecharts.org/manual/adding-truecharts/

## FAQ

Please refer to our [FAQ](https://truecharts.org/about/FAQ/) and [Issue tracker](https://github.com/truecharts/apps/issues) before creating an issue.
There is a significant chance your issue has been reported before!

## Getting into creating Apps

Creating charts takes some getting used to, as it's based on Helm charts. We highly suggest prior knowhow on creation/modifying Helm Charts, before taking on the challenge of creating SCALE Apps.

## Featured Projects

A lot of our work is based on the great effort of others. We would love to extend special thanks to these projects we owe a lot to:

| <a href="https://www.truenas.com/truenas-scale/"> <img src="https://user-images.githubusercontent.com/7613738/113836934-a1764e00-978d-11eb-8e19-a087c5c1f99b.png" width="150" height="150" /> </a> | <a href="https://k8s-at-home.com/"> <img src="https://user-images.githubusercontent.com/7613738/113837194-e26e6280-978d-11eb-9632-2e1529946302.png" width="150" height="150" /> </a> | <a href="https://traefik.io/traefik/"> <img src="https://user-images.githubusercontent.com/7613738/113837353-0b8ef300-978e-11eb-873e-14769acfe1f1.png" width="150" height="150" /> </a> |
| :---------------: | :---------------: | :---------------: |
| <a href="https://www.truenas.com/truenas-scale/">TrueNAS SCALE</a> |  <a href="https://k8s-at-home.com/">K8S-At-Home</a> | <a href="https://traefik.io/traefik/">Traefik</a> |


## Licence

[![License](https://img.shields.io/badge/License-BSD%203--Clause-orange.svg?style=for-the-badge)](https://github.com/truecharts/apps/blob/master/docs/LICENSE.BSD3)



Truecharts as a whole, is based on a BSD-3-clause  license, this ensures almost everyone can use and modify our charts. However: As a lot of Apps are based on upstream Helm Charts, Licences can vary on a per-App basis. This can easily be seen by the presence of a "LICENSE" file in the App rootfolder.

Some Apps may also contain parts in other licenses, such as libraries or templates, these files can be recognised by their individual headers.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Ftruecharts%2Ftruecharts?ref=badge_large)

`SPDX-License-Identifier: BSD-3-Clause`

---
![built-with-resentment](http://forthebadge.com/images/badges/built-with-resentment.svg)       ![contains-technical-debt](http://forthebadge.com/images/badges/contains-technical-debt.svg)
