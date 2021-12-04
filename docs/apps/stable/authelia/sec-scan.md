# Security Scan

## Helm-Chart

##### Scan Results

```
2021-12-03T22:24:36.061Z    [34mINFO[0m    Need to update the built-in policies
2021-12-03T22:24:36.061Z    [34mINFO[0m    Downloading the built-in policies...
2021-12-03T22:24:37.192Z    [34mINFO[0m    Detected config files: 3

authelia/charts/postgresql/templates/common.yaml (kubernetes)
=============================================================
Tests: 41 (SUCCESSES: 28, FAILURES: 13, EXCEPTIONS: 0)
Failures: 13 (UNKNOWN: 0, LOW: 6, MEDIUM: 7, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
|           TYPE            | MISCONF ID |                  CHECK                  | SEVERITY |                   MESSAGE                    |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
| Kubernetes Security Check |   KSV003   | Default capabilities not dropped        |   LOW    | Container 'RELEASE-NAME-postgresql' of       |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-postgresql'        |
|                           |            |                                         |          | should add 'ALL' to                          |
|                           |            |                                         |          | 'securityContext.capabilities.drop'          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv003          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV012   | Runs as root user                       |  MEDIUM  | Container 'autopermissions'                  |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.runAsNonRoot' to true       |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv012          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used                |   LOW    | Container 'RELEASE-NAME-postgresql' of       |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-postgresql'        |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-postgresql'        |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV014   | Root file system is not read-only       |          | Container 'RELEASE-NAME-postgresql'          |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.readOnlyRootFilesystem'     |
|                           |            |                                         |          | to true                                      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv014          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.readOnlyRootFilesystem'     |
|                           |            |                                         |          | to true                                      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv014          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled               |  MEDIUM  | Container 'RELEASE-NAME-postgresql' of       |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-postgresql'        |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-postgresql'        |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV020   | Runs with low user ID                   |          | Container 'RELEASE-NAME-postgresql'          |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.runAsUser' > 10000          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.runAsUser' > 10000          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV021   | Runs with low group ID                  |          | Container 'RELEASE-NAME-postgresql'          |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.runAsGroup' > 10000         |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-postgresql' should set         |
|                           |            |                                         |          | 'securityContext.runAsGroup' > 10000         |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV029   | A root primary or supplementary GID set |   LOW    | StatefulSet 'RELEASE-NAME-postgresql' should |
|                           |            |                                         |          | set 'spec.securityContext.runAsGroup',       |
|                           |            |                                         |          | 'spec.securityContext.supplementalGroups[*]' |
|                           |            |                                         |          | and 'spec.securityContext.fsGroup'           |
|                           |            |                                         |          | to integer greater than 0                    |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv029          |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+

authelia/charts/redis/templates/common.yaml (kubernetes)
========================================================
Tests: 41 (SUCCESSES: 28, FAILURES: 13, EXCEPTIONS: 0)
Failures: 13 (UNKNOWN: 0, LOW: 6, MEDIUM: 7, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
|           TYPE            | MISCONF ID |                  CHECK                  | SEVERITY |                   MESSAGE                    |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
| Kubernetes Security Check |   KSV003   | Default capabilities not dropped        |   LOW    | Container 'RELEASE-NAME-redis' of            |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis'             |
|                           |            |                                         |          | should add 'ALL' to                          |
|                           |            |                                         |          | 'securityContext.capabilities.drop'          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv003          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV012   | Runs as root user                       |  MEDIUM  | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'securityContext.runAsNonRoot' to        |
|                           |            |                                         |          | true -->avd.aquasec.com/appshield/ksv012     |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used                |   LOW    | Container 'RELEASE-NAME-redis' of            |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis'             |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis'             |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV014   | Root file system is not read-only       |          | Container 'RELEASE-NAME-redis'               |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-redis' should set              |
|                           |            |                                         |          | 'securityContext.readOnlyRootFilesystem'     |
|                           |            |                                         |          | to true                                      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv014          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of StatefulSet                               |
|                           |            |                                         |          | 'RELEASE-NAME-redis' should set              |
|                           |            |                                         |          | 'securityContext.readOnlyRootFilesystem'     |
|                           |            |                                         |          | to true                                      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv014          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled               |  MEDIUM  | Container 'RELEASE-NAME-redis' of            |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis'             |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis'             |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV020   | Runs with low user ID                   |          | Container 'RELEASE-NAME-redis' of            |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'securityContext.runAsUser' > 10000      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'securityContext.runAsUser' > 10000      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV021   | Runs with low group ID                  |          | Container 'RELEASE-NAME-redis' of            |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'securityContext.runAsGroup' > 10000     |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'securityContext.runAsGroup' > 10000     |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV029   | A root primary or supplementary GID set |   LOW    | StatefulSet 'RELEASE-NAME-redis' should      |
|                           |            |                                         |          | set 'spec.securityContext.runAsGroup',       |
|                           |            |                                         |          | 'spec.securityContext.supplementalGroups[*]' |
|                           |            |                                         |          | and 'spec.securityContext.fsGroup'           |
|                           |            |                                         |          | to integer greater than 0                    |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv029          |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+

authelia/templates/common.yaml (kubernetes)
===========================================
Tests: 46 (SUCCESSES: 28, FAILURES: 18, EXCEPTIONS: 0)
Failures: 18 (UNKNOWN: 0, LOW: 6, MEDIUM: 12, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+----------------------------------------+----------+--------------------------------------------+
|           TYPE            | MISCONF ID |                 CHECK                  | SEVERITY |                  MESSAGE                   |
+---------------------------+------------+----------------------------------------+----------+--------------------------------------------+
| Kubernetes Security Check |   KSV001   | Process can elevate its own privileges |  MEDIUM  | Container 'postgresql-init' of Deployment  |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.allowPrivilegeEscalation' |
|                           |            |                                        |          | to false                                   |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv001        |
+                           +------------+----------------------------------------+----------+--------------------------------------------+
|                           |   KSV003   | Default capabilities not dropped       |   LOW    | Container 'RELEASE-NAME-authelia' of       |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should add 'ALL' to                        |
|                           |            |                                        |          | 'securityContext.capabilities.drop'        |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv003        |
+                           +------------+----------------------------------------+----------+--------------------------------------------+
|                           |   KSV012   | Runs as root user                      |  MEDIUM  | Container 'autopermissions'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsNonRoot' to true     |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv012        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsNonRoot' to true     |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv012        |
+                           +------------+----------------------------------------+----------+--------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used               |   LOW    | Container 'RELEASE-NAME-authelia' of       |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify an image tag                |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv013        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'autopermissions' of             |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify an image tag                |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv013        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init' of             |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify an image tag                |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv013        |
+                           +------------+----------------------------------------+          +--------------------------------------------+
|                           |   KSV014   | Root file system is not read-only      |          | Container 'autopermissions'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.readOnlyRootFilesystem'   |
|                           |            |                                        |          | to true                                    |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv014        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.readOnlyRootFilesystem'   |
|                           |            |                                        |          | to true                                    |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv014        |
+                           +------------+----------------------------------------+----------+--------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled              |  MEDIUM  | Container 'RELEASE-NAME-authelia' of       |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify a seccomp profile           |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv019        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'autopermissions' of             |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify a seccomp profile           |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv019        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init' of             |
|                           |            |                                        |          | Deployment 'RELEASE-NAME-authelia'         |
|                           |            |                                        |          | should specify a seccomp profile           |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv019        |
+                           +------------+----------------------------------------+          +--------------------------------------------+
|                           |   KSV020   | Runs with low user ID                  |          | Container 'RELEASE-NAME-authelia'          |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsUser' > 10000        |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv020        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'autopermissions'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsUser' > 10000        |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv020        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsUser' > 10000        |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv020        |
+                           +------------+----------------------------------------+          +--------------------------------------------+
|                           |   KSV021   | Runs with low group ID                 |          | Container 'RELEASE-NAME-authelia'          |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsGroup' > 10000       |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv021        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'autopermissions'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsGroup' > 10000       |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv021        |
+                           +            +                                        +          +--------------------------------------------+
|                           |            |                                        |          | Container 'postgresql-init'                |
|                           |            |                                        |          | of Deployment                              |
|                           |            |                                        |          | 'RELEASE-NAME-authelia' should set         |
|                           |            |                                        |          | 'securityContext.runAsGroup' > 10000       |
|                           |            |                                        |          | -->avd.aquasec.com/appshield/ksv021        |
+---------------------------+------------+----------------------------------------+----------+--------------------------------------------+
```

