
<a name="protonmail-bridge-1.9.16"></a>
### [protonmail-bridge-1.9.16](https://github.com/truecharts/apps/compare/protonmail-bridge-1.9.15...protonmail-bridge-1.9.16) (2021-09-12)

#### Chore

* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))
* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))
