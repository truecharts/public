# Security Scan

## Helm-Chart

##### Scan Results

```
2021-12-03T19:48:25.464Z	[34mINFO[0m	Detected config files: 1

memcached/templates/common.yaml (kubernetes)
============================================
Tests: 39 (SUCCESSES: 28, FAILURES: 11, EXCEPTIONS: 0)
Failures: 11 (UNKNOWN: 0, LOW: 4, MEDIUM: 7, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
|           TYPE            | MISCONF ID |               CHECK               | SEVERITY |                 MESSAGE                  |
+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
| Kubernetes Security Check |   KSV003   | Default capabilities not dropped  |   LOW    | Container 'RELEASE-NAME-memcached' of    |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-memcached'      |
|                           |            |                                   |          | should add 'ALL' to                      |
|                           |            |                                   |          | 'securityContext.capabilities.drop'      |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv003      |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV012   | Runs as root user                 |  MEDIUM  | Container 'autopermissions'              |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.runAsNonRoot' to true   |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv012      |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used          |   LOW    | Container 'RELEASE-NAME-memcached' of    |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-memcached'      |
|                           |            |                                   |          | should specify an image tag              |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv013      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-memcached'      |
|                           |            |                                   |          | should specify an image tag              |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv013      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV014   | Root file system is not read-only |          | Container 'autopermissions'              |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.readOnlyRootFilesystem' |
|                           |            |                                   |          | to true                                  |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv014      |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled         |  MEDIUM  | Container 'RELEASE-NAME-memcached' of    |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-memcached'      |
|                           |            |                                   |          | should specify a seccomp profile         |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv019      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-memcached'      |
|                           |            |                                   |          | should specify a seccomp profile         |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv019      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV020   | Runs with low user ID             |          | Container 'RELEASE-NAME-memcached'       |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.runAsUser' > 10000      |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv020      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions'              |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.runAsUser' > 10000      |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv020      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV021   | Runs with low group ID            |          | Container 'RELEASE-NAME-memcached'       |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.runAsGroup' > 10000     |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv021      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions'              |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-memcached' should set      |
|                           |            |                                   |          | 'securityContext.runAsGroup' > 10000     |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv021      |
+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
```

## Containers

##### Detected Containers

          tccr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          tccr.io/truecharts/memcached:v1.6.12@sha256:90da9d23e5c448d44ee3c1aa2af4c868ab5a3f8042a4000851fe55355db7c569

##### Scan Results

**Container: tccr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T19:48:26.594Z	[34mINFO[0m	Detected OS: alpine
2021-12-03T19:48:26.594Z	[34mINFO[0m	Detecting Alpine vulnerabilities...
2021-12-03T19:48:26.602Z	[34mINFO[0m	Number of language-specific files: 0

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

**Container: tccr.io/truecharts/memcached:v1.6.12@sha256:90da9d23e5c448d44ee3c1aa2af4c868ab5a3f8042a4000851fe55355db7c569**

```
2021-12-03T19:48:28.787Z	[34mINFO[0m	Detected OS: debian
2021-12-03T19:48:28.787Z	[34mINFO[0m	Detecting Debian vulnerabilities...
2021-12-03T19:48:28.804Z	[34mINFO[0m	Number of language-specific files: 1
2021-12-03T19:48:28.804Z	[34mINFO[0m	Detecting gobinary vulnerabilities...

tccr.io/truecharts/memcached:v1.6.12@sha256:90da9d23e5c448d44ee3c1aa2af4c868ab5a3f8042a4000851fe55355db7c569 (debian 10.11)
===========================================================================================================================
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

```

