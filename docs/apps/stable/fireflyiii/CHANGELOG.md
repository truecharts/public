# Changelog<br>


<a name="fireflyiii-9.0.3"></a>
### [fireflyiii-9.0.3](https://github.com/truecharts/apps/compare/fireflyiii-9.0.2...fireflyiii-9.0.3) (2021-09-28)

#### Chore

* update non-major ([#1046](https://github.com/truecharts/apps/issues/1046))



<a name="fireflyiii-9.0.2"></a>
### [fireflyiii-9.0.2](https://github.com/truecharts/apps/compare/fireflyiii-9.0.1...fireflyiii-9.0.2) (2021-09-27)

#### Chore

* update helm chart postgresql to v3 ([#1041](https://github.com/truecharts/apps/issues/1041))



<a name="fireflyiii-9.0.1"></a>
### [fireflyiii-9.0.1](https://github.com/truecharts/apps/compare/fireflyiii-9.0.0...fireflyiii-9.0.1) (2021-09-26)



<a name="fireflyiii-9.0.0"></a>
### [fireflyiii-9.0.0](https://github.com/truecharts/apps/compare/fireflyiii-8.0.6...fireflyiii-9.0.0) (2021-09-26)



<a name="fireflyiii-8.0.6"></a>
### [fireflyiii-8.0.6](https://github.com/truecharts/apps/compare/fireflyiii-8.0.5...fireflyiii-8.0.6) (2021-09-21)

#### Chore

* update helm chart postgresql to v2.2.5 ([#1017](https://github.com/truecharts/apps/issues/1017))



<a name="fireflyiii-8.0.5"></a>
### [fireflyiii-8.0.5](https://github.com/truecharts/apps/compare/fireflyiii-8.0.4...fireflyiii-8.0.5) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="fireflyiii-8.0.4"></a>
### [fireflyiii-8.0.4](https://github.com/truecharts/apps/compare/fireflyiii-8.0.3...fireflyiii-8.0.4) (2021-09-21)

#### Chore

* update non-major ([#1015](https://github.com/truecharts/apps/issues/1015))



<a name="fireflyiii-8.0.3"></a>
### [fireflyiii-8.0.3](https://github.com/truecharts/apps/compare/fireflyiii-8.0.2...fireflyiii-8.0.3) (2021-09-21)

#### Chore

* update non-major ([#1013](https://github.com/truecharts/apps/issues/1013))



<a name="fireflyiii-8.0.2"></a>
### [fireflyiii-8.0.2](https://github.com/truecharts/apps/compare/fireflyiii-8.0.1...fireflyiii-8.0.2) (2021-09-14)

#### Chore

* update non-major ([#987](https://github.com/truecharts/apps/issues/987))



<a name="fireflyiii-8.0.1"></a>
### [fireflyiii-8.0.1](https://github.com/truecharts/apps/compare/fireflyiii-7.0.2...fireflyiii-8.0.1) (2021-09-13)

#### Chore

* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* update non-major
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))



<a name="fireflyiii-7.0.2"></a>
### [fireflyiii-7.0.2](https://github.com/truecharts/apps/compare/fireflyiii-7.0.1...fireflyiii-7.0.2) (2021-09-10)

#### Fix

* update common to ensure initcontainer can always be run as root



<a name="fireflyiii-7.0.1"></a>
### [fireflyiii-7.0.1](https://github.com/truecharts/apps/compare/fireflyiii-7.0.0...fireflyiii-7.0.1) (2021-09-10)

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="fireflyiii-7.0.0"></a>
### [fireflyiii-7.0.0](https://github.com/truecharts/apps/compare/fireflyiii-6.1.10...fireflyiii-7.0.0) (2021-09-09)

#### Chore

* update Apps containing initcontainers  -not breaking on SCALE- ([#952](https://github.com/truecharts/apps/issues/952))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

#### Fix

* correct fireflyiii ports and services ([#945](https://github.com/truecharts/apps/issues/945))

<a name="fireflyiii-6.1.10"></a>
## [fireflyiii-6.1.10](https://github.com/truecharts/apps/compare/fireflyiii-6.1.9...fireflyiii-6.1.10) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
