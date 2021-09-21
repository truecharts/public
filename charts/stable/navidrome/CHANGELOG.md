# Changelog<br>


<a name="navidrome-7.0.2"></a>
### [navidrome-7.0.2](https://github.com/truecharts/apps/compare/navidrome-7.0.1...navidrome-7.0.2) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="navidrome-7.0.1"></a>
### [navidrome-7.0.1](https://github.com/truecharts/apps/compare/navidrome-6.11.15...navidrome-7.0.1) (2021-09-13)

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

<a name="navidrome-6.11.15"></a>
## [navidrome-6.11.15](https://github.com/truecharts/apps/compare/navidrome-6.11.14...navidrome-6.11.15) (2021-09-08)

### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
