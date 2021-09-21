# Changelog<br>


<a name="vaultwarden-8.0.5"></a>
### [vaultwarden-8.0.5](https://github.com/truecharts/apps/compare/vaultwarden-8.0.4...vaultwarden-8.0.5) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="vaultwarden-8.0.4"></a>
### [vaultwarden-8.0.4](https://github.com/truecharts/apps/compare/vaultwarden-8.0.3...vaultwarden-8.0.4) (2021-09-21)

#### Chore

* update non-major ([#1015](https://github.com/truecharts/apps/issues/1015))



<a name="vaultwarden-8.0.3"></a>
### [vaultwarden-8.0.3](https://github.com/truecharts/apps/compare/vaultwarden-8.0.2...vaultwarden-8.0.3) (2021-09-21)

#### Chore

* update non-major ([#1013](https://github.com/truecharts/apps/issues/1013))



<a name="vaultwarden-8.0.2"></a>
### [vaultwarden-8.0.2](https://github.com/truecharts/apps/compare/vaultwarden-8.0.1...vaultwarden-8.0.2) (2021-09-14)

#### Chore

* update non-major ([#987](https://github.com/truecharts/apps/issues/987))



<a name="vaultwarden-8.0.1"></a>
### [vaultwarden-8.0.1](https://github.com/truecharts/apps/compare/vaultwarden-7.0.2...vaultwarden-8.0.1) (2021-09-13)

#### Chore

* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* move more dockerhub containers to GHCR mirror ([#958](https://github.com/truecharts/apps/issues/958))
* update non-major
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))



<a name="vaultwarden-7.0.2"></a>
### [vaultwarden-7.0.2](https://github.com/truecharts/apps/compare/vaultwarden-7.0.1...vaultwarden-7.0.2) (2021-09-10)

#### Fix

* update common to ensure initcontainer can always be run as root



<a name="vaultwarden-7.0.1"></a>
### [vaultwarden-7.0.1](https://github.com/truecharts/apps/compare/vaultwarden-7.0.0...vaultwarden-7.0.1) (2021-09-10)

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="vaultwarden-7.0.0"></a>
### [vaultwarden-7.0.0](https://github.com/truecharts/apps/compare/vaultwarden-6.1.12...vaultwarden-7.0.0) (2021-09-09)

#### Chore

* update Apps containing initcontainers  -not breaking on SCALE- ([#952](https://github.com/truecharts/apps/issues/952))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

#### Fix

* Inject vaultwarden websocket part into ingress ([#946](https://github.com/truecharts/apps/issues/946))

<a name="vaultwarden-6.1.12"></a>
## [vaultwarden-6.1.12](https://github.com/truecharts/apps/compare/vaultwarden-6.1.11...vaultwarden-6.1.12) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
