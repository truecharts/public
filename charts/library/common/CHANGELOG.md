# Changelog<br>


<a name="common-7.0.5"></a>
### [common-7.0.5](https://github.com/truecharts/apps/compare/common-7.0.4...common-7.0.5) (2021-09-12)

#### Fix

* ensure annotationLists and labelLists don't get processed for disabled objects ([#971](https://github.com/truecharts/apps/issues/971))



<a name="common-7.0.4"></a>
### [common-7.0.4](https://github.com/truecharts/apps/compare/common-7.0.3...common-7.0.4) (2021-09-12)

#### Chore

* update non-major ([#962](https://github.com/truecharts/apps/issues/962))

#### Feat

* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))

#### Improv

* improve dns and vpn values.yaml syntaxis ([#970](https://github.com/truecharts/apps/issues/970))



<a name="common-7.0.3"></a>
### [common-7.0.3](https://github.com/truecharts/apps/compare/common-7.0.2...common-7.0.3) (2021-09-11)

#### Chore

* move more dockerhub containers to GHCR mirror ([#958](https://github.com/truecharts/apps/issues/958))

#### Fix

* remove duplicate securitycontext from autopermissions



<a name="common-7.0.2"></a>
### [common-7.0.2](https://github.com/truecharts/apps/compare/common-7.0.1...common-7.0.2) (2021-09-10)

#### Feat

* Move some common containers to our own containers

#### Refactor

* change image layout to enable renovate updates of sidecarts ([#955](https://github.com/truecharts/apps/issues/955))



<a name="common-7.0.1"></a>
### [common-7.0.1](https://github.com/truecharts/apps/compare/common-7.0.0...common-7.0.1) (2021-09-10)

#### Feat

* have VPN use a hostPath for the configfile instead of configmap ([#953](https://github.com/truecharts/apps/issues/953))

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="common-7.0.0"></a>
### [common-7.0.0](https://github.com/truecharts/apps/compare/common-6.14.0...common-7.0.0) (2021-09-09)

#### Refactor

* Restructure common init and additional container layout to dicts ([#950](https://github.com/truecharts/apps/issues/950))



<a name="common-6.14.0"></a>
### [common-6.14.0](https://github.com/truecharts/apps/compare/common-6.13.11...common-6.14.0) (2021-09-09)

#### Feat

* port addons from k8s-at-home to common ([#948](https://github.com/truecharts/apps/issues/948))



<a name="common-6.13.11"></a>
### [common-6.13.11](https://github.com/truecharts/apps/compare/common-6.13.10...common-6.13.11) (2021-09-09)

#### Chore

* update common test dependencies ([#949](https://github.com/truecharts/apps/issues/949))



<a name="common-6.13.10"></a>
### [common-6.13.10](https://github.com/truecharts/apps/compare/common-6.13.9...common-6.13.10) (2021-09-09)

#### Fix

* ensure supplementalgroups when using devices are actually added ([#942](https://github.com/truecharts/apps/issues/942))
