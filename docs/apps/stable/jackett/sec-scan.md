# Security Scan

## Helm-Chart

##### Scan Results

```
2021-12-03T18:33:16.449Z    [34mINFO[0m    Need to update the built-in policies
2021-12-03T18:33:16.449Z    [34mINFO[0m    Downloading the built-in policies...
2021-12-03T18:33:17.259Z    [34mINFO[0m    Detected config files: 1

jackett/templates/common.yaml (kubernetes)
==========================================
Tests: 40 (SUCCESSES: 28, FAILURES: 12, EXCEPTIONS: 0)
Failures: 12 (UNKNOWN: 0, LOW: 5, MEDIUM: 7, HIGH: 0, CRITICAL: 0)

+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
|           TYPE            | MISCONF ID |               CHECK               | SEVERITY |                 MESSAGE                  |
+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
| Kubernetes Security Check |   KSV003   | Default capabilities not dropped  |   LOW    | Container 'RELEASE-NAME-jackett' of      |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett'        |
|                           |            |                                   |          | should add 'ALL' to                      |
|                           |            |                                   |          | 'securityContext.capabilities.drop'      |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv003      |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV012   | Runs as root user                 |  MEDIUM  | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett' should |
|                           |            |                                   |          | set 'securityContext.runAsNonRoot' to    |
|                           |            |                                   |          | true -->avd.aquasec.com/appshield/ksv012 |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV013   | Image tag ':latest' used          |   LOW    | Container 'RELEASE-NAME-jackett' of      |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett'        |
|                           |            |                                   |          | should specify an image tag              |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv013      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett'        |
|                           |            |                                   |          | should specify an image tag              |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv013      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV014   | Root file system is not read-only |          | Container 'RELEASE-NAME-jackett'         |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-jackett' should set        |
|                           |            |                                   |          | 'securityContext.readOnlyRootFilesystem' |
|                           |            |                                   |          | to true                                  |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv014      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions'              |
|                           |            |                                   |          | of Deployment                            |
|                           |            |                                   |          | 'RELEASE-NAME-jackett' should set        |
|                           |            |                                   |          | 'securityContext.readOnlyRootFilesystem' |
|                           |            |                                   |          | to true                                  |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv014      |
+                           +------------+-----------------------------------+----------+------------------------------------------+
|                           |   KSV019   | Seccomp policies disabled         |  MEDIUM  | Container 'RELEASE-NAME-jackett' of      |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett'        |
|                           |            |                                   |          | should specify a seccomp profile         |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv019      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett'        |
|                           |            |                                   |          | should specify a seccomp profile         |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv019      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV020   | Runs with low user ID             |          | Container 'RELEASE-NAME-jackett' of      |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett' should |
|                           |            |                                   |          | set 'securityContext.runAsUser' > 10000  |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv020      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett' should |
|                           |            |                                   |          | set 'securityContext.runAsUser' > 10000  |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv020      |
+                           +------------+-----------------------------------+          +------------------------------------------+
|                           |   KSV021   | Runs with low group ID            |          | Container 'RELEASE-NAME-jackett' of      |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett' should |
|                           |            |                                   |          | set 'securityContext.runAsGroup' > 10000 |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv021      |
+                           +            +                                   +          +------------------------------------------+
|                           |            |                                   |          | Container 'autopermissions' of           |
|                           |            |                                   |          | Deployment 'RELEASE-NAME-jackett' should |
|                           |            |                                   |          | set 'securityContext.runAsGroup' > 10000 |
|                           |            |                                   |          | -->avd.aquasec.com/appshield/ksv021      |
+---------------------------+------------+-----------------------------------+----------+------------------------------------------+
```

## Containers

##### Detected Containers

          ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c
          tccr.io/truecharts/jackett:v0.20.83@sha256:b24ade69bfc1b9725c42043c0b4aab341aed7c2cb462fdc21bb5287aaa574d79

##### Scan Results

**Container: ghcr.io/truecharts/alpine:v3.14.2@sha256:4095394abbae907e94b1f2fd2e2de6c4f201a5b9704573243ca8eb16db8cdb7c**

