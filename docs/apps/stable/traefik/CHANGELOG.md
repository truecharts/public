# Changelog<br>


<a name="traefik-9.0.8"></a>
### [traefik-9.0.8](https://github.com/truecharts/apps/compare/traefik-9.0.7...traefik-9.0.8) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1123](https://github.com/truecharts/apps/issues/1123))



<a name="traefik-9.0.7"></a>
### [traefik-9.0.7](https://github.com/truecharts/apps/compare/traefik-9.0.6...traefik-9.0.7) (2021-10-05)

#### Chore

* update non-major deps helm releases ([#1099](https://github.com/truecharts/apps/issues/1099))



<a name="traefik-9.0.6"></a>
### [traefik-9.0.6](https://github.com/truecharts/apps/compare/traefik-9.0.5...traefik-9.0.6) (2021-10-02)



<a name="traefik-9.0.5"></a>
### [traefik-9.0.5](https://github.com/truecharts/apps/compare/traefik-9.0.4...traefik-9.0.5) (2021-10-01)



<a name="traefik-9.0.4"></a>
### [traefik-9.0.4](https://github.com/truecharts/apps/compare/traefik-9.0.3...traefik-9.0.4) (2021-10-01)



<a name="traefik-9.0.3"></a>
### [traefik-9.0.3](https://github.com/truecharts/apps/compare/traefik-9.0.2...traefik-9.0.3) (2021-09-29)

#### Chore

* update helm chart common to v8.0.13 ([#1060](https://github.com/truecharts/apps/issues/1060))



<a name="traefik-9.0.1"></a>
### [traefik-9.0.1](https://github.com/truecharts/apps/compare/traefik-9.0.0...traefik-9.0.1) (2021-09-26)



<a name="traefik-9.0.0"></a>
### [traefik-9.0.0](https://github.com/truecharts/apps/compare/traefik-8.0.4...traefik-9.0.0) (2021-09-26)



<a name="traefik-8.0.4"></a>
### [traefik-8.0.4](https://github.com/truecharts/apps/compare/traefik-8.0.3...traefik-8.0.4) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="traefik-8.0.3"></a>
### [traefik-8.0.3](https://github.com/truecharts/apps/compare/traefik-8.0.2...traefik-8.0.3) (2021-09-21)

#### Chore

* update non-major ([#1013](https://github.com/truecharts/apps/issues/1013))



<a name="traefik-8.0.2"></a>
### [traefik-8.0.2](https://github.com/truecharts/apps/compare/traefik-8.0.1...traefik-8.0.2) (2021-09-16)

#### Fix

* ensure traefik TLSOPtions get rendered correctly



<a name="traefik-8.0.1"></a>
### [traefik-8.0.1](https://github.com/truecharts/apps/compare/traefik-7.1.4...traefik-8.0.1) (2021-09-13)

#### Chore

* move most remaining Apps to GHCR mirror ([#959](https://github.com/truecharts/apps/issues/959))
* move more dockerhub containers to GHCR mirror ([#958](https://github.com/truecharts/apps/issues/958))
* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))



<a name="traefik-7.1.4"></a>
### [traefik-7.1.4](https://github.com/truecharts/apps/compare/traefik-7.1.3...traefik-7.1.4) (2021-09-08)

#### Fix

* remove non-functional redirectmiddelwares for nextcloud



<a name="traefik-7.1.3"></a>
### [traefik-7.1.3](https://github.com/truecharts/apps/compare/traefik-7.1.2...traefik-7.1.3) (2021-09-08)

#### Fix

* correct nextcloud middleware namespaces



<a name="traefik-7.1.2"></a>
### [traefik-7.1.2](https://github.com/truecharts/apps/compare/traefik-7.1.1...traefik-7.1.2) (2021-09-08)

#### Fix

* only release when version is bumped
* use fixed version for traefik container for consistency



<a name="traefik-7.1.1"></a>
### [traefik-7.1.1](https://github.com/truecharts/apps/compare/traefik-7.1.0...traefik-7.1.1) (2021-09-08)

#### Fix

* fix release pipeline picking wrong file for appversion generation



<a name="traefik-7.1.0"></a>
### [traefik-7.1.0](https://github.com/truecharts/apps/compare/traefik-7.0.11...traefik-7.1.0) (2021-09-08)

#### Feat

* Add IPWhitelist, redirectRegex and (internal) nextcloud middlewares ([#929](https://github.com/truecharts/apps/issues/929))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

<a name="traefik-7.0.11"></a>
## [traefik-7.0.11](https://github.com/truecharts/apps/compare/traefik-7.0.10...traefik-7.0.11) (2021-09-08)
