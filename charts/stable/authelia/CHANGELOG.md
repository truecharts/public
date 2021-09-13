# Changelog<br>


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
