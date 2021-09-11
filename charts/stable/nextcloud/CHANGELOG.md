# Changelog<br>


<a name="nextcloud-4.0.6"></a>
### [nextcloud-4.0.6](https://github.com/truecharts/apps/compare/nextcloud-4.0.5...nextcloud-4.0.6) (2021-09-11)

#### Fix

* bump postgresql on nextcloud to a working version



<a name="nextcloud-4.0.5"></a>
### [nextcloud-4.0.5](https://github.com/truecharts/apps/compare/nextcloud-4.0.4...nextcloud-4.0.5) (2021-09-11)

#### Fix

* use correct appversion string



<a name="nextcloud-4.0.4"></a>
### [nextcloud-4.0.4](https://github.com/truecharts/apps/compare/nextcloud-4.0.3...nextcloud-4.0.4) (2021-09-11)

#### Chore

* update nextcloud to latest postgresql and common
* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))

#### Refactor

* change image layout to enable renovate updates of sidecarts ([#955](https://github.com/truecharts/apps/issues/955))



<a name="nextcloud-4.0.3"></a>
### [nextcloud-4.0.3](https://github.com/truecharts/apps/compare/nextcloud-4.0.2...nextcloud-4.0.3) (2021-09-10)

#### Fix

* repair wrong initcontainer format on nextcloud



<a name="nextcloud-4.0.2"></a>
### [nextcloud-4.0.2](https://github.com/truecharts/apps/compare/nextcloud-4.0.1...nextcloud-4.0.2) (2021-09-10)

#### Fix

* update common to ensure initcontainer can always be run as root



<a name="nextcloud-4.0.1"></a>
### [nextcloud-4.0.1](https://github.com/truecharts/apps/compare/nextcloud-4.0.0...nextcloud-4.0.1) (2021-09-10)

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="nextcloud-4.0.0"></a>
### [nextcloud-4.0.0](https://github.com/truecharts/apps/compare/nextcloud-3.7.16...nextcloud-4.0.0) (2021-09-09)

#### Chore

* update Apps containing initcontainers  -not breaking on SCALE- ([#952](https://github.com/truecharts/apps/issues/952))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))



<a name="nextcloud-3.7.16"></a>
### [nextcloud-3.7.16](https://github.com/truecharts/apps/compare/nextcloud-3.7.15...nextcloud-3.7.16) (2021-09-08)

#### Revert

* undo fix tryout for TRUSTED_PROXIES



<a name="nextcloud-3.7.15"></a>
### [nextcloud-3.7.15](https://github.com/truecharts/apps/compare/nextcloud-3.7.14...nextcloud-3.7.15) (2021-09-08)

#### Feat

* Add IPWhitelist, redirectRegex and (internal) nextcloud middlewares ([#929](https://github.com/truecharts/apps/issues/929))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

#### Fix

* Add initcontainer to force refresh TRUSTED_DOMAINS ([#930](https://github.com/truecharts/apps/issues/930))

<a name="nextcloud-3.7.14"></a>
## [nextcloud-3.7.14](https://github.com/truecharts/apps/compare/nextcloud-3.7.13...nextcloud-3.7.14) (2021-09-08)