## Containers

##### Detected Containers

          ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe
          tccr.io/truecharts/authelia:v4.33.0@sha256:8e5d19769c2c01fa8f3b5e96ccee2262b7a8aab1560ce3c40f80ee207be18f9d
          ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          bitnami/redis:6.2.6@sha256:61237e1fb2fbc54ad58141057591538d9563d992ba09cf789766a314e9433c07
          ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe

##### Scan Results

**Container: ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T22:24:37.301Z    [34mINFO[0m    Need to update DB
2021-12-03T22:24:37.301Z    [34mINFO[0m    Downloading DB...
2021-12-03T22:24:41.371Z    [34mINFO[0m    Detected OS: alpine
2021-12-03T22:24:41.371Z    [34mINFO[0m    Detecting Alpine vulnerabilities...
2021-12-03T22:24:41.373Z    [34mINFO[0m    Number of language-specific files: 0

ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c (alpine 3.14.2)
=========================================================================================================================
Total: 22 (UNKNOWN: 0, LOW: 0, MEDIUM: 4, HIGH: 18, CRITICAL: 0)

+------------+------------------+----------+-------------------+---------------+---------------------------------------+
|  LIBRARY   | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
| busybox    | CVE-2021-42378   | HIGH     | 1.33.1-r3         | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+                   +---------------+---------------------------------------+
| ssl_client | CVE-2021-42378   | HIGH     |                   | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
```

**Container: bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe**

```
2021-12-03T22:24:44.845Z    [34mINFO[0m    Detected OS: debian
2021-12-03T22:24:44.845Z    [34mINFO[0m    Detecting Debian vulnerabilities...
2021-12-03T22:24:44.865Z    [34mINFO[0m    Number of language-specific files: 2
2021-12-03T22:24:44.865Z    [34mINFO[0m    Detecting gobinary vulnerabilities...
2021-12-03T22:24:44.865Z    [34mINFO[0m    Detecting jar vulnerabilities...

bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe (debian 10.11)
================================================================================================================
Total: 190 (UNKNOWN: 0, LOW: 130, MEDIUM: 21, HIGH: 31, CRITICAL: 8)

+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
|     LIBRARY      | VULNERABILITY ID | SEVERITY |   INSTALLED VERSION    | FIXED VERSION |                            TITLE                             |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| apt              | CVE-2011-3374    | LOW      | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bash             | CVE-2019-18276   |          | 5.0-4                  |               | bash: when effective UID is not                              |
|                  |                  |          |                        |               | equal to its real UID the...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-18276                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bsdutils         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| coreutils        | CVE-2016-2781    |          | 8.30-3                 |               | coreutils: Non-privileged                                    |
|                  |                  |          |                        |               | session can escape to the                                    |
|                  |                  |          |                        |               | parent session in chroot                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-2781                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-18018   |          |                        |               | coreutils: race condition                                    |
|                  |                  |          |                        |               | vulnerability in chown and chgrp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-18018                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| curl             | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| fdisk            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gcc-8-base       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gpgv             | CVE-2019-14855   | LOW      | 2.2.12-1+deb10u1       |               | gnupg2: OpenPGP Key Certification                            |
|                  |                  |          |                        |               | Forgeries with SHA-1                                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-14855                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libapt-pkg5.0    | CVE-2011-3374    |          | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libblkid1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libc-bin         | CVE-2021-33574   | CRITICAL | 2.28-10                |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+                        +---------------+--------------------------------------------------------------+
| libc-l10n        | CVE-2021-33574   | CRITICAL |                        |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+                        +---------------+--------------------------------------------------------------+
| libc6            | CVE-2021-33574   | CRITICAL |                        |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libcurl4         | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libfdisk1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgcc1          | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgcrypt20      | CVE-2021-33560   |          | 1.8.4-5+deb10u1        |               | libgcrypt: mishandles ElGamal                                |
|                  |                  |          |                        |               | encryption because it lacks                                  |
|                  |                  |          |                        |               | exponent blinding to address a...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33560                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-13627   | MEDIUM   |                        |               | libgcrypt: ECDSA timing attack                               |
|                  |                  |          |                        |               | allowing private key leak                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13627                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-6829    | LOW      |                        |               | libgcrypt: ElGamal implementation                            |
|                  |                  |          |                        |               | doesn't have semantic security due                           |
|                  |                  |          |                        |               | to incorrectly encoded plaintexts...                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-6829                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgmp10         | CVE-2021-43618   | HIGH     | 2:6.1.2+dfsg-4         |               | gmp: Integer overflow and resultant                          |
|                  |                  |          |                        |               | buffer overflow via crafted input                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-43618                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgnutls30      | CVE-2011-3389    | LOW      | 3.6.7-4+deb10u7        |               | HTTPS: block-wise chosen-plaintext                           |
|                  |                  |          |                        |               | attack against SSL/TLS (BEAST)                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3389                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgssapi-krb5-2 | CVE-2004-0971    |          | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libidn2-0        | CVE-2019-12290   | HIGH     | 2.0.5-1+deb10u1        |               | GNU libidn2 before 2.2.0                                     |
|                  |                  |          |                        |               | fails to perform the roundtrip                               |
|                  |                  |          |                        |               | checks specified in...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-12290                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libk5crypto3     | CVE-2004-0971    | LOW      | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5-3        | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5support0  | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libldap-2.4-2    | CVE-2015-3276    |          | 2.4.47+dfsg-3+deb10u6  |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libldap-common   | CVE-2015-3276    |          |                        |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| liblz4-1         | CVE-2019-17543   |          | 1.8.3-1+deb10u1        |               | lz4: heap-based buffer                                       |
|                  |                  |          |                        |               | overflow in LZ4_write32                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17543                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libmount1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libncurses6      | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+                  +          +                        +---------------+                                                              +
| libncursesw6     |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libnghttp2-14    | CVE-2020-11080   | HIGH     | 1.36.0-2+deb10u1       |               | nghttp2: overly large SETTINGS                               |
|                  |                  |          |                        |               | frames can lead to DoS                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-11080                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libpcre3         | CVE-2020-14155   | MEDIUM   | 2:8.39-12              |               | pcre: Integer overflow when                                  |
|                  |                  |          |                        |               | parsing callout numeric arguments                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-14155                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-11164   | LOW      |                        |               | pcre: OP_KETRMAX feature in the                              |
|                  |                  |          |                        |               | match function in pcre_exec.c                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-11164                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-16231   |          |                        |               | pcre: self-recursive call                                    |
|                  |                  |          |                        |               | in match() in pcre_exec.c                                    |
|                  |                  |          |                        |               | leads to denial of service...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-16231                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7245    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7245                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7246    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7246                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20838   |          |                        |               | pcre: Buffer over-read in JIT                                |
|                  |                  |          |                        |               | when UTF is disabled and \X or...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20838                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libseccomp2      | CVE-2019-9893    |          | 2.3.3-4                |               | libseccomp: incorrect generation                             |
|                  |                  |          |                        |               | of syscall filters in libseccomp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9893                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsepol1        | CVE-2021-36084   |          | 2.8-1                  |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36084                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36085   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36085                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36086   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | cil_reset_classpermission()                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36086                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36087   |          |                        |               | libsepol: heap-based buffer                                  |
|                  |                  |          |                        |               | overflow in ebitmap_match_any()                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36087                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsmartcols1    | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libsqlite3-0     | CVE-2019-19603   | HIGH     | 3.27.2-3+deb10u1       |               | sqlite: mishandling of                                       |
|                  |                  |          |                        |               | certain SELECT statements with                               |
|                  |                  |          |                        |               | non-existent VIEW can lead to...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19603                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19645   | MEDIUM   |                        |               | sqlite: infinite recursion via                               |
|                  |                  |          |                        |               | certain types of self-referential                            |
|                  |                  |          |                        |               | views in conjunction with...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19645                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19924   |          |                        |               | sqlite: incorrect                                            |
|                  |                  |          |                        |               | sqlite3WindowRewrite() error                                 |
|                  |                  |          |                        |               | handling leads to mishandling                                |
|                  |                  |          |                        |               | certain parser-tree rewriting                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19924                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13631   |          |                        |               | sqlite: Virtual table can be                                 |
|                  |                  |          |                        |               | renamed into the name of one of...                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13631                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19244   | LOW      |                        |               | sqlite: allows a crash                                       |
|                  |                  |          |                        |               | if a sub-select uses both                                    |
|                  |                  |          |                        |               | DISTINCT and window...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19244                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-11656   |          |                        |               | sqlite: use-after-free in the                                |
|                  |                  |          |                        |               | ALTER TABLE implementation                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-11656                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36690   |          |                        |               | ** DISPUTED ** A segmentation                                |
|                  |                  |          |                        |               | fault can occur in the                                       |
|                  |                  |          |                        |               | sqlite3.exe command-line...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36690                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libssh2-1        | CVE-2019-13115   | HIGH     | 1.8.0-2.1              |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | kex_method_diffie_hellman_group_exchange_sha256_key_exchange |
|                  |                  |          |                        |               | in kex.c leads to out-of-bounds write                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13115                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-17498   | LOW      |                        |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | SSH_MSG_DISCONNECT logic in packet.c                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17498                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libssl1.1        | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libstdc++6       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsystemd0      | CVE-2019-3843    |          | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtasn1-6       | CVE-2018-1000654 |          | 4.13-3                 |               | libtasn1: Infinite loop in                                   |
|                  |                  |          |                        |               | _asn1_expand_object_id(ptree)                                |
|                  |                  |          |                        |               | leads to memory exhaustion                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-1000654                      |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtinfo6        | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libudev1         | CVE-2019-3843    | HIGH     | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libuuid1         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libxml2          | CVE-2017-16932   | HIGH     | 2.9.4+dfsg1-7+deb10u2  |               | libxml2: Infinite recursion                                  |
|                  |                  |          |                        |               | in parameter entities                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-16932                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-9318    | MEDIUM   |                        |               | libxml2: XML External                                        |
|                  |                  |          |                        |               | Entity vulnerability                                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-9318                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libxslt1.1       | CVE-2015-9019    | LOW      | 1.1.32-2.2~deb10u1     |               | libxslt: math.random() in                                    |
|                  |                  |          |                        |               | xslt uses unseeded randomness                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-9019                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| locales          | CVE-2021-33574   | CRITICAL | 2.28-10                |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| login            | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| mount            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| ncurses-base     | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| openssl          | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| passwd           | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| perl-base        | CVE-2020-16156   | MEDIUM   | 5.28.1-6+deb10u1       |               | [Signature Verification Bypass]                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-16156                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2011-4116    | LOW      |                        |               | perl: File::Temp insecure                                    |
|                  |                  |          |                        |               | temporary file handling                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-4116                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| tar              | CVE-2005-2541    |          | 1.30+dfsg-6            |               | tar: does not properly warn the user                         |
|                  |                  |          |                        |               | when extracting setuid or setgid...                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2005-2541                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9923    |          |                        |               | tar: null-pointer dereference                                |
|                  |                  |          |                        |               | in pax_decode_header in sparse.c                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9923                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-20193   |          |                        |               | tar: Memory leak in                                          |
|                  |                  |          |                        |               | read_header() in list.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-20193                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| util-linux       | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+

Java (jar)
==========
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)


opt/bitnami/common/bin/gosu (gobinary)
======================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```

**Container: tccr.io/truecharts/authelia:v4.33.0@sha256:8e5d19769c2c01fa8f3b5e96ccee2262b7a8aab1560ce3c40f80ee207be18f9d**

```
2021-12-03T22:24:46.760Z    [34mINFO[0m    Detected OS: alpine
2021-12-03T22:24:46.760Z    [33mWARN[0m    This OS version is not on the EOL list: alpine 3.15
2021-12-03T22:24:46.760Z    [34mINFO[0m    Detecting Alpine vulnerabilities...
2021-12-03T22:24:46.760Z    [34mINFO[0m    Number of language-specific files: 1
2021-12-03T22:24:46.760Z    [34mINFO[0m    Detecting gobinary vulnerabilities...
2021-12-03T22:24:46.761Z    [33mWARN[0m    This OS version is no longer supported by the distribution: alpine 3.15.0
2021-12-03T22:24:46.761Z    [33mWARN[0m    The vulnerability detection may be insufficient because security updates are not provided

tccr.io/truecharts/authelia:v4.33.0@sha256:8e5d19769c2c01fa8f3b5e96ccee2262b7a8aab1560ce3c40f80ee207be18f9d (alpine 3.15.0)
===========================================================================================================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)


app/authelia (gobinary)
=======================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```

**Container: ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T22:24:47.657Z    [34mINFO[0m    Detected OS: alpine
2021-12-03T22:24:47.657Z    [34mINFO[0m    Detecting Alpine vulnerabilities...
2021-12-03T22:24:47.664Z    [34mINFO[0m    Number of language-specific files: 0

ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c (alpine 3.14.2)
=========================================================================================================================
Total: 22 (UNKNOWN: 0, LOW: 0, MEDIUM: 4, HIGH: 18, CRITICAL: 0)

+------------+------------------+----------+-------------------+---------------+---------------------------------------+
|  LIBRARY   | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
| busybox    | CVE-2021-42378   | HIGH     | 1.33.1-r3         | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+                   +---------------+---------------------------------------+
| ssl_client | CVE-2021-42378   | HIGH     |                   | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
```

**Container: bitnami/redis:6.2.6@sha256:61237e1fb2fbc54ad58141057591538d9563d992ba09cf789766a314e9433c07**

```
2021-12-03T22:24:49.208Z    [34mINFO[0m    Detected OS: debian
2021-12-03T22:24:49.208Z    [34mINFO[0m    Detecting Debian vulnerabilities...
2021-12-03T22:24:49.225Z    [34mINFO[0m    Number of language-specific files: 2
2021-12-03T22:24:49.225Z    [34mINFO[0m    Detecting gobinary vulnerabilities...

bitnami/redis:6.2.6@sha256:61237e1fb2fbc54ad58141057591538d9563d992ba09cf789766a314e9433c07 (debian 10.11)
==========================================================================================================
Total: 142 (UNKNOWN: 0, LOW: 104, MEDIUM: 11, HIGH: 23, CRITICAL: 4)

+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
|     LIBRARY      | VULNERABILITY ID | SEVERITY |   INSTALLED VERSION    | FIXED VERSION |                            TITLE                             |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| apt              | CVE-2011-3374    | LOW      | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bash             | CVE-2019-18276   |          | 5.0-4                  |               | bash: when effective UID is not                              |
|                  |                  |          |                        |               | equal to its real UID the...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-18276                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bsdutils         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| coreutils        | CVE-2016-2781    |          | 8.30-3                 |               | coreutils: Non-privileged                                    |
|                  |                  |          |                        |               | session can escape to the                                    |
|                  |                  |          |                        |               | parent session in chroot                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-2781                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-18018   |          |                        |               | coreutils: race condition                                    |
|                  |                  |          |                        |               | vulnerability in chown and chgrp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-18018                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| curl             | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| fdisk            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gcc-8-base       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gpgv             | CVE-2019-14855   | LOW      | 2.2.12-1+deb10u1       |               | gnupg2: OpenPGP Key Certification                            |
|                  |                  |          |                        |               | Forgeries with SHA-1                                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-14855                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libapt-pkg5.0    | CVE-2011-3374    |          | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libblkid1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libc-bin         | CVE-2021-33574   | CRITICAL | 2.28-10                |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+                        +---------------+--------------------------------------------------------------+
| libc6            | CVE-2021-33574   | CRITICAL |                        |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libcurl4         | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libfdisk1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgcc1          | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgcrypt20      | CVE-2021-33560   |          | 1.8.4-5+deb10u1        |               | libgcrypt: mishandles ElGamal                                |
|                  |                  |          |                        |               | encryption because it lacks                                  |
|                  |                  |          |                        |               | exponent blinding to address a...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33560                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-13627   | MEDIUM   |                        |               | libgcrypt: ECDSA timing attack                               |
|                  |                  |          |                        |               | allowing private key leak                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13627                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-6829    | LOW      |                        |               | libgcrypt: ElGamal implementation                            |
|                  |                  |          |                        |               | doesn't have semantic security due                           |
|                  |                  |          |                        |               | to incorrectly encoded plaintexts...                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-6829                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgmp10         | CVE-2021-43618   | HIGH     | 2:6.1.2+dfsg-4         |               | gmp: Integer overflow and resultant                          |
|                  |                  |          |                        |               | buffer overflow via crafted input                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-43618                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgnutls30      | CVE-2011-3389    | LOW      | 3.6.7-4+deb10u7        |               | HTTPS: block-wise chosen-plaintext                           |
|                  |                  |          |                        |               | attack against SSL/TLS (BEAST)                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3389                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgssapi-krb5-2 | CVE-2004-0971    |          | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libidn2-0        | CVE-2019-12290   | HIGH     | 2.0.5-1+deb10u1        |               | GNU libidn2 before 2.2.0                                     |
|                  |                  |          |                        |               | fails to perform the roundtrip                               |
|                  |                  |          |                        |               | checks specified in...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-12290                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libk5crypto3     | CVE-2004-0971    | LOW      | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5-3        | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5support0  | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libldap-2.4-2    | CVE-2015-3276    |          | 2.4.47+dfsg-3+deb10u6  |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libldap-common   | CVE-2015-3276    |          |                        |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| liblz4-1         | CVE-2019-17543   |          | 1.8.3-1+deb10u1        |               | lz4: heap-based buffer                                       |
|                  |                  |          |                        |               | overflow in LZ4_write32                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17543                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libmount1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libncurses6      | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+                  +          +                        +---------------+                                                              +
| libncursesw6     |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libnghttp2-14    | CVE-2020-11080   | HIGH     | 1.36.0-2+deb10u1       |               | nghttp2: overly large SETTINGS                               |
|                  |                  |          |                        |               | frames can lead to DoS                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-11080                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libpcre3         | CVE-2020-14155   | MEDIUM   | 2:8.39-12              |               | pcre: Integer overflow when                                  |
|                  |                  |          |                        |               | parsing callout numeric arguments                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-14155                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-11164   | LOW      |                        |               | pcre: OP_KETRMAX feature in the                              |
|                  |                  |          |                        |               | match function in pcre_exec.c                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-11164                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-16231   |          |                        |               | pcre: self-recursive call                                    |
|                  |                  |          |                        |               | in match() in pcre_exec.c                                    |
|                  |                  |          |                        |               | leads to denial of service...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-16231                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7245    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7245                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7246    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7246                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20838   |          |                        |               | pcre: Buffer over-read in JIT                                |
|                  |                  |          |                        |               | when UTF is disabled and \X or...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20838                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libseccomp2      | CVE-2019-9893    |          | 2.3.3-4                |               | libseccomp: incorrect generation                             |
|                  |                  |          |                        |               | of syscall filters in libseccomp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9893                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsepol1        | CVE-2021-36084   |          | 2.8-1                  |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36084                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36085   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36085                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36086   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | cil_reset_classpermission()                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36086                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36087   |          |                        |               | libsepol: heap-based buffer                                  |
|                  |                  |          |                        |               | overflow in ebitmap_match_any()                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36087                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsmartcols1    | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libssh2-1        | CVE-2019-13115   | HIGH     | 1.8.0-2.1              |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | kex_method_diffie_hellman_group_exchange_sha256_key_exchange |
|                  |                  |          |                        |               | in kex.c leads to out-of-bounds write                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13115                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-17498   | LOW      |                        |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | SSH_MSG_DISCONNECT logic in packet.c                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17498                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libssl1.1        | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libstdc++6       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsystemd0      | CVE-2019-3843    |          | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtasn1-6       | CVE-2018-1000654 |          | 4.13-3                 |               | libtasn1: Infinite loop in                                   |
|                  |                  |          |                        |               | _asn1_expand_object_id(ptree)                                |
|                  |                  |          |                        |               | leads to memory exhaustion                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-1000654                      |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtinfo6        | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libudev1         | CVE-2019-3843    | HIGH     | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libuuid1         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| login            | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| mount            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| ncurses-base     | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| openssl          | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| passwd           | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| perl-base        | CVE-2020-16156   | MEDIUM   | 5.28.1-6+deb10u1       |               | [Signature Verification Bypass]                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-16156                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2011-4116    | LOW      |                        |               | perl: File::Temp insecure                                    |
|                  |                  |          |                        |               | temporary file handling                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-4116                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| tar              | CVE-2005-2541    |          | 1.30+dfsg-6            |               | tar: does not properly warn the user                         |
|                  |                  |          |                        |               | when extracting setuid or setgid...                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2005-2541                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9923    |          |                        |               | tar: null-pointer dereference                                |
|                  |                  |          |                        |               | in pax_decode_header in sparse.c                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9923                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-20193   |          |                        |               | tar: Memory leak in                                          |
|                  |                  |          |                        |               | read_header() in list.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-20193                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| util-linux       | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+

opt/bitnami/common/bin/gosu (gobinary)
======================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)


opt/bitnami/common/bin/wait-for-port (gobinary)
===============================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```

**Container: ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T22:24:49.888Z    [34mINFO[0m    Detected OS: alpine
2021-12-03T22:24:49.888Z    [34mINFO[0m    Detecting Alpine vulnerabilities...
2021-12-03T22:24:49.897Z    [34mINFO[0m    Number of language-specific files: 0

ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c (alpine 3.14.2)
=========================================================================================================================
Total: 22 (UNKNOWN: 0, LOW: 0, MEDIUM: 4, HIGH: 18, CRITICAL: 0)

+------------+------------------+----------+-------------------+---------------+---------------------------------------+
|  LIBRARY   | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
| busybox    | CVE-2021-42378   | HIGH     | 1.33.1-r3         | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+                   +---------------+---------------------------------------+
| ssl_client | CVE-2021-42378   | HIGH     |                   | 1.33.1-r6     | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42378 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42379   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42379 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42380   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42380 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42381   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42381 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42382   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42382 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42383   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42383 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42384   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42384 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42385   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42385 |
+            +------------------+          +                   +               +---------------------------------------+
|            | CVE-2021-42386   |          |                   |               | busybox: use-after-free in            |
|            |                  |          |                   |               | awk applet leads to denial            |
|            |                  |          |                   |               | of service and possibly...            |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42386 |
+            +------------------+----------+                   +---------------+---------------------------------------+
|            | CVE-2021-42374   | MEDIUM   |                   | 1.33.1-r4     | busybox: out-of-bounds read           |
|            |                  |          |                   |               | in unlzma applet leads to             |
|            |                  |          |                   |               | information leak and denial...        |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42374 |
+            +------------------+          +                   +---------------+---------------------------------------+
|            | CVE-2021-42375   |          |                   | 1.33.1-r5     | busybox: incorrect handling           |
|            |                  |          |                   |               | of a special element in               |
|            |                  |          |                   |               | ash applet leads to...                |
|            |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-42375 |
+------------+------------------+----------+-------------------+---------------+---------------------------------------+
```

**Container: bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe**

```
2021-12-03T22:24:50.778Z    [34mINFO[0m    Detected OS: debian
2021-12-03T22:24:50.778Z    [34mINFO[0m    Detecting Debian vulnerabilities...
2021-12-03T22:24:50.800Z    [34mINFO[0m    Number of language-specific files: 2
2021-12-03T22:24:50.801Z    [34mINFO[0m    Detecting gobinary vulnerabilities...
2021-12-03T22:24:50.801Z    [34mINFO[0m    Detecting jar vulnerabilities...

bitnami/postgresql:14.1.0@sha256:bdfeb12b5f8ae8dedfc2f7cb18a0ba48959c4dacc19176292a2fffd0abacdebe (debian 10.11)
================================================================================================================
Total: 190 (UNKNOWN: 0, LOW: 130, MEDIUM: 21, HIGH: 31, CRITICAL: 8)

+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
|     LIBRARY      | VULNERABILITY ID | SEVERITY |   INSTALLED VERSION    | FIXED VERSION |                            TITLE                             |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| apt              | CVE-2011-3374    | LOW      | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bash             | CVE-2019-18276   |          | 5.0-4                  |               | bash: when effective UID is not                              |
|                  |                  |          |                        |               | equal to its real UID the...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-18276                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| bsdutils         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| coreutils        | CVE-2016-2781    |          | 8.30-3                 |               | coreutils: Non-privileged                                    |
|                  |                  |          |                        |               | session can escape to the                                    |
|                  |                  |          |                        |               | parent session in chroot                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-2781                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-18018   |          |                        |               | coreutils: race condition                                    |
|                  |                  |          |                        |               | vulnerability in chown and chgrp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-18018                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| curl             | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| fdisk            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gcc-8-base       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| gpgv             | CVE-2019-14855   | LOW      | 2.2.12-1+deb10u1       |               | gnupg2: OpenPGP Key Certification                            |
|                  |                  |          |                        |               | Forgeries with SHA-1                                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-14855                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libapt-pkg5.0    | CVE-2011-3374    |          | 1.8.2.3                |               | It was found that apt-key in apt,                            |
|                  |                  |          |                        |               | all versions, do not correctly...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3374                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libblkid1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libc-bin         | CVE-2021-33574   | CRITICAL | 2.28-10                |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+                        +---------------+--------------------------------------------------------------+
| libc-l10n        | CVE-2021-33574   | CRITICAL |                        |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+                        +---------------+--------------------------------------------------------------+
| libc6            | CVE-2021-33574   | CRITICAL |                        |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libcurl4         | CVE-2021-22946   | HIGH     | 7.64.0-4+deb10u2       |               | curl: Requirement to use                                     |
|                  |                  |          |                        |               | TLS not properly enforced                                    |
|                  |                  |          |                        |               | for IMAP, POP3, and...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22946                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22947   | MEDIUM   |                        |               | curl: Server responses                                       |
|                  |                  |          |                        |               | received before STARTTLS                                     |
|                  |                  |          |                        |               | processed after TLS handshake                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22947                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22898   | LOW      |                        |               | curl: TELNET stack                                           |
|                  |                  |          |                        |               | contents disclosure                                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22898                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22922   |          |                        |               | curl: Content not matching hash                              |
|                  |                  |          |                        |               | in Metalink is not being discarded                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22922                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22923   |          |                        |               | curl: Metalink download                                      |
|                  |                  |          |                        |               | sends credentials                                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22923                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-22924   |          |                        |               | curl: Bad connection reuse                                   |
|                  |                  |          |                        |               | due to flawed path name checks                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-22924                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libfdisk1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgcc1          | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgcrypt20      | CVE-2021-33560   |          | 1.8.4-5+deb10u1        |               | libgcrypt: mishandles ElGamal                                |
|                  |                  |          |                        |               | encryption because it lacks                                  |
|                  |                  |          |                        |               | exponent blinding to address a...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33560                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-13627   | MEDIUM   |                        |               | libgcrypt: ECDSA timing attack                               |
|                  |                  |          |                        |               | allowing private key leak                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13627                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-6829    | LOW      |                        |               | libgcrypt: ElGamal implementation                            |
|                  |                  |          |                        |               | doesn't have semantic security due                           |
|                  |                  |          |                        |               | to incorrectly encoded plaintexts...                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-6829                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgmp10         | CVE-2021-43618   | HIGH     | 2:6.1.2+dfsg-4         |               | gmp: Integer overflow and resultant                          |
|                  |                  |          |                        |               | buffer overflow via crafted input                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-43618                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libgnutls30      | CVE-2011-3389    | LOW      | 3.6.7-4+deb10u7        |               | HTTPS: block-wise chosen-plaintext                           |
|                  |                  |          |                        |               | attack against SSL/TLS (BEAST)                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-3389                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libgssapi-krb5-2 | CVE-2004-0971    |          | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libidn2-0        | CVE-2019-12290   | HIGH     | 2.0.5-1+deb10u1        |               | GNU libidn2 before 2.2.0                                     |
|                  |                  |          |                        |               | fails to perform the roundtrip                               |
|                  |                  |          |                        |               | checks specified in...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-12290                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libk5crypto3     | CVE-2004-0971    | LOW      | 1.17-3+deb10u3         |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5-3        | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libkrb5support0  | CVE-2004-0971    |          |                        |               | security flaw                                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2004-0971                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-5709    |          |                        |               | krb5: integer overflow                                       |
|                  |                  |          |                        |               | in dbentry->n_key_data                                       |
|                  |                  |          |                        |               | in kadmin/dbutil/dump.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-5709                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libldap-2.4-2    | CVE-2015-3276    |          | 2.4.47+dfsg-3+deb10u6  |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +                        +---------------+--------------------------------------------------------------+
| libldap-common   | CVE-2015-3276    |          |                        |               | openldap: incorrect multi-keyword                            |
|                  |                  |          |                        |               | mode cipherstring parsing                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-3276                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-14159   |          |                        |               | openldap: Privilege escalation                               |
|                  |                  |          |                        |               | via PID file manipulation                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-14159                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-17740   |          |                        |               | openldap:                                                    |
|                  |                  |          |                        |               | contrib/slapd-modules/nops/nops.c                            |
|                  |                  |          |                        |               | attempts to free stack buffer                                |
|                  |                  |          |                        |               | allowing remote attackers to cause...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-17740                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-15719   |          |                        |               | openldap: Certificate                                        |
|                  |                  |          |                        |               | validation incorrectly                                       |
|                  |                  |          |                        |               | matches name against CN-ID                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-15719                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| liblz4-1         | CVE-2019-17543   |          | 1.8.3-1+deb10u1        |               | lz4: heap-based buffer                                       |
|                  |                  |          |                        |               | overflow in LZ4_write32                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17543                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libmount1        | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libncurses6      | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+                  +          +                        +---------------+                                                              +
| libncursesw6     |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
|                  |                  |          |                        |               |                                                              |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libnghttp2-14    | CVE-2020-11080   | HIGH     | 1.36.0-2+deb10u1       |               | nghttp2: overly large SETTINGS                               |
|                  |                  |          |                        |               | frames can lead to DoS                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-11080                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libpcre3         | CVE-2020-14155   | MEDIUM   | 2:8.39-12              |               | pcre: Integer overflow when                                  |
|                  |                  |          |                        |               | parsing callout numeric arguments                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-14155                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-11164   | LOW      |                        |               | pcre: OP_KETRMAX feature in the                              |
|                  |                  |          |                        |               | match function in pcre_exec.c                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-11164                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-16231   |          |                        |               | pcre: self-recursive call                                    |
|                  |                  |          |                        |               | in match() in pcre_exec.c                                    |
|                  |                  |          |                        |               | leads to denial of service...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-16231                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7245    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7245                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2017-7246    |          |                        |               | pcre: stack-based buffer overflow                            |
|                  |                  |          |                        |               | write in pcre32_copy_substring                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-7246                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20838   |          |                        |               | pcre: Buffer over-read in JIT                                |
|                  |                  |          |                        |               | when UTF is disabled and \X or...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20838                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libseccomp2      | CVE-2019-9893    |          | 2.3.3-4                |               | libseccomp: incorrect generation                             |
|                  |                  |          |                        |               | of syscall filters in libseccomp                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9893                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsepol1        | CVE-2021-36084   |          | 2.8-1                  |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36084                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36085   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | __cil_verify_classperms()                                    |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36085                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36086   |          |                        |               | libsepol: use-after-free in                                  |
|                  |                  |          |                        |               | cil_reset_classpermission()                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36086                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36087   |          |                        |               | libsepol: heap-based buffer                                  |
|                  |                  |          |                        |               | overflow in ebitmap_match_any()                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36087                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsmartcols1    | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libsqlite3-0     | CVE-2019-19603   | HIGH     | 3.27.2-3+deb10u1       |               | sqlite: mishandling of                                       |
|                  |                  |          |                        |               | certain SELECT statements with                               |
|                  |                  |          |                        |               | non-existent VIEW can lead to...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19603                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19645   | MEDIUM   |                        |               | sqlite: infinite recursion via                               |
|                  |                  |          |                        |               | certain types of self-referential                            |
|                  |                  |          |                        |               | views in conjunction with...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19645                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19924   |          |                        |               | sqlite: incorrect                                            |
|                  |                  |          |                        |               | sqlite3WindowRewrite() error                                 |
|                  |                  |          |                        |               | handling leads to mishandling                                |
|                  |                  |          |                        |               | certain parser-tree rewriting                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19924                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13631   |          |                        |               | sqlite: Virtual table can be                                 |
|                  |                  |          |                        |               | renamed into the name of one of...                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13631                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19244   | LOW      |                        |               | sqlite: allows a crash                                       |
|                  |                  |          |                        |               | if a sub-select uses both                                    |
|                  |                  |          |                        |               | DISTINCT and window...                                       |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19244                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-11656   |          |                        |               | sqlite: use-after-free in the                                |
|                  |                  |          |                        |               | ALTER TABLE implementation                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-11656                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-36690   |          |                        |               | ** DISPUTED ** A segmentation                                |
|                  |                  |          |                        |               | fault can occur in the                                       |
|                  |                  |          |                        |               | sqlite3.exe command-line...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-36690                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libssh2-1        | CVE-2019-13115   | HIGH     | 1.8.0-2.1              |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | kex_method_diffie_hellman_group_exchange_sha256_key_exchange |
|                  |                  |          |                        |               | in kex.c leads to out-of-bounds write                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-13115                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-17498   | LOW      |                        |               | libssh2: integer overflow in                                 |
|                  |                  |          |                        |               | SSH_MSG_DISCONNECT logic in packet.c                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-17498                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libssl1.1        | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libstdc++6       | CVE-2018-12886   | HIGH     | 8.3.0-6                |               | gcc: spilling of stack                                       |
|                  |                  |          |                        |               | protection address in cfgexpand.c                            |
|                  |                  |          |                        |               | and function.c leads to...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-12886                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-15847   |          |                        |               | gcc: POWER9 "DARN" RNG intrinsic                             |
|                  |                  |          |                        |               | produces repeated output                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-15847                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libsystemd0      | CVE-2019-3843    |          | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtasn1-6       | CVE-2018-1000654 |          | 4.13-3                 |               | libtasn1: Infinite loop in                                   |
|                  |                  |          |                        |               | _asn1_expand_object_id(ptree)                                |
|                  |                  |          |                        |               | leads to memory exhaustion                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-1000654                      |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libtinfo6        | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libudev1         | CVE-2019-3843    | HIGH     | 241-7~deb10u8          |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can create SUID/SGID binaries                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3843                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-3844    |          |                        |               | systemd: services with DynamicUser                           |
|                  |                  |          |                        |               | can get new privileges and                                   |
|                  |                  |          |                        |               | create SGID binaries...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-3844                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4392    | LOW      |                        |               | systemd: TOCTOU race condition                               |
|                  |                  |          |                        |               | when updating file permissions                               |
|                  |                  |          |                        |               | and SELinux security contexts...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4392                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-20386   |          |                        |               | systemd: memory leak in button_open()                        |
|                  |                  |          |                        |               | in login/logind-button.c when                                |
|                  |                  |          |                        |               | udev events are received...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-20386                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13529   |          |                        |               | systemd: DHCP FORCERENEW                                     |
|                  |                  |          |                        |               | authentication not implemented                               |
|                  |                  |          |                        |               | can cause a system running the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13529                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-13776   |          |                        |               | systemd: Mishandles numerical                                |
|                  |                  |          |                        |               | usernames beginning with decimal                             |
|                  |                  |          |                        |               | digits or 0x followed by...                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-13776                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| libuuid1         | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libxml2          | CVE-2017-16932   | HIGH     | 2.9.4+dfsg1-7+deb10u2  |               | libxml2: Infinite recursion                                  |
|                  |                  |          |                        |               | in parameter entities                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2017-16932                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-9318    | MEDIUM   |                        |               | libxml2: XML External                                        |
|                  |                  |          |                        |               | Entity vulnerability                                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-9318                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| libxslt1.1       | CVE-2015-9019    | LOW      | 1.1.32-2.2~deb10u1     |               | libxslt: math.random() in                                    |
|                  |                  |          |                        |               | xslt uses unseeded randomness                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2015-9019                         |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| locales          | CVE-2021-33574   | CRITICAL | 2.28-10                |               | glibc: mq_notify does                                        |
|                  |                  |          |                        |               | not handle separately                                        |
|                  |                  |          |                        |               | allocated thread attributes                                  |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-33574                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-35942   |          |                        |               | glibc: Arbitrary read in wordexp()                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-35942                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1751    | HIGH     |                        |               | glibc: array overflow in                                     |
|                  |                  |          |                        |               | backtrace functions for powerpc                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1751                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-1752    |          |                        |               | glibc: use-after-free in glob()                              |
|                  |                  |          |                        |               | function when expanding ~user                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-1752                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-3326    |          |                        |               | glibc: Assertion failure in                                  |
|                  |                  |          |                        |               | ISO-2022-JP-3 gconv module                                   |
|                  |                  |          |                        |               | related to combining characters                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-3326                         |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-25013   | MEDIUM   |                        |               | glibc: buffer over-read in                                   |
|                  |                  |          |                        |               | iconv when processing invalid                                |
|                  |                  |          |                        |               | multi-byte input sequences in...                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-25013                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-10029   |          |                        |               | glibc: stack corruption                                      |
|                  |                  |          |                        |               | from crafted input in cosl,                                  |
|                  |                  |          |                        |               | sinl, sincosl, and tanl...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-10029                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-27618   |          |                        |               | glibc: iconv when processing                                 |
|                  |                  |          |                        |               | invalid multi-byte input                                     |
|                  |                  |          |                        |               | sequences fails to advance the...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-27618                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-4756    | LOW      |                        |               | glibc: glob implementation                                   |
|                  |                  |          |                        |               | can cause excessive CPU and                                  |
|                  |                  |          |                        |               | memory consumption due to...                                 |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-4756                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2016-10228   |          |                        |               | glibc: iconv program can hang                                |
|                  |                  |          |                        |               | when invoked with the -c option                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2016-10228                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-20796   |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-20796                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010022 |          |                        |               | glibc: stack guard protection bypass                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010022                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010023 |          |                        |               | glibc: running ldd on malicious ELF                          |
|                  |                  |          |                        |               | leads to code execution because of...                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010023                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010024 |          |                        |               | glibc: ASLR bypass using                                     |
|                  |                  |          |                        |               | cache of thread stack and heap                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010024                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-1010025 |          |                        |               | glibc: information disclosure of heap                        |
|                  |                  |          |                        |               | addresses of pthread_created thread                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-1010025                      |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19126   |          |                        |               | glibc: LD_PREFER_MAP_32BIT_EXEC                              |
|                  |                  |          |                        |               | not ignored in setuid binaries                               |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19126                        |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9192    |          |                        |               | glibc: uncontrolled recursion in                             |
|                  |                  |          |                        |               | function check_dst_limits_calc_pos_1                         |
|                  |                  |          |                        |               | in posix/regexec.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9192                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2020-6096    |          |                        |               | glibc: signed comparison                                     |
|                  |                  |          |                        |               | vulnerability in the                                         |
|                  |                  |          |                        |               | ARMv7 memcpy function                                        |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-6096                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-27645   |          |                        |               | glibc: Use-after-free in                                     |
|                  |                  |          |                        |               | addgetnetgrentX function                                     |
|                  |                  |          |                        |               | in netgroupcache.c                                           |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-27645                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| login            | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| mount            | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| ncurses-base     | CVE-2021-39537   |          | 6.1+20181013-2+deb10u2 |               | ncurses: heap-based buffer overflow                          |
|                  |                  |          |                        |               | in _nc_captoinfo() in captoinfo.c                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-39537                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| openssl          | CVE-2007-6755    |          | 1.1.1d-0+deb10u7       |               | Dual_EC_DRBG: weak pseudo                                    |
|                  |                  |          |                        |               | random number generator                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-6755                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2010-0928    |          |                        |               | openssl: RSA authentication weakness                         |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2010-0928                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| passwd           | CVE-2007-5686    |          | 1:4.5-1.1              |               | initscripts in rPath Linux 1                                 |
|                  |                  |          |                        |               | sets insecure permissions for                                |
|                  |                  |          |                        |               | the /var/log/btmp file,...                                   |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2007-5686                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2013-4235    |          |                        |               | shadow-utils: TOCTOU race                                    |
|                  |                  |          |                        |               | conditions by copying and                                    |
|                  |                  |          |                        |               | removing directory trees                                     |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2013-4235                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2018-7169    |          |                        |               | shadow-utils: newgidmap                                      |
|                  |                  |          |                        |               | allows unprivileged user to                                  |
|                  |                  |          |                        |               | drop supplementary groups                                    |
|                  |                  |          |                        |               | potentially allowing privilege...                            |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2018-7169                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-19882   |          |                        |               | shadow-utils: local users can                                |
|                  |                  |          |                        |               | obtain root access because setuid                            |
|                  |                  |          |                        |               | programs are misconfigured...                                |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-19882                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+
| perl-base        | CVE-2020-16156   | MEDIUM   | 5.28.1-6+deb10u1       |               | [Signature Verification Bypass]                              |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2020-16156                        |
+                  +------------------+----------+                        +---------------+--------------------------------------------------------------+
|                  | CVE-2011-4116    | LOW      |                        |               | perl: File::Temp insecure                                    |
|                  |                  |          |                        |               | temporary file handling                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2011-4116                         |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| tar              | CVE-2005-2541    |          | 1.30+dfsg-6            |               | tar: does not properly warn the user                         |
|                  |                  |          |                        |               | when extracting setuid or setgid...                          |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2005-2541                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2019-9923    |          |                        |               | tar: null-pointer dereference                                |
|                  |                  |          |                        |               | in pax_decode_header in sparse.c                             |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2019-9923                         |
+                  +------------------+          +                        +---------------+--------------------------------------------------------------+
|                  | CVE-2021-20193   |          |                        |               | tar: Memory leak in                                          |
|                  |                  |          |                        |               | read_header() in list.c                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-20193                        |
+------------------+------------------+          +------------------------+---------------+--------------------------------------------------------------+
| util-linux       | CVE-2021-37600   |          | 2.33.1-0.1             |               | util-linux: integer overflow                                 |
|                  |                  |          |                        |               | can lead to buffer overflow                                  |
|                  |                  |          |                        |               | in get_sem_elements() in                                     |
|                  |                  |          |                        |               | sys-utils/ipcutils.c...                                      |
|                  |                  |          |                        |               | -->avd.aquasec.com/nvd/cve-2021-37600                        |
+------------------+------------------+----------+------------------------+---------------+--------------------------------------------------------------+

Java (jar)
==========
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)


opt/bitnami/common/bin/gosu (gobinary)
======================================
Total: 0 (UNKNOWN: 0, LOW: 0, MEDIUM: 0, HIGH: 0, CRITICAL: 0)

```
