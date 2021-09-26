# Changelog<br>


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
