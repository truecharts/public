# Changelog<br>


<a name="common-8.2.2"></a>
### [common-8.2.2](https://github.com/truecharts/apps/compare/common-8.2.1...common-8.2.2) (2021-10-04)



<a name="common-8.2.1"></a>
### [common-8.2.1](https://github.com/truecharts/apps/compare/common-8.2.0...common-8.2.1) (2021-10-04)



<a name="common-8.2.0"></a>
### [common-8.2.0](https://github.com/truecharts/apps/compare/common-8.1.1...common-8.2.0) (2021-10-04)



<a name="common-8.1.1"></a>
### [common-8.1.1](https://github.com/truecharts/apps/compare/common-8.1.0...common-8.1.1) (2021-10-03)



<a name="common-8.1.0"></a>
### [common-8.1.0](https://github.com/truecharts/apps/compare/common-8.0.13...common-8.1.0) (2021-10-03)



<a name="common-8.0.13"></a>
### [common-8.0.13](https://github.com/truecharts/apps/compare/common-8.0.12...common-8.0.13) (2021-09-29)



<a name="common-8.0.12"></a>
### [common-8.0.12](https://github.com/truecharts/apps/compare/common-8.0.11...common-8.0.12) (2021-09-29)



<a name="common-8.0.10"></a>
### [common-8.0.10](https://github.com/truecharts/apps/compare/common-8.0.9...common-8.0.10) (2021-09-29)



<a name="common-8.0.9"></a>
### [common-8.0.9](https://github.com/truecharts/apps/compare/common-test-3.1.5...common-8.0.9) (2021-09-28)



<a name="common-8.0.8"></a>
### [common-8.0.8](https://github.com/truecharts/apps/compare/common-8.0.7...common-8.0.8) (2021-09-26)



<a name="common-8.0.7"></a>
### [common-8.0.7](https://github.com/truecharts/apps/compare/common-8.0.6...common-8.0.7) (2021-09-26)



<a name="common-8.0.6"></a>
### [common-8.0.6](https://github.com/truecharts/apps/compare/common-8.0.5...common-8.0.6) (2021-09-26)



<a name="common-8.0.4"></a>
### [common-8.0.4](https://github.com/truecharts/apps/compare/common-8.0.3...common-8.0.4) (2021-09-25)



<a name="common-8.0.3"></a>
### [common-8.0.3](https://github.com/truecharts/apps/compare/common-test-3.1.4...common-8.0.3) (2021-09-25)



<a name="common-8.0.2"></a>
### [common-8.0.2](https://github.com/truecharts/apps/compare/common-8.0.1...common-8.0.2) (2021-09-25)



<a name="common-8.0.1"></a>
### [common-8.0.1](https://github.com/truecharts/apps/compare/common-8.0.0...common-8.0.1) (2021-09-25)



<a name="common-8.0.0"></a>
### [common-8.0.0](https://github.com/truecharts/apps/compare/common-test-3.1.3...common-8.0.0) (2021-09-25)



<a name="common-7.0.14"></a>
### [common-7.0.14](https://github.com/truecharts/apps/compare/common-7.0.13...common-7.0.14) (2021-09-14)

#### Fix

* make sure autopermissions sets the group owner correctly ([#994](https://github.com/truecharts/apps/issues/994))



<a name="common-7.0.13"></a>
### [common-7.0.13](https://github.com/truecharts/apps/compare/common-7.0.12...common-7.0.13) (2021-09-14)

#### Chore

* update non-major ([#987](https://github.com/truecharts/apps/issues/987))



<a name="common-7.0.12"></a>
### [common-7.0.12](https://github.com/truecharts/apps/compare/common-7.0.11...common-7.0.12) (2021-09-13)

#### Fix

* ensure wireguard env vars get created



<a name="common-7.0.11"></a>
### [common-7.0.11](https://github.com/truecharts/apps/compare/common-7.0.10...common-7.0.11) (2021-09-12)

#### Fix

* nuke all VPN volumes that we don't use (yet) out of Common



<a name="common-7.0.10"></a>
### [common-7.0.10](https://github.com/truecharts/apps/compare/common-7.0.9...common-7.0.10) (2021-09-12)

#### Fix

* completely remove unused volumes and correctly enable used volumes for VPN



<a name="common-7.0.9"></a>
### [common-7.0.9](https://github.com/truecharts/apps/compare/common-7.0.7...common-7.0.9) (2021-09-12)

#### Fix

* remove old configmap and secret references for VPN config/scripts



<a name="common-7.0.7"></a>
### [common-7.0.7](https://github.com/truecharts/apps/compare/common-7.0.6...common-7.0.7) (2021-09-12)

#### Fix

* correct vpn securityContext



<a name="common-7.0.6"></a>
### [common-7.0.6](https://github.com/truecharts/apps/compare/common-7.0.5...common-7.0.6) (2021-09-12)



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
