# Changelog<br>


<a name="jellyfin-8.0.0"></a>
### [jellyfin-8.0.0](https://github.com/truecharts/apps/compare/jellyfin-7.0.2...jellyfin-8.0.0) (2021-09-26)



<a name="jellyfin-7.0.2"></a>
### [jellyfin-7.0.2](https://github.com/truecharts/apps/compare/jellyfin-7.0.1...jellyfin-7.0.2) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="jellyfin-7.0.1"></a>
### [jellyfin-7.0.1](https://github.com/truecharts/apps/compare/jellyfin-6.11.16...jellyfin-7.0.1) (2021-09-13)

#### Chore

* move more dockerhub containers to GHCR mirror ([#958](https://github.com/truecharts/apps/issues/958))
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))

<a name="jellyfin-6.11.16"></a>
## [jellyfin-6.11.16](https://github.com/truecharts/apps/compare/jellyfin-6.11.15...jellyfin-6.11.16) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
