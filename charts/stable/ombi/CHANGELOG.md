# Changelog<br>


<a name="ombi-8.0.16"></a>
### [ombi-8.0.16](https://github.com/truecharts/apps/compare/ombi-8.0.13...ombi-8.0.16) (2021-10-20)

#### Chore

* bump apps, remove duplicates and move incubator to stable for RC1
* update non-major deps helm releases ([#1213](https://github.com/truecharts/apps/issues/1213))

#### Fix

* reenable postgresql migration scripting and bump all to force update
* use correct PVC storageClass when using postgresql as a dependency on SCALE ([#1212](https://github.com/truecharts/apps/issues/1212))



<a name="ombi-8.0.13"></a>
### [ombi-8.0.13](https://github.com/truecharts/apps/compare/ombi-8.0.12...ombi-8.0.13) (2021-10-20)

#### Chore

* bump versions to rerelease and fix icons



<a name="ombi-8.0.12"></a>
### [ombi-8.0.12](https://github.com/truecharts/apps/compare/ombi-8.0.11...ombi-8.0.12) (2021-10-19)

#### Change

* Project-Eclipse 3, Automatically generate item.yaml ([#1178](https://github.com/truecharts/apps/issues/1178))

#### Chore

* Project-Eclipse 5, move app-readme to automatic generation script ([#1181](https://github.com/truecharts/apps/issues/1181))
* Project-Eclipse part 2, adapting and cleaning changelog ([#1173](https://github.com/truecharts/apps/issues/1173))
* update helm chart common to v8.3.13 ([#1184](https://github.com/truecharts/apps/issues/1184))

#### Feat

* Project-Eclipse 4, Add App grading annotations to Chart.yaml ([#1180](https://github.com/truecharts/apps/issues/1180))

#### Refactor

* Project Eclipse Part 6, move questions.yaml to root App folder ([#1182](https://github.com/truecharts/apps/issues/1182))



<a name="ombi-8.0.11"></a>
### [ombi-8.0.11](https://github.com/truecharts/apps/compare/ombi-8.0.10...ombi-8.0.11) (2021-10-19)

#### Fix

* fix previous SCALE bugfix not correctly being applied



<a name="ombi-8.0.10"></a>
### [ombi-8.0.10](https://github.com/truecharts/apps/compare/ombi-8.0.9...ombi-8.0.10) (2021-10-19)

#### Fix

* Solve issues regarding ix_values.yaml not containing the image and tag definitions. ([#1176](https://github.com/truecharts/apps/issues/1176))



<a name="ombi-8.0.9"></a>
### [ombi-8.0.9](https://github.com/truecharts/apps/compare/ombi-8.0.8...ombi-8.0.9) (2021-10-18)

#### Chore

* Add description on persistence ([#1172](https://github.com/truecharts/apps/issues/1172))

#### Refactor

* Project Eclipse - part 1 - remove ix_values.yaml ([#1168](https://github.com/truecharts/apps/issues/1168))



<a name="ombi-8.0.8"></a>
### [ombi-8.0.8](https://github.com/truecharts/apps/compare/ombi-8.0.7...ombi-8.0.8) (2021-10-17)

#### Chore

* update helm chart common to v8.3.10 ([#1160](https://github.com/truecharts/apps/issues/1160))

#### Fix

* force users using correct / prefix for mounPath ([#1156](https://github.com/truecharts/apps/issues/1156))



<a name="ombi-8.0.7"></a>
### [ombi-8.0.7](https://github.com/truecharts/apps/compare/ombi-8.0.6...ombi-8.0.7) (2021-10-13)

#### Chore

* update non-major deps helm releases ([#1133](https://github.com/truecharts/apps/issues/1133))



<a name="ombi-8.0.6"></a>
### [ombi-8.0.6](https://github.com/truecharts/apps/compare/ombi-8.0.5...ombi-8.0.6) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1126](https://github.com/truecharts/apps/issues/1126))



<a name="ombi-8.0.5"></a>
### [ombi-8.0.5](https://github.com/truecharts/apps/compare/ombi-8.0.4...ombi-8.0.5) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1123](https://github.com/truecharts/apps/issues/1123))



<a name="ombi-8.0.4"></a>
### [ombi-8.0.4](https://github.com/truecharts/apps/compare/ombi-8.0.3...ombi-8.0.4) (2021-10-05)

#### Chore

* update non-major deps helm releases ([#1099](https://github.com/truecharts/apps/issues/1099))



<a name="ombi-8.0.3"></a>
### [ombi-8.0.3](https://github.com/truecharts/apps/compare/ombi-8.0.2...ombi-8.0.3) (2021-09-29)

#### Chore

* update helm chart common to v8.0.13 ([#1060](https://github.com/truecharts/apps/issues/1060))



<a name="ombi-8.0.1"></a>
### [ombi-8.0.1](https://github.com/truecharts/apps/compare/ombi-8.0.0...ombi-8.0.1) (2021-09-26)



<a name="ombi-8.0.0"></a>
### [ombi-8.0.0](https://github.com/truecharts/apps/compare/ombi-7.0.2...ombi-8.0.0) (2021-09-26)



<a name="ombi-7.0.2"></a>
### [ombi-7.0.2](https://github.com/truecharts/apps/compare/ombi-7.0.1...ombi-7.0.2) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="ombi-7.0.1"></a>
### [ombi-7.0.1](https://github.com/truecharts/apps/compare/ombi-6.11.18...ombi-7.0.1) (2021-09-13)

#### Chore

* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))

<a name="ombi-6.11.18"></a>
## [ombi-6.11.18](https://github.com/truecharts/apps/compare/ombi-6.11.17...ombi-6.11.18) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
