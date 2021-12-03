# Security Scan

## Helm-Chart

##### Scan Results

```
2021-12-03T19:50:27.019Z	[34mINFO[0m	Detected config files: 1

promtail/templates/common.yaml (kubernetes)
===========================================
Tests: 41 (SUCCESSES: 28, FAILURES: 13, EXCEPTIONS: 0)
Failures: 13 (UNKNOWN: 0, LOW: 4, MEDIUM: 9, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
|           TYPE            | MISCONF ID |                  CHECK                  | SEVERITY |                   MESSAGE                    |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
| Kubernetes Security Check |   KSV012   | Runs as root user                       |  MEDIUM  | Container 'RELEASE-NAME-promtail'            |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsNonRoot' to true       |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv012          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsNonRoot' to true       |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv012          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used                |   LOW    | Container 'RELEASE-NAME-promtail' of         |
|                           |            |                                         |          | Deployment 'RELEASE-NAME-promtail'           |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | Deployment 'RELEASE-NAME-promtail'           |
|                           |            |                                         |          | should specify an image tag                  |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv013          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV014   | Root file system is not read-only       |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.readOnlyRootFilesystem'     |
|                           |            |                                         |          | to true                                      |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv014          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled               |  MEDIUM  | Container 'RELEASE-NAME-promtail' of         |
|                           |            |                                         |          | Deployment 'RELEASE-NAME-promtail'           |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions' of               |
|                           |            |                                         |          | Deployment 'RELEASE-NAME-promtail'           |
|                           |            |                                         |          | should specify a seccomp profile             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv019          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV020   | Runs with low user ID                   |          | Container 'RELEASE-NAME-promtail'            |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsUser' > 10000          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsUser' > 10000          |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv020          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV021   | Runs with low group ID                  |          | Container 'RELEASE-NAME-promtail'            |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsGroup' > 10000         |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +            +                                         +          +----------------------------------------------+
|                           |            |                                         |          | Container 'autopermissions'                  |
|                           |            |                                         |          | of Deployment                                |
|                           |            |                                         |          | 'RELEASE-NAME-promtail' should set           |
|                           |            |                                         |          | 'securityContext.runAsGroup' > 10000         |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv021          |
+                           +------------+-----------------------------------------+          +----------------------------------------------+
|                           |   KSV023   | hostPath volumes mounted                |          | Deployment 'RELEASE-NAME-promtail'           |
|                           |            |                                         |          | should not set                               |
|                           |            |                                         |          | 'spec.template.volumes.hostPath'             |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv023          |
+                           +------------+-----------------------------------------+----------+----------------------------------------------+
|                           |   KSV029   | A root primary or supplementary GID set |   LOW    | Deployment 'RELEASE-NAME-promtail' should    |
|                           |            |                                         |          | set 'spec.securityContext.runAsGroup',       |
|                           |            |                                         |          | 'spec.securityContext.supplementalGroups[*]' |
|                           |            |                                         |          | and 'spec.securityContext.fsGroup'           |
|                           |            |                                         |          | to integer greater than 0                    |
|                           |            |                                         |          | -->avd.aquasec.com/appshield/ksv029          |
+---------------------------+------------+-----------------------------------------+----------+----------------------------------------------+
```

## Containers

##### Detected Containers

          tccr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          tccr.io/truecharts/promtail:v2.4.1@sha256:83bceed26a638b211d65b6e80d4a33d01dc82b81e630d57e883b490ac0c57ef4

##### Scan Results

