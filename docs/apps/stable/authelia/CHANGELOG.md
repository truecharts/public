# Changelog<br>


<a name="authelia-8.0.29"></a>
### [authelia-8.0.29](https://github.com/truecharts/apps/compare/authelia-8.0.28...authelia-8.0.29) (2022-01-21)

#### Chore

* update helm general non-major helm releases ([#1759](https://github.com/truecharts/apps/issues/1759))

#### Fix

* set additional_attrs: true on all dicts ([#1750](https://github.com/truecharts/apps/issues/1750))



<a name="authelia-8.0.28"></a>
### [authelia-8.0.28](https://github.com/truecharts/apps/compare/authelia-8.0.27...authelia-8.0.28) (2022-01-18)

#### Chore

* update helm general non-major helm releases ([#1732](https://github.com/truecharts/apps/issues/1732))



<a name="authelia-8.0.27"></a>
### [authelia-8.0.27](https://github.com/truecharts/apps/compare/authelia-8.0.26...authelia-8.0.27) (2022-01-13)

#### Chore

* update helm general non-major helm releases ([#1712](https://github.com/truecharts/apps/issues/1712))

#### Feat

* expose capabilities in GUI ([#1709](https://github.com/truecharts/apps/issues/1709))



<a name="authelia-8.0.26"></a>
### [authelia-8.0.26](https://github.com/truecharts/apps/compare/authelia-8.0.25...authelia-8.0.26) (2022-01-12)

#### Chore

* update helm general non-major helm releases ([#1704](https://github.com/truecharts/apps/issues/1704))



<a name="authelia-8.0.25"></a>
### [authelia-8.0.25](https://github.com/truecharts/apps/compare/authelia-8.0.24...authelia-8.0.25) (2022-01-11)

#### Chore

* update helm general non-major helm releases ([#1693](https://github.com/truecharts/apps/issues/1693))



<a name="authelia-8.0.24"></a>
### [authelia-8.0.24](https://github.com/truecharts/apps/compare/authelia-8.0.23...authelia-8.0.24) (2022-01-09)

#### Fix

* fix logic in tpl ([#1668](https://github.com/truecharts/apps/issues/1668))



<a name="authelia-8.0.23"></a>
### [authelia-8.0.23](https://github.com/truecharts/apps/compare/authelia-8.0.22...authelia-8.0.23) (2022-01-04)

#### Chore

* update helm general non-major helm releases



<a name="authelia-8.0.22"></a>
### [authelia-8.0.22](https://github.com/truecharts/apps/compare/authelia-8.0.21...authelia-8.0.22) (2021-12-28)

#### Chore

* update helm general non-major helm releases ([#1623](https://github.com/truecharts/apps/issues/1623))



<a name="authelia-8.0.21"></a>
### [authelia-8.0.21](https://github.com/truecharts/apps/compare/authelia-8.0.20...authelia-8.0.21) (2021-12-21)

#### Chore

* update helm general non-major helm releases ([#1596](https://github.com/truecharts/apps/issues/1596))



<a name="authelia-8.0.20"></a>
### [authelia-8.0.20](https://github.com/truecharts/apps/compare/authelia-8.0.19...authelia-8.0.20) (2021-12-19)

#### Chore

* Last patch bump before RC2 branch-off
* remove hidden vars/configs from `questions.yaml` after making sure they are defined in `values.yaml` ([#1577](https://github.com/truecharts/apps/issues/1577))
* remove `editable: true` as this is the default ([#1576](https://github.com/truecharts/apps/issues/1576))



<a name="authelia-8.0.19"></a>
### [authelia-8.0.19](https://github.com/truecharts/apps/compare/authelia-8.0.18...authelia-8.0.19) (2021-12-19)

#### Chore

* completely remove mountPath reference from GUI ([#1572](https://github.com/truecharts/apps/issues/1572))
* update helm general non-major helm releases ([#1571](https://github.com/truecharts/apps/issues/1571))



<a name="authelia-8.0.18"></a>
### [authelia-8.0.18](https://github.com/truecharts/apps/compare/authelia-8.0.17...authelia-8.0.18) (2021-12-18)

#### Chore

* cleanup questions by removing hidden dicts ([#1558](https://github.com/truecharts/apps/issues/1558))
* App-Icon Organization ([#1539](https://github.com/truecharts/apps/issues/1539))



<a name="authelia-8.0.17"></a>
### [authelia-8.0.17](https://github.com/truecharts/apps/compare/authelia-8.0.16...authelia-8.0.17) (2021-12-14)

#### Chore

* update helm general non-major helm releases ([#1535](https://github.com/truecharts/apps/issues/1535))



<a name="authelia-8.0.16"></a>
### [authelia-8.0.16](https://github.com/truecharts/apps/compare/authelia-8.0.15...authelia-8.0.16) (2021-12-13)

#### Chore

* move incubator apps to stable and bump everything



<a name="authelia-8.0.15"></a>
### [authelia-8.0.15](https://github.com/truecharts/apps/compare/authelia-8.0.14...authelia-8.0.15) (2021-12-11)

#### Chore

* update general helm non-major helm releases ([#1509](https://github.com/truecharts/apps/issues/1509))



<a name="authelia-8.0.14"></a>
### [authelia-8.0.14](https://github.com/truecharts/apps/compare/authelia-8.0.13...authelia-8.0.14) (2021-12-07)

#### Chore

* update non-major deps helm releases ([#1481](https://github.com/truecharts/apps/issues/1481))



<a name="authelia-8.0.13"></a>
### [authelia-8.0.13](https://github.com/truecharts/apps/compare/authelia-8.0.12...authelia-8.0.13) (2021-12-05)

#### Fix

* correct upgrade handling without encryption key



<a name="authelia-8.0.12"></a>
### authelia-8.0.12 (2021-12-05)

#### Chore

* bump apps to generate security page
* ensure container references are prefixed with v
* move all container references to TCCR ([#1448](https://github.com/truecharts/apps/issues/1448))
* cleanup the ci for the security page a bit
* update non-major deps helm releases ([#1471](https://github.com/truecharts/apps/issues/1471))
* update non-major deps helm releases ([#1453](https://github.com/truecharts/apps/issues/1453))
* update non-major ([#1449](https://github.com/truecharts/apps/issues/1449))
* update non-major deps helm releases ([#1468](https://github.com/truecharts/apps/issues/1468))
* update non-major ([#1466](https://github.com/truecharts/apps/issues/1466))
* update non-major deps helm releases ([#1432](https://github.com/truecharts/apps/issues/1432))

#### Fix

* misc fixes
* fix typo in theme selection ([#1428](https://github.com/truecharts/apps/issues/1428))



<a name="authelia-8.0.11"></a>
### [authelia-8.0.11](https://github.com/truecharts/apps/compare/authelia-8.0.10...authelia-8.0.11) (2021-12-05)

#### Chore

* update non-major deps helm releases ([#1468](https://github.com/truecharts/apps/issues/1468))



<a name="authelia-8.0.10"></a>
### [authelia-8.0.10](https://github.com/truecharts/apps/compare/authelia-8.0.9...authelia-8.0.10) (2021-12-05)

#### Chore

* update non-major ([#1466](https://github.com/truecharts/apps/issues/1466))



<a name="authelia-8.0.9"></a>
### [authelia-8.0.9](https://github.com/truecharts/apps/compare/authelia-8.0.8...authelia-8.0.9) (2021-12-04)

#### Chore

* bump apps to generate security page
* cleanup the ci for the security page a bit



<a name="authelia-8.0.8"></a>
### [authelia-8.0.8](https://github.com/truecharts/apps/compare/authelia-8.0.7...authelia-8.0.8) (2021-12-04)

#### Chore

* update non-major deps helm releases ([#1453](https://github.com/truecharts/apps/issues/1453))



<a name="authelia-8.0.7"></a>
### [authelia-8.0.7](https://github.com/truecharts/apps/compare/authelia-8.0.6...authelia-8.0.7) (2021-12-03)

#### Fix

* misc fixes



<a name="authelia-8.0.6"></a>
### [authelia-8.0.6](https://github.com/truecharts/apps/compare/authelia-8.0.5...authelia-8.0.6) (2021-12-03)

#### Chore

* ensure container references are prefixed with v
* move all container references to TCCR ([#1448](https://github.com/truecharts/apps/issues/1448))
* update non-major ([#1449](https://github.com/truecharts/apps/issues/1449))



<a name="authelia-8.0.5"></a>
### [authelia-8.0.5](https://github.com/truecharts/apps/compare/authelia-8.0.4...authelia-8.0.5) (2021-11-30)

#### Chore

* revert authelia default ports change
* update non-major deps helm releases ([#1432](https://github.com/truecharts/apps/issues/1432))

#### Fix

* correct some ports mistakes ([#1416](https://github.com/truecharts/apps/issues/1416))
* move conflicting ports to 10xxx range ([#1415](https://github.com/truecharts/apps/issues/1415))
* fix typo in theme selection ([#1428](https://github.com/truecharts/apps/issues/1428))



<a name="authelia-8.0.4"></a>
### [authelia-8.0.4](https://github.com/truecharts/apps/compare/authelia-8.0.3...authelia-8.0.4) (2021-11-23)

#### Chore

* update non-major deps helm releases ([#1386](https://github.com/truecharts/apps/issues/1386))



<a name="authelia-8.0.3"></a>
### [authelia-8.0.3](https://github.com/truecharts/apps/compare/authelia-8.0.2...authelia-8.0.3) (2021-11-22)

#### Chore

* update non-major deps helm releases ([#1383](https://github.com/truecharts/apps/issues/1383))



<a name="authelia-8.0.2"></a>
### [authelia-8.0.2](https://github.com/truecharts/apps/compare/authelia-8.0.1...authelia-8.0.2) (2021-11-16)

#### Chore

* update non-major deps helm releases ([#1345](https://github.com/truecharts/apps/issues/1345))



<a name="authelia-8.0.1"></a>
### [authelia-8.0.1](https://github.com/truecharts/apps/compare/authelia-8.0.0...authelia-8.0.1) (2021-11-16)

#### Chore

* bump postgresql again



<a name="authelia-8.0.0"></a>
### [authelia-8.0.0](https://github.com/truecharts/apps/compare/authelia-7.0.12...authelia-8.0.0) (2021-11-16)

#### Chore

* bump postgresql on some Apps



<a name="authelia-7.0.12"></a>
### [authelia-7.0.12](https://github.com/truecharts/apps/compare/authelia-7.0.11...authelia-7.0.12) (2021-11-15)

#### Chore

* persistence cleanup and small bugfixes ([#1329](https://github.com/truecharts/apps/issues/1329))
* update non-major deps helm releases ([#1338](https://github.com/truecharts/apps/issues/1338))



<a name="authelia-7.0.11"></a>
### [authelia-7.0.11](https://github.com/truecharts/apps/compare/authelia-7.0.10...authelia-7.0.11) (2021-11-14)

#### Chore

* fixes around the GUI refactor ([#1316](https://github.com/truecharts/apps/issues/1316))
* move port above advanced in GUI ([#1326](https://github.com/truecharts/apps/issues/1326))
* clean up Chart.yaml ([#1322](https://github.com/truecharts/apps/issues/1322))
* update non-major deps helm releases ([#1328](https://github.com/truecharts/apps/issues/1328))



<a name="authelia-7.0.10"></a>
### [authelia-7.0.10](https://github.com/truecharts/apps/compare/authelia-7.0.9...authelia-7.0.10) (2021-11-12)

#### Feat

* use our own redis chart ([#1312](https://github.com/truecharts/apps/issues/1312))

#### Fix

* Allow spaces in paths ([#1306](https://github.com/truecharts/apps/issues/1306))



<a name="authelia-7.0.9"></a>
### [authelia-7.0.9](https://github.com/truecharts/apps/compare/authelia-7.0.8...authelia-7.0.9) (2021-11-09)

#### Chore

* update non-major deps helm releases ([#1297](https://github.com/truecharts/apps/issues/1297))



<a name="authelia-7.0.8"></a>
### [authelia-7.0.8](https://github.com/truecharts/apps/compare/authelia-7.0.7...authelia-7.0.8) (2021-11-07)

#### Chore

* update non-major deps helm releases ([#1295](https://github.com/truecharts/apps/issues/1295))



<a name="authelia-7.0.7"></a>
### [authelia-7.0.7](https://github.com/truecharts/apps/compare/authelia-7.0.6...authelia-7.0.7) (2021-11-07)

#### Chore

* update non-major deps helm releases ([#1291](https://github.com/truecharts/apps/issues/1291))

#### Chore

* Simplify GUI for deployment, persistence and securityContext ([#1289](https://github.com/truecharts/apps/issues/1289))

#### Feat

* Simplify the Services GUI ([#1290](https://github.com/truecharts/apps/issues/1290))



<a name="authelia-7.0.6"></a>
### [authelia-7.0.6](https://github.com/truecharts/apps/compare/authelia-7.0.5...authelia-7.0.6) (2021-11-02)

#### Chore

* update non-major deps helm releases ([#1267](https://github.com/truecharts/apps/issues/1267))



<a name="authelia-7.0.5"></a>
### [authelia-7.0.5](https://github.com/truecharts/apps/compare/authelia-7.0.4...authelia-7.0.5) (2021-11-01)

#### Chore

* update non-major deps helm releases ([#1264](https://github.com/truecharts/apps/issues/1264))



<a name="authelia-7.0.4"></a>
### [authelia-7.0.4](https://github.com/truecharts/apps/compare/authelia-7.0.3...authelia-7.0.4) (2021-10-26)

#### Chore

* update helm chart postgresql to v5.1.4 ([#1249](https://github.com/truecharts/apps/issues/1249))



<a name="authelia-7.0.3"></a>
### [authelia-7.0.3](https://github.com/truecharts/apps/compare/authelia-7.0.2...authelia-7.0.3) (2021-10-26)

#### Chore

* update non-major deps helm releases ([#1247](https://github.com/truecharts/apps/issues/1247))



<a name="authelia-7.0.2"></a>
### [authelia-7.0.2](https://github.com/truecharts/apps/compare/authelia-7.0.1...authelia-7.0.2) (2021-10-26)

#### Chore

* update non-major deps helm releases ([#1245](https://github.com/truecharts/apps/issues/1245))



<a name="authelia-7.0.1"></a>
### [authelia-7.0.1](https://github.com/truecharts/apps/compare/authelia-7.0.0...authelia-7.0.1) (2021-10-26)

#### Chore

* update helm chart common to v8.3.15 ([#1240](https://github.com/truecharts/apps/issues/1240))



<a name="authelia-7.0.0"></a>
### [authelia-7.0.0](https://github.com/truecharts/apps/compare/authelia-6.0.5...authelia-7.0.0) (2021-10-26)

#### Chore

* update helm chart postgresql to v5 ([#1234](https://github.com/truecharts/apps/issues/1234))



<a name="authelia-6.0.5"></a>
### [authelia-6.0.5](https://github.com/truecharts/apps/compare/authelia-5.1.0...authelia-6.0.5) (2021-10-26)



<a name="authelia-5.1.0"></a>
### [authelia-5.1.0](https://github.com/truecharts/apps/compare/authelia-6.0.1...authelia-5.1.0) (2021-10-26)

#### Fix

* fix patch for important postgresql consumping apps



<a name="authelia-6.0.1"></a>
### [authelia-6.0.1](https://github.com/truecharts/apps/compare/authelia-6.0.0...authelia-6.0.1) (2021-10-26)

#### Chore

* update non-major deps helm releases



<a name="authelia-6.0.0"></a>
### [authelia-6.0.0](https://github.com/truecharts/apps/compare/authelia-5.0.3...authelia-6.0.0) (2021-10-25)

#### Chore

* Adapt for TrueNAS SCALE RC1



<a name="authelia-5.0.3"></a>
### [authelia-5.0.3](https://github.com/truecharts/apps/compare/authelia-5.0.2...authelia-5.0.3) (2021-10-20)

#### Chore

* bump apps, remove duplicates and move incubator to stable for RC1



<a name="authelia-5.0.0"></a>
### [authelia-5.0.0](https://github.com/truecharts/apps/compare/authelia-4.0.25...authelia-5.0.0) (2021-10-20)

#### Chore

* update helm chart postgresql to v4 ([#1214](https://github.com/truecharts/apps/issues/1214))

#### Fix

* use correct PVC storageClass when using postgresql as a dependency on SCALE ([#1212](https://github.com/truecharts/apps/issues/1212))



<a name="authelia-4.0.25"></a>
### [authelia-4.0.25](https://github.com/truecharts/apps/compare/authelia-4.0.24...authelia-4.0.25) (2021-10-20)

#### Chore

* bump versions to rerelease and fix icons



<a name="authelia-4.0.24"></a>
### [authelia-4.0.24](https://github.com/truecharts/apps/compare/authelia-4.0.23...authelia-4.0.24) (2021-10-19)

#### Change

* Project-Eclipse 3, Automatically generate item.yaml ([#1178](https://github.com/truecharts/apps/issues/1178))

#### Chore

* Project-Eclipse 5, move app-readme to automatic generation script ([#1181](https://github.com/truecharts/apps/issues/1181))
* update helm chart common to v8.3.13 ([#1184](https://github.com/truecharts/apps/issues/1184))

#### Feat

* Project-Eclipse 4, Add App grading annotations to Chart.yaml ([#1180](https://github.com/truecharts/apps/issues/1180))

#### Refactor

* Project Eclipse Part 6, move questions.yaml to root App folder ([#1182](https://github.com/truecharts/apps/issues/1182))



<a name="authelia-4.0.23"></a>
### [authelia-4.0.23](https://github.com/truecharts/apps/compare/authelia-4.0.22...authelia-4.0.23) (2021-10-19)

#### Chore

* Project-Eclipse part 2, adapting and cleaning changelog ([#1173](https://github.com/truecharts/apps/issues/1173))
* update helm chart postgresql to v3.0.20 ([#1177](https://github.com/truecharts/apps/issues/1177))



<a name="authelia-4.0.22"></a>
### [authelia-4.0.22](https://github.com/truecharts/apps/compare/authelia-4.0.21...authelia-4.0.22) (2021-10-19)

#### Fix

* fix previous SCALE bugfix not correctly being applied



<a name="authelia-4.0.21"></a>
### [authelia-4.0.21](https://github.com/truecharts/apps/compare/authelia-4.0.20...authelia-4.0.21) (2021-10-19)

#### Fix

* Solve issues regarding ix_values.yaml not containing the image and tag definitions. ([#1176](https://github.com/truecharts/apps/issues/1176))



<a name="authelia-4.0.20"></a>
### [authelia-4.0.20](https://github.com/truecharts/apps/compare/authelia-4.0.19...authelia-4.0.20) (2021-10-18)

#### Refactor

* Project Eclipse - part 1 - remove ix_values.yaml ([#1168](https://github.com/truecharts/apps/issues/1168))



<a name="authelia-4.0.19"></a>
### [authelia-4.0.19](https://github.com/truecharts/apps/compare/authelia-4.0.18...authelia-4.0.19) (2021-10-17)

#### Chore

* update helm chart common to v8.3.10 ([#1160](https://github.com/truecharts/apps/issues/1160))

#### Fix

* force users using correct / prefix for mounPath ([#1156](https://github.com/truecharts/apps/issues/1156))



<a name="authelia-4.0.18"></a>
### [authelia-4.0.18](https://github.com/truecharts/apps/compare/authelia-4.0.17...authelia-4.0.18) (2021-10-13)

#### Chore

* update non-major deps helm releases ([#1133](https://github.com/truecharts/apps/issues/1133))



<a name="authelia-4.0.17"></a>
### [authelia-4.0.17](https://github.com/truecharts/apps/compare/authelia-4.0.16...authelia-4.0.17) (2021-10-12)

#### Chore

* update helm chart postgresql to v3.0.15 ([#1127](https://github.com/truecharts/apps/issues/1127))



<a name="authelia-4.0.16"></a>
### [authelia-4.0.16](https://github.com/truecharts/apps/compare/authelia-4.0.15...authelia-4.0.16) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1126](https://github.com/truecharts/apps/issues/1126))



<a name="authelia-4.0.15"></a>
### [authelia-4.0.15](https://github.com/truecharts/apps/compare/authelia-4.0.14...authelia-4.0.15) (2021-10-12)

#### Chore

* update non-major ([#1122](https://github.com/truecharts/apps/issues/1122))



<a name="authelia-4.0.14"></a>
### [authelia-4.0.14](https://github.com/truecharts/apps/compare/authelia-4.0.13...authelia-4.0.14) (2021-10-12)

#### Chore

* update non-major deps helm releases ([#1123](https://github.com/truecharts/apps/issues/1123))



<a name="authelia-4.0.13"></a>
### [authelia-4.0.13](https://github.com/truecharts/apps/compare/authelia-4.0.12...authelia-4.0.13) (2021-10-09)



<a name="authelia-4.0.12"></a>
### [authelia-4.0.12](https://github.com/truecharts/apps/compare/authelia-4.0.11...authelia-4.0.12) (2021-10-05)

#### Chore

* update non-major deps helm releases ([#1099](https://github.com/truecharts/apps/issues/1099))



<a name="authelia-4.0.11"></a>
### [authelia-4.0.11](https://github.com/truecharts/apps/compare/authelia-4.0.10...authelia-4.0.11) (2021-10-05)

#### Chore

* update non-major ([#1098](https://github.com/truecharts/apps/issues/1098))



<a name="authelia-4.0.10"></a>
### [authelia-4.0.10](https://github.com/truecharts/apps/compare/authelia-4.0.9...authelia-4.0.10) (2021-09-29)

#### Chore

* update helm chart common to v8.0.13 ([#1060](https://github.com/truecharts/apps/issues/1060))



<a name="authelia-4.0.8"></a>
### [authelia-4.0.8](https://github.com/truecharts/apps/compare/authelia-4.0.7...authelia-4.0.8) (2021-09-29)

#### Chore

* update bitnami/postgresql:13.4.0 docker digest to 33c276d ([#1055](https://github.com/truecharts/apps/issues/1055))



<a name="authelia-4.0.7"></a>
### [authelia-4.0.7](https://github.com/truecharts/apps/compare/authelia-4.0.6...authelia-4.0.7) (2021-09-28)

#### Chore

* update helm chart postgresql to v3.0.3 ([#1050](https://github.com/truecharts/apps/issues/1050))



<a name="authelia-4.0.6"></a>
### [authelia-4.0.6](https://github.com/truecharts/apps/compare/authelia-4.0.5...authelia-4.0.6) (2021-09-28)

#### Chore

* update helm chart postgresql to v3.0.2 ([#1049](https://github.com/truecharts/apps/issues/1049))



<a name="authelia-4.0.5"></a>
### [authelia-4.0.5](https://github.com/truecharts/apps/compare/authelia-4.0.4...authelia-4.0.5) (2021-09-28)

#### Chore

* update non-major ([#1048](https://github.com/truecharts/apps/issues/1048))
* update non-major ([#1046](https://github.com/truecharts/apps/issues/1046))



<a name="authelia-4.0.4"></a>
### [authelia-4.0.4](https://github.com/truecharts/apps/compare/authelia-4.0.3...authelia-4.0.4) (2021-09-27)

#### Chore

* update helm chart redis to v15.4.0



<a name="authelia-4.0.3"></a>
### [authelia-4.0.3](https://github.com/truecharts/apps/compare/authelia-4.0.2...authelia-4.0.3) (2021-09-27)

#### Chore

* update helm chart postgresql to v3 ([#1041](https://github.com/truecharts/apps/issues/1041))



<a name="authelia-4.0.2"></a>
### [authelia-4.0.2](https://github.com/truecharts/apps/compare/authelia-4.0.0...authelia-4.0.2) (2021-09-26)

#### Chore

* update non-major deps helm releases ([#1040](https://github.com/truecharts/apps/issues/1040))



<a name="authelia-4.0.0"></a>
### [authelia-4.0.0](https://github.com/truecharts/apps/compare/authelia-3.0.9...authelia-4.0.0) (2021-09-26)



<a name="authelia-3.0.9"></a>
### [authelia-3.0.9](https://github.com/truecharts/apps/compare/authelia-3.0.8...authelia-3.0.9) (2021-09-21)

#### Chore

* update helm chart postgresql to v2.2.5 ([#1017](https://github.com/truecharts/apps/issues/1017))



<a name="authelia-3.0.8"></a>
### [authelia-3.0.8](https://github.com/truecharts/apps/compare/authelia-3.0.7...authelia-3.0.8) (2021-09-21)

#### Chore

* update non-major deps helm releases ([#1014](https://github.com/truecharts/apps/issues/1014))



<a name="authelia-3.0.7"></a>
### [authelia-3.0.7](https://github.com/truecharts/apps/compare/authelia-3.0.6...authelia-3.0.7) (2021-09-21)

#### Chore

* update non-major ([#1015](https://github.com/truecharts/apps/issues/1015))



<a name="authelia-3.0.6"></a>
### [authelia-3.0.6](https://github.com/truecharts/apps/compare/authelia-3.0.5...authelia-3.0.6) (2021-09-21)

#### Chore

* update non-major ([#1013](https://github.com/truecharts/apps/issues/1013))



<a name="authelia-3.0.5"></a>
### [authelia-3.0.5](https://github.com/truecharts/apps/compare/authelia-3.0.4...authelia-3.0.5) (2021-09-14)

#### Chore

* update non-major ([#987](https://github.com/truecharts/apps/issues/987))



<a name="authelia-3.0.4"></a>
### [authelia-3.0.4](https://github.com/truecharts/apps/compare/authelia-3.0.3...authelia-3.0.4) (2021-09-14)

#### Fix

* fix authelia being broken



<a name="authelia-3.0.3"></a>
### [authelia-3.0.3](https://github.com/truecharts/apps/compare/authelia-3.0.2...authelia-3.0.3) (2021-09-14)

#### Fix

* ensure oidc keys get generated on existing authelia installations



<a name="authelia-3.0.2"></a>
### [authelia-3.0.2](https://github.com/truecharts/apps/compare/authelia-3.0.1...authelia-3.0.2) (2021-09-13)

#### Fix

* use correct authelia tag on SCALE installs



<a name="authelia-3.0.1"></a>
### [authelia-3.0.1](https://github.com/truecharts/apps/compare/authelia-2.0.2...authelia-3.0.1) (2021-09-13)

#### Chore

* Use bitnami instead of stock postgresql container ([#960](https://github.com/truecharts/apps/issues/960))
* update non-major
* update non-major

#### Feat

* add new GUI and VPN support to all Apps ([#977](https://github.com/truecharts/apps/issues/977))
* Add VPN addon and move some config to includes ([#973](https://github.com/truecharts/apps/issues/973))
* pin all container references to digests ([#963](https://github.com/truecharts/apps/issues/963))
* Move some common containers to our own containers

#### Fix

* make sure podSecurityContext is included in both SCALE and Helm installs ([#956](https://github.com/truecharts/apps/issues/956))



<a name="authelia-2.0.2"></a>
### [authelia-2.0.2](https://github.com/truecharts/apps/compare/authelia-2.0.1...authelia-2.0.2) (2021-09-10)

#### Fix

* update common to ensure initcontainer can always be run as root



<a name="authelia-2.0.1"></a>
### [authelia-2.0.1](https://github.com/truecharts/apps/compare/authelia-2.0.0...authelia-2.0.1) (2021-09-10)

#### Fix

* move runAsNonRoot to container securityContext to allow root sidecarts ([#954](https://github.com/truecharts/apps/issues/954))



<a name="authelia-2.0.0"></a>
### [authelia-2.0.0](https://github.com/truecharts/apps/compare/authelia-1.7.3...authelia-2.0.0) (2021-09-09)

#### Chore

* update Apps containing initcontainers  -not breaking on SCALE- ([#952](https://github.com/truecharts/apps/issues/952))

#### Feat

* Add regex validation to resources CPU and RAM for all apps ([#935](https://github.com/truecharts/apps/issues/935))
* Pre-commit and tag-appversion syncing ([#926](https://github.com/truecharts/apps/issues/926))

<a name="authelia-1.7.3"></a>
## [authelia-1.7.3](https://github.com/truecharts/apps/compare/authelia-1.7.2...authelia-1.7.3) (2021-09-08)
