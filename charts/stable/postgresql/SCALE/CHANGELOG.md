
<a name="postgresql-2.1.0"></a>
### [postgresql-2.1.0](https://github.com/truecharts/apps/compare/postgresql-2.0.0...postgresql-2.1.0) (2021-09-11)

#### Chore

* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* update non-major

#### Feat

* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))
* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))