**Container: tccr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T19:50:28.083Z	[34mINFO[0m	Detected OS: alpine
2021-12-03T19:50:28.083Z	[34mINFO[0m	Detecting Alpine vulnerabilities...
2021-12-03T19:50:28.087Z	[34mINFO[0m	Number of language-specific files: 0

tccr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c (alpine 3.14.2)
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

**Container: tccr.io/truecharts/promtail:v2.4.1@sha256:83bceed26a638b211d65b6e80d4a33d01dc82b81e630d57e883b490ac0c57ef4**

```
2021-12-03T19:50:31.667Z	[34mINFO[0m	Detected OS: debian
2021-12-03T19:50:31.667Z	[34mINFO[0m	Detecting Debian vulnerabilities...
2021-12-03T19:50:31.681Z	[34mINFO[0m	Number of language-specific files: 1
2021-12-03T19:50:31.681Z	[34mINFO[0m	Detecting gobinary vulnerabilities...

tccr.io/truecharts/promtail:v2.4.1@sha256:83bceed26a638b211d65b6e80d4a33d01dc82b81e630d57e883b490ac0c57ef4 (debian 11.1)
========================================================================================================================
Total: 65 (UNKNOWN: 0, LOW: 60, MEDIUM: 1, HIGH: 2, CRITICAL: 2)

+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
|     LIBRARY      | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                  TITLE                  |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| apt              | CVE-2011-3374    | LOW      | 2.2.4             |               | It was found that apt-key in apt,       |
|                  |                  |          |                   |               | all versions, do not correctly...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2011-3374    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| coreutils        | CVE-2016-2781    |          | 8.32-4            |               | coreutils: Non-privileged               |
|                  |                  |          |                   |               | session can escape to the               |
|                  |                  |          |                   |               | parent session in chroot                |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2016-2781    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2017-18018   |          |                   |               | coreutils: race condition               |
|                  |                  |          |                   |               | vulnerability in chown and chgrp        |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2017-18018   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libapt-pkg6.0    | CVE-2011-3374    |          | 2.2.4             |               | It was found that apt-key in apt,       |
|                  |                  |          |                   |               | all versions, do not correctly...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2011-3374    |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| libc-bin         | CVE-2021-33574   | CRITICAL | 2.31-13+deb11u2   |               | glibc: mq_notify does                   |
|                  |                  |          |                   |               | not handle separately                   |
|                  |                  |          |                   |               | allocated thread attributes             |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-33574   |
+                  +------------------+----------+                   +---------------+-----------------------------------------+
|                  | CVE-2010-4756    | LOW      |                   |               | glibc: glob implementation              |
|                  |                  |          |                   |               | can cause excessive CPU and             |
|                  |                  |          |                   |               | memory consumption due to...            |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2010-4756    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-20796   |          |                   |               | glibc: uncontrolled recursion in        |
|                  |                  |          |                   |               | function check_dst_limits_calc_pos_1    |
|                  |                  |          |                   |               | in posix/regexec.c                      |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-20796   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010022 |          |                   |               | glibc: stack guard protection bypass    |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010022 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010023 |          |                   |               | glibc: running ldd on malicious ELF     |
|                  |                  |          |                   |               | leads to code execution because of...   |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010023 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010024 |          |                   |               | glibc: ASLR bypass using                |
|                  |                  |          |                   |               | cache of thread stack and heap          |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010024 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010025 |          |                   |               | glibc: information disclosure of heap   |
|                  |                  |          |                   |               | addresses of pthread_created thread     |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010025 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-9192    |          |                   |               | glibc: uncontrolled recursion in        |
|                  |                  |          |                   |               | function check_dst_limits_calc_pos_1    |
|                  |                  |          |                   |               | in posix/regexec.c                      |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-9192    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2021-43396   |          |                   |               | glibc: conversion from                  |
|                  |                  |          |                   |               | ISO-2022-JP-3 with iconv may            |
|                  |                  |          |                   |               | emit spurious NUL character on...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-43396   |
+------------------+------------------+----------+                   +---------------+-----------------------------------------+
| libc6            | CVE-2021-33574   | CRITICAL |                   |               | glibc: mq_notify does                   |
|                  |                  |          |                   |               | not handle separately                   |
|                  |                  |          |                   |               | allocated thread attributes             |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-33574   |
+                  +------------------+----------+                   +---------------+-----------------------------------------+
|                  | CVE-2010-4756    | LOW      |                   |               | glibc: glob implementation              |
|                  |                  |          |                   |               | can cause excessive CPU and             |
|                  |                  |          |                   |               | memory consumption due to...            |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2010-4756    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-20796   |          |                   |               | glibc: uncontrolled recursion in        |
|                  |                  |          |                   |               | function check_dst_limits_calc_pos_1    |
|                  |                  |          |                   |               | in posix/regexec.c                      |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-20796   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010022 |          |                   |               | glibc: stack guard protection bypass    |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010022 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010023 |          |                   |               | glibc: running ldd on malicious ELF     |
|                  |                  |          |                   |               | leads to code execution because of...   |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010023 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010024 |          |                   |               | glibc: ASLR bypass using                |
|                  |                  |          |                   |               | cache of thread stack and heap          |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010024 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-1010025 |          |                   |               | glibc: information disclosure of heap   |
|                  |                  |          |                   |               | addresses of pthread_created thread     |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-1010025 |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-9192    |          |                   |               | glibc: uncontrolled recursion in        |
|                  |                  |          |                   |               | function check_dst_limits_calc_pos_1    |
|                  |                  |          |                   |               | in posix/regexec.c                      |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-9192    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2021-43396   |          |                   |               | glibc: conversion from                  |
|                  |                  |          |                   |               | ISO-2022-JP-3 with iconv may            |
|                  |                  |          |                   |               | emit spurious NUL character on...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-43396   |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| libgcrypt20      | CVE-2021-33560   | HIGH     | 1.8.7-6           |               | libgcrypt: mishandles ElGamal           |
|                  |                  |          |                   |               | encryption because it lacks             |
|                  |                  |          |                   |               | exponent blinding to address a...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-33560   |
+                  +------------------+----------+                   +---------------+-----------------------------------------+
|                  | CVE-2018-6829    | LOW      |                   |               | libgcrypt: ElGamal implementation       |
|                  |                  |          |                   |               | doesn't have semantic security due      |
|                  |                  |          |                   |               | to incorrectly encoded plaintexts...    |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-6829    |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| libgmp10         | CVE-2021-43618   | HIGH     | 2:6.2.1+dfsg-1    |               | gmp: Integer overflow and resultant     |
|                  |                  |          |                   |               | buffer overflow via crafted input       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-43618   |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| libgnutls30      | CVE-2011-3389    | LOW      | 3.7.1-5           |               | HTTPS: block-wise chosen-plaintext      |
|                  |                  |          |                   |               | attack against SSL/TLS (BEAST)          |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2011-3389    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libgssapi-krb5-2 | CVE-2004-0971    |          | 1.18.3-6+deb11u1  |               | security flaw                           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2004-0971    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-5709    |          |                   |               | krb5: integer overflow                  |
|                  |                  |          |                   |               | in dbentry->n_key_data                  |
|                  |                  |          |                   |               | in kadmin/dbutil/dump.c                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-5709    |
+------------------+------------------+          +                   +---------------+-----------------------------------------+
| libk5crypto3     | CVE-2004-0971    |          |                   |               | security flaw                           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2004-0971    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-5709    |          |                   |               | krb5: integer overflow                  |
|                  |                  |          |                   |               | in dbentry->n_key_data                  |
|                  |                  |          |                   |               | in kadmin/dbutil/dump.c                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-5709    |
+------------------+------------------+          +                   +---------------+-----------------------------------------+
| libkrb5-3        | CVE-2004-0971    |          |                   |               | security flaw                           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2004-0971    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-5709    |          |                   |               | krb5: integer overflow                  |
|                  |                  |          |                   |               | in dbentry->n_key_data                  |
|                  |                  |          |                   |               | in kadmin/dbutil/dump.c                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-5709    |
+------------------+------------------+          +                   +---------------+-----------------------------------------+
| libkrb5support0  | CVE-2004-0971    |          |                   |               | security flaw                           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2004-0971    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2018-5709    |          |                   |               | krb5: integer overflow                  |
|                  |                  |          |                   |               | in dbentry->n_key_data                  |
|                  |                  |          |                   |               | in kadmin/dbutil/dump.c                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2018-5709    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libpcre3         | CVE-2017-11164   |          | 2:8.39-13         |               | pcre: OP_KETRMAX feature in the         |
|                  |                  |          |                   |               | match function in pcre_exec.c           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2017-11164   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2017-16231   |          |                   |               | pcre: self-recursive call               |
|                  |                  |          |                   |               | in match() in pcre_exec.c               |
|                  |                  |          |                   |               | leads to denial of service...           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2017-16231   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2017-7245    |          |                   |               | pcre: stack-based buffer overflow       |
|                  |                  |          |                   |               | write in pcre32_copy_substring          |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2017-7245    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2017-7246    |          |                   |               | pcre: stack-based buffer overflow       |
|                  |                  |          |                   |               | write in pcre32_copy_substring          |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2017-7246    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-20838   |          |                   |               | pcre: Buffer over-read in JIT           |
|                  |                  |          |                   |               | when UTF is disabled and \X or...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-20838   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libsepol1        | CVE-2021-36084   |          | 3.1-1             |               | libsepol: use-after-free in             |
|                  |                  |          |                   |               | __cil_verify_classperms()               |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-36084   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2021-36085   |          |                   |               | libsepol: use-after-free in             |
|                  |                  |          |                   |               | __cil_verify_classperms()               |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-36085   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2021-36086   |          |                   |               | libsepol: use-after-free in             |
|                  |                  |          |                   |               | cil_reset_classpermission()             |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-36086   |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2021-36087   |          |                   |               | libsepol: heap-based buffer             |
|                  |                  |          |                   |               | overflow in ebitmap_match_any()         |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-36087   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libssl1.1        | CVE-2007-6755    |          | 1.1.1k-1+deb11u1  |               | Dual_EC_DRBG: weak pseudo               |
|                  |                  |          |                   |               | random number generator                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2007-6755    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2010-0928    |          |                   |               | openssl: RSA authentication weakness    |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2010-0928    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libsystemd-dev   | CVE-2013-4392    |          | 247.3-6           |               | systemd: TOCTOU race condition          |
|                  |                  |          |                   |               | when updating file permissions          |
|                  |                  |          |                   |               | and SELinux security contexts...        |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2013-4392    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2020-13529   |          |                   |               | systemd: DHCP FORCERENEW                |
|                  |                  |          |                   |               | authentication not implemented          |
|                  |                  |          |                   |               | can cause a system running the...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2020-13529   |
+------------------+------------------+          +                   +---------------+-----------------------------------------+
| libsystemd0      | CVE-2013-4392    |          |                   |               | systemd: TOCTOU race condition          |
|                  |                  |          |                   |               | when updating file permissions          |
|                  |                  |          |                   |               | and SELinux security contexts...        |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2013-4392    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2020-13529   |          |                   |               | systemd: DHCP FORCERENEW                |
|                  |                  |          |                   |               | authentication not implemented          |
|                  |                  |          |                   |               | can cause a system running the...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2020-13529   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libtinfo6        | CVE-2021-39537   |          | 6.2+20201114-2    |               | ncurses: heap-based buffer overflow     |
|                  |                  |          |                   |               | in _nc_captoinfo() in captoinfo.c       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-39537   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| libudev1         | CVE-2013-4392    |          | 247.3-6           |               | systemd: TOCTOU race condition          |
|                  |                  |          |                   |               | when updating file permissions          |
|                  |                  |          |                   |               | and SELinux security contexts...        |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2013-4392    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2020-13529   |          |                   |               | systemd: DHCP FORCERENEW                |
|                  |                  |          |                   |               | authentication not implemented          |
|                  |                  |          |                   |               | can cause a system running the...       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2020-13529   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| login            | CVE-2007-5686    |          | 1:4.8.1-1         |               | initscripts in rPath Linux 1            |
|                  |                  |          |                   |               | sets insecure permissions for           |
|                  |                  |          |                   |               | the /var/log/btmp file,...              |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2007-5686    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2013-4235    |          |                   |               | shadow-utils: TOCTOU race               |
|                  |                  |          |                   |               | conditions by copying and               |
|                  |                  |          |                   |               | removing directory trees                |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2013-4235    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-19882   |          |                   |               | shadow-utils: local users can           |
|                  |                  |          |                   |               | obtain root access because setuid       |
|                  |                  |          |                   |               | programs are misconfigured...           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-19882   |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| ncurses-base     | CVE-2021-39537   |          | 6.2+20201114-2    |               | ncurses: heap-based buffer overflow     |
|                  |                  |          |                   |               | in _nc_captoinfo() in captoinfo.c       |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2021-39537   |
+------------------+                  +          +                   +---------------+                                         +
| ncurses-bin      |                  |          |                   |               |                                         |
|                  |                  |          |                   |               |                                         |
|                  |                  |          |                   |               |                                         |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| openssl          | CVE-2007-6755    |          | 1.1.1k-1+deb11u1  |               | Dual_EC_DRBG: weak pseudo               |
|                  |                  |          |                   |               | random number generator                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2007-6755    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2010-0928    |          |                   |               | openssl: RSA authentication weakness    |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2010-0928    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| passwd           | CVE-2007-5686    |          | 1:4.8.1-1         |               | initscripts in rPath Linux 1            |
|                  |                  |          |                   |               | sets insecure permissions for           |
|                  |                  |          |                   |               | the /var/log/btmp file,...              |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2007-5686    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2013-4235    |          |                   |               | shadow-utils: TOCTOU race               |
|                  |                  |          |                   |               | conditions by copying and               |
|                  |                  |          |                   |               | removing directory trees                |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2013-4235    |
+                  +------------------+          +                   +---------------+-----------------------------------------+
|                  | CVE-2019-19882   |          |                   |               | shadow-utils: local users can           |
|                  |                  |          |                   |               | obtain root access because setuid       |
|                  |                  |          |                   |               | programs are misconfigured...           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-19882   |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+
| perl-base        | CVE-2020-16156   | MEDIUM   | 5.32.1-4+deb11u2  |               | [Signature Verification Bypass]         |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2020-16156   |
+                  +------------------+----------+                   +---------------+-----------------------------------------+
|                  | CVE-2011-4116    | LOW      |                   |               | perl: File::Temp insecure               |
|                  |                  |          |                   |               | temporary file handling                 |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2011-4116    |
+------------------+------------------+          +-------------------+---------------+-----------------------------------------+
| tar              | CVE-2005-2541    |          | 1.34+dfsg-1       |               | tar: does not properly warn the user    |
|                  |                  |          |                   |               | when extracting setuid or setgid...     |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2005-2541    |
+------------------+------------------+----------+-------------------+---------------+-----------------------------------------+

usr/bin/promtail (gobinary)
===========================
Total: 2 (UNKNOWN: 0, LOW: 0, MEDIUM: 1, HIGH: 1, CRITICAL: 0)

+----------------------------------+------------------+----------+--------------------------------------+-----------------+---------------------------------------+
|             LIBRARY              | VULNERABILITY ID | SEVERITY |          INSTALLED VERSION           |  FIXED VERSION  |                 TITLE                 |
+----------------------------------+------------------+----------+--------------------------------------+-----------------+---------------------------------------+
| github.com/containerd/containerd | CVE-2021-41103   | HIGH     | v1.5.4                               | v1.4.11, v1.5.7 | containerd: insufficiently            |
|                                  |                  |          |                                      |                 | restricted permissions on container   |
|                                  |                  |          |                                      |                 | root and plugin directories           |
|                                  |                  |          |                                      |                 | -->avd.aquasec.com/nvd/cve-2021-41103 |
+----------------------------------+------------------+----------+--------------------------------------+-----------------+---------------------------------------+
| github.com/prometheus/prometheus | CVE-2019-3826    | MEDIUM   | v1.8.2-0.20211011171444-354d8d2ecfac | v2.7.1          | prometheus: Stored DOM                |
|                                  |                  |          |                                      |                 | cross-site scripting (XSS)            |
|                                  |                  |          |                                      |                 | attack via crafted URL                |
|                                  |                  |          |                                      |                 | -->avd.aquasec.com/nvd/cve-2019-3826  |
+----------------------------------+------------------+----------+--------------------------------------+-----------------+---------------------------------------+
```

