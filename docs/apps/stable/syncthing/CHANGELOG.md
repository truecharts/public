# Changelog<br>


<a name="syncthing-8.0.12"></a>
### [syncthing-8.0.12](https://github.com/truecharts/apps/compare/syncthing-8.0.11...syncthing-8.0.12) (2021-10-19)

#### Fix

* fix previous SCALE bugfix not correctly being applied



<a name="syncthing-8.0.11"></a>
### [syncthing-8.0.11](https://github.com/truecharts/apps/compare/syncthing-8.0.10...syncthing-8.0.11) (2021-10-19)

#### Fix

* Solve issues regarding ix_values.yaml not containing the image and tag definitions. ([#1176](https://github.com/truecharts/apps/issues/1176))



<a name="syncthing-8.0.10"></a>
### [syncthing-8.0.10](https://github.com/truecharts/apps/compare/syncthing-8.0.9...syncthing-8.0.10) (2021-10-18)

#### Chore

* Add description on persistence ([#1172](https://github.com/truecharts/apps/issues/1172))

#### Refactor

* Project Eclipse - part 1 - remove ix_values.yaml ([#1168](https://github.com/truecharts/apps/issues/1168))



<a name="syncthing-8.0.9"></a>
### [syncthing-8.0.9](https://github.com/truecharts/apps/compare/syncthing-8.0.8...syncthing-8.0.9) (2021-10-17)

#### Chore

* update helm chart common to v8.3.10 ([#1160](https://github.com/truecharts/apps/issues/1160))

#### Fix

* force users using correct / prefix for mounPath ([#1156](https://github.com/truecharts/apps/issues/1156))



<a name="syncthing-8.0.8"></a>
### [syncthing-8.0.8](https://github.com/truecharts/apps/compare/syncthing-8.0.7...syncthing-8.0.8) (2021-10-13)

#### Chore

* update non-major deps helm releases ([#1133](https://github.com/truecharts/apps/issues/1133))



<a name="syncthing-8.0.7"></a>
### [syncthing-8.0.7](https://github.com/truecharts/apps/compare/syncthing-8.0.6...syncthing-8.0.7) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1126](https://github.com/truecharts/apps/issues/1126))



<a name="syncthing-8.0.6"></a>
### [syncthing-8.0.6](https://github.com/truecharts/apps/compare/syncthing-8.0.5...syncthing-8.0.6) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1123](https://github.com/truecharts/apps/issues/1123))



<a name="syncthing-8.0.5"></a>
### [syncthing-8.0.5](https://github.com/truecharts/apps/compare/syncthing-8.0.4...syncthing-8.0.5) (2021-10-05)

#### Chore

* update non-major deps helm releases ([#1099](https://github.com/truecharts/apps/issues/1099))



<a name="syncthing-8.0.4"></a>
### [syncthing-8.0.4](https://github.com/truecharts/apps/compare/syncthing-8.0.3...syncthing-8.0.4) (2021-10-05)

#### Chore

* update non-major ([#1098](https://github.com/truecharts/apps/issues/1098))



<a name="syncthing-8.0.3"></a>
### [syncthing-8.0.3](https://github.com/truecharts/apps/compare/syncthing-8.0.2...syncthing-8.0.3) (2021-09-29)

#### Chore

* update helm chart common to v8.0.13 ([#1060](https://github.com/truecharts/apps/issues/1060))



<a name="syncthing-8.0.1"></a>
### [syncthing-8.0.1](https://github.com/truecharts/apps/compare/syncthing-8.0.0...syncthing-8.0.1) (2021-09-26)



<a name="syncthing-8.0.0"></a>
### [syncthing-8.0.0](https://github.com/truecharts/apps/compare/syncthing-7.0.3...syncthing-8.0.0) (2021-09-26)



<a name="syncthing-7.0.3"></a>
### [syncthing-7.0.3](https://github.com/truecharts/apps/compare/syncthing-7.0.2...syncthing-7.0.3) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="syncthing-7.0.2"></a>
### [syncthing-7.0.2](https://github.com/truecharts/apps/compare/syncthing-7.0.1...syncthing-7.0.2) (2021-09-13)

#### Fix

* correct image tag for Syncthing on SCALE



<a name="syncthing-7.0.1"></a>
### [syncthing-7.0.1](https://github.com/truecharts/apps/compare/syncthing-6.11.15...syncthing-7.0.1) (2021-09-13)

#### Chore

* move most remaining Apps to GHCR mirror ([#959](https://github.com/truecharts/apps/issues/959))
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))

<a name="syncthing-6.11.15"></a>
## [syncthing-6.11.15](https://github.com/truecharts/apps/compare/syncthing-6.11.14...syncthing-6.11.15) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
