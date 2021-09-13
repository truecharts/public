# Changelog<br>


<a name="postgresql-2.2.0"></a>
### [postgresql-2.2.0](https://github.com/truecharts/apps/compare/postgresql-2.1.1...postgresql-2.2.0) (2021-09-13)

#### Chore

* update non-major

#### Feat

* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))



<a name="postgresql-2.1.1"></a>
### [postgresql-2.1.1](https://github.com/truecharts/apps/compare/postgresql-2.1.0...postgresql-2.1.1) (2021-09-11)

#### Fix

* use correct appversion string



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



<a name="postgresql-2.0.0"></a>
### [postgresql-2.0.0](https://github.com/truecharts/apps/compare/postgresql-1.6.6...postgresql-2.0.0) (2021-09-09)

#### Chore

* fix postgresql version



<a name="postgresql-1.6.6"></a>
### [postgresql-1.6.6](https://github.com/truecharts/apps/compare/postgresql-1.6.5...postgresql-1.6.6) (2021-09-09)

#### Chore

* update postrgresql to common 7.0.0 ([#951](https://github.com/truecharts/apps/issues/951))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))

#### Fix

* repair Hyperion and some misplaced GUI elements ([#922](https://github.com/truecharts/apps/issues/922))