```
2021-12-03T18:33:17.339Z    [34mINFO[0m    Need to update DB
2021-12-03T18:33:17.340Z    [34mINFO[0m    Downloading DB...
2021-12-03T18:33:19.939Z    [34mINFO[0m    Detected OS: alpine
2021-12-03T18:33:19.939Z    [34mINFO[0m    Detecting Alpine vulnerabilities...
2021-12-03T18:33:19.941Z    [34mINFO[0m    Number of language-specific files: 0

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

**Container: tccr.io/truecharts/jackett:v0.20.83@sha256:b24ade69bfc1b9725c42043c0b4aab341aed7c2cb462fdc21bb5287aaa574d79**

```
2021-12-03T18:33:24.300Z    [34mINFO[0m    Detected OS: ubuntu
2021-12-03T18:33:24.300Z    [34mINFO[0m    Detecting Ubuntu vulnerabilities...
2021-12-03T18:33:24.303Z    [34mINFO[0m    Number of language-specific files: 1
2021-12-03T18:33:24.303Z    [34mINFO[0m    Detecting gobinary vulnerabilities...

tccr.io/truecharts/jackett:v0.20.83@sha256:b24ade69bfc1b9725c42043c0b4aab341aed7c2cb462fdc21bb5287aaa574d79 (ubuntu 20.04)
==========================================================================================================================
Total: 76 (UNKNOWN: 0, LOW: 52, MEDIUM: 24, HIGH: 0, CRITICAL: 0)

+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
|       LIBRARY        | VULNERABILITY ID | SEVERITY |    INSTALLED VERSION     |      FIXED VERSION      |                  TITLE                  |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| bash                 | CVE-2019-18276   | LOW      | 5.0-6ubuntu1.1           |                         | bash: when effective UID is not         |
|                      |                  |          |                          |                         | equal to its real UID the...            |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2019-18276   |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| bind9-dnsutils       | CVE-2021-25219   | MEDIUM   | 1:9.16.1-0ubuntu2.8      | 1:9.16.1-0ubuntu2.9     | bind: Lame cache can be abused to       |
|                      |                  |          |                          |                         | severely degrade resolver performance   |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-25219   |
+----------------------+                  +          +                          +                         +                                         +
| bind9-host           |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+                  +          +                          +                         +                                         +
| bind9-libs           |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| coreutils            | CVE-2016-2781    | LOW      | 8.30-3ubuntu2            |                         | coreutils: Non-privileged               |
|                      |                  |          |                          |                         | session can escape to the               |
|                      |                  |          |                          |                         | parent session in chroot                |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2016-2781    |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| dnsutils             | CVE-2021-25219   | MEDIUM   | 1:9.16.1-0ubuntu2.8      | 1:9.16.1-0ubuntu2.9     | bind: Lame cache can be abused to       |
|                      |                  |          |                          |                         | severely degrade resolver performance   |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-25219   |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libasn1-8-heimdal    | CVE-2021-3671    | LOW      | 7.7.0+dfsg-1ubuntu1      |                         | samba: Null pointer dereference         |
|                      |                  |          |                          |                         | on missing sname in TGS-REQ             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3671    |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libc-bin             | CVE-2021-35942   | MEDIUM   | 2.31-0ubuntu9.2          |                         | glibc: Arbitrary read in wordexp()      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-35942   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-38604   |          |                          |                         | glibc: NULL pointer dereference in      |
|                      |                  |          |                          |                         | helper_thread() in mq_notify.c while    |
|                      |                  |          |                          |                         | handling NOTIFY_REMOVED messages...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-38604   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2016-10228   | LOW      |                          |                         | glibc: iconv program can hang           |
|                      |                  |          |                          |                         | when invoked with the -c option         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2016-10228   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2019-25013   |          |                          |                         | glibc: buffer over-read in              |
|                      |                  |          |                          |                         | iconv when processing invalid           |
|                      |                  |          |                          |                         | multi-byte input sequences in...        |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2019-25013   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-27618   |          |                          |                         | glibc: iconv when processing            |
|                      |                  |          |                          |                         | invalid multi-byte input                |
|                      |                  |          |                          |                         | sequences fails to advance the...       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-27618   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-29562   |          |                          |                         | glibc: assertion failure in iconv       |
|                      |                  |          |                          |                         | when converting invalid UCS4            |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-29562   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-6096    |          |                          |                         | glibc: signed comparison                |
|                      |                  |          |                          |                         | vulnerability in the                    |
|                      |                  |          |                          |                         | ARMv7 memcpy function                   |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-6096    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-27645   |          |                          |                         | glibc: Use-after-free in                |
|                      |                  |          |                          |                         | addgetnetgrentX function                |
|                      |                  |          |                          |                         | in netgroupcache.c                      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-27645   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3326    |          |                          |                         | glibc: Assertion failure in             |
|                      |                  |          |                          |                         | ISO-2022-JP-3 gconv module              |
|                      |                  |          |                          |                         | related to combining characters         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3326    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-33574   |          |                          |                         | glibc: mq_notify does                   |
|                      |                  |          |                          |                         | not handle separately                   |
|                      |                  |          |                          |                         | allocated thread attributes             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-33574   |
+----------------------+------------------+----------+                          +-------------------------+-----------------------------------------+
| libc6                | CVE-2021-35942   | MEDIUM   |                          |                         | glibc: Arbitrary read in wordexp()      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-35942   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-38604   |          |                          |                         | glibc: NULL pointer dereference in      |
|                      |                  |          |                          |                         | helper_thread() in mq_notify.c while    |
|                      |                  |          |                          |                         | handling NOTIFY_REMOVED messages...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-38604   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2016-10228   | LOW      |                          |                         | glibc: iconv program can hang           |
|                      |                  |          |                          |                         | when invoked with the -c option         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2016-10228   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2019-25013   |          |                          |                         | glibc: buffer over-read in              |
|                      |                  |          |                          |                         | iconv when processing invalid           |
|                      |                  |          |                          |                         | multi-byte input sequences in...        |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2019-25013   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-27618   |          |                          |                         | glibc: iconv when processing            |
|                      |                  |          |                          |                         | invalid multi-byte input                |
|                      |                  |          |                          |                         | sequences fails to advance the...       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-27618   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-29562   |          |                          |                         | glibc: assertion failure in iconv       |
|                      |                  |          |                          |                         | when converting invalid UCS4            |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-29562   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-6096    |          |                          |                         | glibc: signed comparison                |
|                      |                  |          |                          |                         | vulnerability in the                    |
|                      |                  |          |                          |                         | ARMv7 memcpy function                   |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-6096    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-27645   |          |                          |                         | glibc: Use-after-free in                |
|                      |                  |          |                          |                         | addgetnetgrentX function                |
|                      |                  |          |                          |                         | in netgroupcache.c                      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-27645   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3326    |          |                          |                         | glibc: Assertion failure in             |
|                      |                  |          |                          |                         | ISO-2022-JP-3 gconv module              |
|                      |                  |          |                          |                         | related to combining characters         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3326    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-33574   |          |                          |                         | glibc: mq_notify does                   |
|                      |                  |          |                          |                         | not handle separately                   |
|                      |                  |          |                          |                         | allocated thread attributes             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-33574   |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libgmp10             | CVE-2021-43618   |          | 2:6.2.0+dfsg-4           |                         | gmp: Integer overflow and resultant     |
|                      |                  |          |                          |                         | buffer overflow via crafted input       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-43618   |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libgssapi-krb5-2     | CVE-2021-36222   | MEDIUM   | 1.17-6ubuntu4.1          |                         | krb5: Sending a request containing      |
|                      |                  |          |                          |                         | PA-ENCRYPTED-CHALLENGE padata           |
|                      |                  |          |                          |                         | element without using FAST could...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-36222   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2018-5709    | LOW      |                          |                         | krb5: integer overflow                  |
|                      |                  |          |                          |                         | in dbentry->n_key_data                  |
|                      |                  |          |                          |                         | in kadmin/dbutil/dump.c                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2018-5709    |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libgssapi3-heimdal   | CVE-2021-3671    |          | 7.7.0+dfsg-1ubuntu1      |                         | samba: Null pointer dereference         |
|                      |                  |          |                          |                         | on missing sname in TGS-REQ             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3671    |
+----------------------+                  +          +                          +-------------------------+                                         +
| libhcrypto4-heimdal  |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+                  +          +                          +-------------------------+                                         +
| libheimbase1-heimdal |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+                  +          +                          +-------------------------+                                         +
| libheimntlm0-heimdal |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+                  +          +                          +-------------------------+                                         +
| libhx509-5-heimdal   |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libk5crypto3         | CVE-2021-36222   | MEDIUM   | 1.17-6ubuntu4.1          |                         | krb5: Sending a request containing      |
|                      |                  |          |                          |                         | PA-ENCRYPTED-CHALLENGE padata           |
|                      |                  |          |                          |                         | element without using FAST could...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-36222   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2018-5709    | LOW      |                          |                         | krb5: integer overflow                  |
|                      |                  |          |                          |                         | in dbentry->n_key_data                  |
|                      |                  |          |                          |                         | in kadmin/dbutil/dump.c                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2018-5709    |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libkrb5-26-heimdal   | CVE-2021-3671    |          | 7.7.0+dfsg-1ubuntu1      |                         | samba: Null pointer dereference         |
|                      |                  |          |                          |                         | on missing sname in TGS-REQ             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3671    |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libkrb5-3            | CVE-2021-36222   | MEDIUM   | 1.17-6ubuntu4.1          |                         | krb5: Sending a request containing      |
|                      |                  |          |                          |                         | PA-ENCRYPTED-CHALLENGE padata           |
|                      |                  |          |                          |                         | element without using FAST could...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-36222   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2018-5709    | LOW      |                          |                         | krb5: integer overflow                  |
|                      |                  |          |                          |                         | in dbentry->n_key_data                  |
|                      |                  |          |                          |                         | in kadmin/dbutil/dump.c                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2018-5709    |
+----------------------+------------------+----------+                          +-------------------------+-----------------------------------------+
| libkrb5support0      | CVE-2021-36222   | MEDIUM   |                          |                         | krb5: Sending a request containing      |
|                      |                  |          |                          |                         | PA-ENCRYPTED-CHALLENGE padata           |
|                      |                  |          |                          |                         | element without using FAST could...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-36222   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2018-5709    | LOW      |                          |                         | krb5: integer overflow                  |
|                      |                  |          |                          |                         | in dbentry->n_key_data                  |
|                      |                  |          |                          |                         | in kadmin/dbutil/dump.c                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2018-5709    |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libpcre3             | CVE-2017-11164   |          | 2:8.39-12build1          |                         | pcre: OP_KETRMAX feature in the         |
|                      |                  |          |                          |                         | match function in pcre_exec.c           |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2017-11164   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2019-20838   |          |                          |                         | pcre: Buffer over-read in JIT           |
|                      |                  |          |                          |                         | when UTF is disabled and \X or...       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2019-20838   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-14155   |          |                          |                         | pcre: Integer overflow when             |
|                      |                  |          |                          |                         | parsing callout numeric arguments       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-14155   |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libpython3.8-minimal | CVE-2021-29921   | MEDIUM   | 3.8.10-0ubuntu1~20.04    | 3.8.10-0ubuntu1~20.04.1 | python-ipaddress: Improper input        |
|                      |                  |          |                          |                         | validation of octal strings             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-29921   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3737    |          |                          |                         | python: urllib: HTTP client             |
|                      |                  |          |                          |                         | possible infinite loop on               |
|                      |                  |          |                          |                         | a 100 Continue response...              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3737    |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-23336   | LOW      |                          |                         | python: Web cache poisoning             |
|                      |                  |          |                          |                         | via urllib.parse.parse_qsl              |
|                      |                  |          |                          |                         | and urllib.parse.parse_qs               |
|                      |                  |          |                          |                         | by using a semicolon...                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-23336   |
+----------------------+------------------+----------+                          +-------------------------+-----------------------------------------+
| libpython3.8-stdlib  | CVE-2021-29921   | MEDIUM   |                          | 3.8.10-0ubuntu1~20.04.1 | python-ipaddress: Improper input        |
|                      |                  |          |                          |                         | validation of octal strings             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-29921   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3737    |          |                          |                         | python: urllib: HTTP client             |
|                      |                  |          |                          |                         | possible infinite loop on               |
|                      |                  |          |                          |                         | a 100 Continue response...              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3737    |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-23336   | LOW      |                          |                         | python: Web cache poisoning             |
|                      |                  |          |                          |                         | via urllib.parse.parse_qsl              |
|                      |                  |          |                          |                         | and urllib.parse.parse_qs               |
|                      |                  |          |                          |                         | by using a semicolon...                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-23336   |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libroken18-heimdal   | CVE-2021-3671    |          | 7.7.0+dfsg-1ubuntu1      |                         | samba: Null pointer dereference         |
|                      |                  |          |                          |                         | on missing sname in TGS-REQ             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3671    |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| libsqlite3-0         | CVE-2020-9794    | MEDIUM   | 3.31.1-4ubuntu0.2        |                         | An out-of-bounds read was               |
|                      |                  |          |                          |                         | addressed with improved bounds          |
|                      |                  |          |                          |                         | checking. This issue is...              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-9794    |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-9849    | LOW      |                          |                         | An information disclosure issue         |
|                      |                  |          |                          |                         | was addressed with improved             |
|                      |                  |          |                          |                         | state management. This issue...         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-9849    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-9991    |          |                          |                         | This issue was addressed                |
|                      |                  |          |                          |                         | with improved checks.                   |
|                      |                  |          |                          |                         | This issue is fixed in...               |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-9991    |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libtasn1-6           | CVE-2018-1000654 |          | 4.16.0-2                 |                         | libtasn1: Infinite loop in              |
|                      |                  |          |                          |                         | _asn1_expand_object_id(ptree)           |
|                      |                  |          |                          |                         | leads to memory exhaustion              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2018-1000654 |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| libwind0-heimdal     | CVE-2021-3671    |          | 7.7.0+dfsg-1ubuntu1      |                         | samba: Null pointer dereference         |
|                      |                  |          |                          |                         | on missing sname in TGS-REQ             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3671    |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| locales              | CVE-2021-35942   | MEDIUM   | 2.31-0ubuntu9.2          |                         | glibc: Arbitrary read in wordexp()      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-35942   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-38604   |          |                          |                         | glibc: NULL pointer dereference in      |
|                      |                  |          |                          |                         | helper_thread() in mq_notify.c while    |
|                      |                  |          |                          |                         | handling NOTIFY_REMOVED messages...     |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-38604   |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2016-10228   | LOW      |                          |                         | glibc: iconv program can hang           |
|                      |                  |          |                          |                         | when invoked with the -c option         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2016-10228   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2019-25013   |          |                          |                         | glibc: buffer over-read in              |
|                      |                  |          |                          |                         | iconv when processing invalid           |
|                      |                  |          |                          |                         | multi-byte input sequences in...        |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2019-25013   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-27618   |          |                          |                         | glibc: iconv when processing            |
|                      |                  |          |                          |                         | invalid multi-byte input                |
|                      |                  |          |                          |                         | sequences fails to advance the...       |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-27618   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-29562   |          |                          |                         | glibc: assertion failure in iconv       |
|                      |                  |          |                          |                         | when converting invalid UCS4            |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-29562   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2020-6096    |          |                          |                         | glibc: signed comparison                |
|                      |                  |          |                          |                         | vulnerability in the                    |
|                      |                  |          |                          |                         | ARMv7 memcpy function                   |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-6096    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-27645   |          |                          |                         | glibc: Use-after-free in                |
|                      |                  |          |                          |                         | addgetnetgrentX function                |
|                      |                  |          |                          |                         | in netgroupcache.c                      |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-27645   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3326    |          |                          |                         | glibc: Assertion failure in             |
|                      |                  |          |                          |                         | ISO-2022-JP-3 gconv module              |
|                      |                  |          |                          |                         | related to combining characters         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3326    |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-33574   |          |                          |                         | glibc: mq_notify does                   |
|                      |                  |          |                          |                         | not handle separately                   |
|                      |                  |          |                          |                         | allocated thread attributes             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-33574   |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| login                | CVE-2013-4235    |          | 1:4.8.1-1ubuntu5.20.04.1 |                         | shadow-utils: TOCTOU race               |
|                      |                  |          |                          |                         | conditions by copying and               |
|                      |                  |          |                          |                         | removing directory trees                |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2013-4235    |
+----------------------+                  +          +                          +-------------------------+                                         +
| passwd               |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
|                      |                  |          |                          |                         |                                         |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+
| perl-base            | CVE-2020-16156   | MEDIUM   | 5.30.0-9ubuntu0.2        |                         | [Signature Verification Bypass]         |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2020-16156   |
+----------------------+------------------+          +--------------------------+-------------------------+-----------------------------------------+
| python3.8            | CVE-2021-29921   |          | 3.8.10-0ubuntu1~20.04    | 3.8.10-0ubuntu1~20.04.1 | python-ipaddress: Improper input        |
|                      |                  |          |                          |                         | validation of octal strings             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-29921   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3737    |          |                          |                         | python: urllib: HTTP client             |
|                      |                  |          |                          |                         | possible infinite loop on               |
|                      |                  |          |                          |                         | a 100 Continue response...              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3737    |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-23336   | LOW      |                          |                         | python: Web cache poisoning             |
|                      |                  |          |                          |                         | via urllib.parse.parse_qsl              |
|                      |                  |          |                          |                         | and urllib.parse.parse_qs               |
|                      |                  |          |                          |                         | by using a semicolon...                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-23336   |
+----------------------+------------------+----------+                          +-------------------------+-----------------------------------------+
| python3.8-minimal    | CVE-2021-29921   | MEDIUM   |                          | 3.8.10-0ubuntu1~20.04.1 | python-ipaddress: Improper input        |
|                      |                  |          |                          |                         | validation of octal strings             |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-29921   |
+                      +------------------+          +                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-3737    |          |                          |                         | python: urllib: HTTP client             |
|                      |                  |          |                          |                         | possible infinite loop on               |
|                      |                  |          |                          |                         | a 100 Continue response...              |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-3737    |
+                      +------------------+----------+                          +-------------------------+-----------------------------------------+
|                      | CVE-2021-23336   | LOW      |                          |                         | python: Web cache poisoning             |
|                      |                  |          |                          |                         | via urllib.parse.parse_qsl              |
|                      |                  |          |                          |                         | and urllib.parse.parse_qs               |
|                      |                  |          |                          |                         | by using a semicolon...                 |
|                      |                  |          |                          |                         | -->avd.aquasec.com/nvd/cve-2021-23336   |
+----------------------+------------------+----------+--------------------------+-------------------------+-----------------------------------------+

usr/local/bin/micro (gobinary)
==============================
Total: 1 (UNKNOWN: 0, LOW: 0, MEDIUM: 1, HIGH: 0, CRITICAL: 0)

+------------------+------------------+----------+-------------------+---------------+---------------------------------------+
|     LIBRARY      | VULNERABILITY ID | SEVERITY | INSTALLED VERSION | FIXED VERSION |                 TITLE                 |
+------------------+------------------+----------+-------------------+---------------+---------------------------------------+
| gopkg.in/yaml.v2 | CVE-2019-11254   | MEDIUM   | v2.2.7            | v2.2.8        | kubernetes: Denial of                 |
|                  |                  |          |                   |               | service in API server via             |
|                  |                  |          |                   |               | crafted YAML payloads by...           |
|                  |                  |          |                   |               | -->avd.aquasec.com/nvd/cve-2019-11254 |
+------------------+------------------+----------+-------------------+---------------+---------------------------------------+
```
