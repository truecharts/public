
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
