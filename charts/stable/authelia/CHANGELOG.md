# Changelog<br>


<a name="authelia-4.0.7"></a>
### [authelia-4.0.7](https://github.com/truecharts/apps/compare/authelia-4.0.6...authelia-4.0.7) (2021-09-28)

#### Chore

* update helm chart postgresql to v3.0.3 ([#1050](https://github.com/truecharts/apps/issues/1050))



<a name="authelia-4.0.6"></a>
### [authelia-4.0.6](https://github.com/truecharts/apps/compare/authelia-4.0.5...authelia-4.0.6) (2021-09-28)

#### Chore

* update helm chart postgresql to v3.0.2 ([#1049](https://github.com/truecharts/apps/issues/1049))



<a name="authelia-4.0.5"></a>
### [authelia-4.0.5](https://github.com/truecharts/apps/compare/authelia-4.0.4...authelia-4.0.5) (2021-09-28)

#### Chore

* update non-major ([#1048](https://github.com/truecharts/apps/issues/1048))
* update non-major ([#1046](https://github.com/truecharts/apps/issues/1046))



<a name="authelia-4.0.4"></a>
### [authelia-4.0.4](https://github.com/truecharts/apps/compare/authelia-4.0.3...authelia-4.0.4) (2021-09-27)

#### Chore

* update helm chart redis to v15.4.0



<a name="authelia-4.0.3"></a>
### [authelia-4.0.3](https://github.com/truecharts/apps/compare/authelia-4.0.2...authelia-4.0.3) (2021-09-27)

#### Chore

* update helm chart postgresql to v3 ([#1041](https://github.com/truecharts/apps/issues/1041))



<a name="authelia-4.0.2"></a>
### [authelia-4.0.2](https://github.com/truecharts/apps/compare/authelia-4.0.0...authelia-4.0.2) (2021-09-26)

#### Chore

* update non-major deps helm releases ([#1040](https://github.com/truecharts/apps/issues/1040))



<a name="authelia-4.0.0"></a>
### [authelia-4.0.0](https://github.com/truecharts/apps/compare/authelia-3.0.9...authelia-4.0.0) (2021-09-26)



<a name="authelia-3.0.9"></a>
### [authelia-3.0.9](https://github.com/truecharts/apps/compare/authelia-3.0.8...authelia-3.0.9) (2021-09-21)

#### Chore

* update helm chart postgresql to v2.2.5 ([#1017](https://github.com/truecharts/apps/issues/1017))



<a name="authelia-3.0.8"></a>
### [authelia-3.0.8](https://github.com/truecharts/apps/compare/authelia-3.0.7...authelia-3.0.8) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="authelia-3.0.7"></a>
### [authelia-3.0.7](https://github.com/truecharts/apps/compare/authelia-3.0.6...authelia-3.0.7) (2021-09-21)

#### Chore

* update non-major ([#1015](https://github.com/truecharts/apps/issues/1015))



<a name="authelia-3.0.6"></a>
### [authelia-3.0.6](https://github.com/truecharts/apps/compare/authelia-3.0.5...authelia-3.0.6) (2021-09-21)

#### Chore

* update non-major ([#1013](https://github.com/truecharts/apps/issues/1013))



<a name="authelia-3.0.5"></a>
### [authelia-3.0.5](https://github.com/truecharts/apps/compare/authelia-3.0.4...authelia-3.0.5) (2021-09-14)

#### Chore

* update non-major ([#987](https://github.com/truecharts/apps/issues/987))



<a name="authelia-3.0.4"></a>
### [authelia-3.0.4](https://github.com/truecharts/apps/compare/authelia-3.0.3...authelia-3.0.4) (2021-09-14)

#### Fix

* fix authelia being broken



<a name="authelia-3.0.3"></a>
### [authelia-3.0.3](https://github.com/truecharts/apps/compare/authelia-3.0.2...authelia-3.0.3) (2021-09-14)

#### Fix

* ensure oidc keys get generated on existing authelia installations



<a name="authelia-3.0.2"></a>
### [authelia-3.0.2](https://github.com/truecharts/apps/compare/authelia-3.0.1...authelia-3.0.2) (2021-09-13)

#### Fix

* use correct authelia tag on SCALE installs



<a name="authelia-3.0.1"></a>
### [authelia-3.0.1](https://github.com/truecharts/apps/compare/authelia-2.0.2...authelia-3.0.1) (2021-09-13)

#### Chore

* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* update non-major
* update non-major

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))



<a name="authelia-2.0.2"></a>
### [authelia-2.0.2](https://github.com/truecharts/apps/compare/authelia-2.0.1...authelia-2.0.2) (2021-09-10)

#### Fix

* update common to ensure initcontainer can always be run as root



<a name="authelia-2.0.1"></a>
### [authelia-2.0.1](https://github.com/truecharts/apps/compare/authelia-2.0.0...authelia-2.0.1) (2021-09-10)

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="authelia-2.0.0"></a>
### [authelia-2.0.0](https://github.com/truecharts/apps/compare/authelia-1.7.3...authelia-2.0.0) (2021-09-09)

#### Chore

* update Apps containing initcontainers  -not breaking on SCALE- ([#952](https://github.com/truecharts/apps/issues/952))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

<a name="authelia-1.7.3"></a>
## [authelia-1.7.3](https://github.com/truecharts/apps/compare/authelia-1.7.2...authelia-1.7.3) (2021-09-08)
