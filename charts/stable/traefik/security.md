---
hide:
  - toc
---

# Security Overview

<link href="https://truecharts.org/_static/trivy.css" type="text/css" rel="stylesheet" />

## Helm-Chart

##### Scan Results

#### Chart Object: traefik/templates/common.yaml



| Type         |    Misconfiguration ID   |   Check  |  Severity |                   Explaination                   | Links  |
|:----------------|:------------------:|:-----------:|:------------------:|-----------------------------------------|-----------------------------------------|
| Kubernetes Security Check         |    KSV001   |   Process can elevate its own privileges  |  MEDIUM | <details><summary>Expand...</summary> A program inside the container can elevate its own privileges and run as root, which might give the program control over the container and node. <br> <hr> <br> Container &#39;RELEASE-NAME-traefik&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.allowPrivilegeEscalation&#39; to false </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv001">https://avd.aquasec.com/misconfig/ksv001</a><br></details>  |
| Kubernetes Security Check         |    KSV001   |   Process can elevate its own privileges  |  MEDIUM | <details><summary>Expand...</summary> A program inside the container can elevate its own privileges and run as root, which might give the program control over the container and node. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.allowPrivilegeEscalation&#39; to false </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv001">https://avd.aquasec.com/misconfig/ksv001</a><br></details>  |
| Kubernetes Security Check         |    KSV003   |   Default capabilities not dropped  |  LOW | <details><summary>Expand...</summary> The container should drop all default capabilities and add only those that are needed for its execution. <br> <hr> <br> Container &#39;RELEASE-NAME-traefik&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should add &#39;ALL&#39; to &#39;securityContext.capabilities.drop&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-capabilities-drop-index-all/">https://kubesec.io/basics/containers-securitycontext-capabilities-drop-index-all/</a><br><a href="https://avd.aquasec.com/misconfig/ksv003">https://avd.aquasec.com/misconfig/ksv003</a><br></details>  |
| Kubernetes Security Check         |    KSV003   |   Default capabilities not dropped  |  LOW | <details><summary>Expand...</summary> The container should drop all default capabilities and add only those that are needed for its execution. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should add &#39;ALL&#39; to &#39;securityContext.capabilities.drop&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-capabilities-drop-index-all/">https://kubesec.io/basics/containers-securitycontext-capabilities-drop-index-all/</a><br><a href="https://avd.aquasec.com/misconfig/ksv003">https://avd.aquasec.com/misconfig/ksv003</a><br></details>  |
| Kubernetes Security Check         |    KSV012   |   Runs as root user  |  MEDIUM | <details><summary>Expand...</summary> &#39;runAsNonRoot&#39; forces the running image to run as a non-root user to ensure least privileges. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.runAsNonRoot&#39; to true </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv012">https://avd.aquasec.com/misconfig/ksv012</a><br></details>  |
| Kubernetes Security Check         |    KSV014   |   Root file system is not read-only  |  LOW | <details><summary>Expand...</summary> An immutable root file system prevents applications from writing to their local disk. This can limit intrusions, as attackers will not be able to tamper with the file system or write foreign executables to disk. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.readOnlyRootFilesystem&#39; to true </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-readonlyrootfilesystem-true/">https://kubesec.io/basics/containers-securitycontext-readonlyrootfilesystem-true/</a><br><a href="https://avd.aquasec.com/misconfig/ksv014">https://avd.aquasec.com/misconfig/ksv014</a><br></details>  |
| Kubernetes Security Check         |    KSV017   |   Privileged container  |  HIGH | <details><summary>Expand...</summary> Privileged containers share namespaces with the host system and do not offer any security. They should be used exclusively for system containers that require high privileges. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.privileged&#39; to false </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline">https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline</a><br><a href="https://avd.aquasec.com/misconfig/ksv017">https://avd.aquasec.com/misconfig/ksv017</a><br></details>  |
| Kubernetes Security Check         |    KSV020   |   Runs with low user ID  |  LOW | <details><summary>Expand...</summary> Force the container to run with user ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;RELEASE-NAME-traefik&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.runAsUser&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/misconfig/ksv020">https://avd.aquasec.com/misconfig/ksv020</a><br></details>  |
| Kubernetes Security Check         |    KSV020   |   Runs with low user ID  |  LOW | <details><summary>Expand...</summary> Force the container to run with user ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.runAsUser&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/misconfig/ksv020">https://avd.aquasec.com/misconfig/ksv020</a><br></details>  |
| Kubernetes Security Check         |    KSV021   |   Runs with low group ID  |  LOW | <details><summary>Expand...</summary> Force the container to run with group ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;RELEASE-NAME-traefik&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.runAsGroup&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/misconfig/ksv021">https://avd.aquasec.com/misconfig/ksv021</a><br></details>  |
| Kubernetes Security Check         |    KSV021   |   Runs with low group ID  |  LOW | <details><summary>Expand...</summary> Force the container to run with group ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;autopermissions&#39; of Deployment &#39;RELEASE-NAME-traefik&#39; should set &#39;securityContext.runAsGroup&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/misconfig/ksv021">https://avd.aquasec.com/misconfig/ksv021</a><br></details>  |
| Kubernetes Security Check         |    KSV030   |   Default Seccomp profile not set  |  LOW | <details><summary>Expand...</summary> The RuntimeDefault/Localhost seccomp profile must be required, or allow specific additional profiles. <br> <hr> <br> Either Pod or Container should set &#39;securityContext.seccompProfile.type&#39; to &#39;RuntimeDefault&#39; </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv030">https://avd.aquasec.com/misconfig/ksv030</a><br></details>  |
| Kubernetes Security Check         |    KSV030   |   Default Seccomp profile not set  |  LOW | <details><summary>Expand...</summary> The RuntimeDefault/Localhost seccomp profile must be required, or allow specific additional profiles. <br> <hr> <br> Either Pod or Container should set &#39;securityContext.seccompProfile.type&#39; to &#39;RuntimeDefault&#39; </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv030">https://avd.aquasec.com/misconfig/ksv030</a><br></details>  |
| Kubernetes Security Check         |    KSV105   |   Containers must not set runAsUser to 0  |  LOW | <details><summary>Expand...</summary> Containers should be forbidden from running with a root UID. <br> <hr> <br> securityContext.runAsUser should be set to a value greater than 0 </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv105">https://avd.aquasec.com/misconfig/ksv105</a><br></details>  |
| Kubernetes Security Check         |    KSV106   |   Container capabilities must only include NET_BIND_SERVICE  |  LOW | <details><summary>Expand...</summary> Containers must drop ALL capabilities, and are only permitted to add back the NET_BIND_SERVICE capability. <br> <hr> <br> container should drop all </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv106">https://avd.aquasec.com/misconfig/ksv106</a><br></details>  |
| Kubernetes Security Check         |    KSV106   |   Container capabilities must only include NET_BIND_SERVICE  |  LOW | <details><summary>Expand...</summary> Containers must drop ALL capabilities, and are only permitted to add back the NET_BIND_SERVICE capability. <br> <hr> <br> container should drop all </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/misconfig/ksv106">https://avd.aquasec.com/misconfig/ksv106</a><br></details>  |


| No Misconfigurations found         |
|:---------------------------------|




| No Misconfigurations found         |
|:---------------------------------|




| No Misconfigurations found         |
|:---------------------------------|




| No Misconfigurations found         |
|:---------------------------------|



## Containers

##### Detected Containers

          tccr.io/truecharts/alpine:v3.16.0@sha256:16dc15f3d61a1e30b1df9f839e53636847b6097286b2b74c637b25fd8264f730
          tccr.io/truecharts/traefik:v2.7.1@sha256:82ca1c80d44222f330264c1db7a02eff0fd2d4db4cdf53e7711cb6adeaeba9e4

##### Scan Results


#### Container: tccr.io/truecharts/alpine:v3.16.0@sha256:16dc15f3d61a1e30b1df9f839e53636847b6097286b2b74c637b25fd8264f730 (alpine 3.16.0)


**alpine**


| No Vulnerabilities found         |
|:---------------------------------|




#### Container: tccr.io/truecharts/traefik:v2.7.1@sha256:82ca1c80d44222f330264c1db7a02eff0fd2d4db4cdf53e7711cb6adeaeba9e4 (alpine 3.15.4)


**alpine**


| No Vulnerabilities found         |
|:---------------------------------|



**gobinary**


| Package         |    Vulnerability   |   Severity  |  Installed Version | Fixed Version |                   Links                   |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|
| github.com/containerd/containerd         |    CVE-2022-23648   |   HIGH  |  v1.5.9 | 1.4.13, 1.5.10, 1.6.1 | <details><summary>Expand...</summary><a href="http://packetstormsecurity.com/files/166421/containerd-Image-Volume-Insecure-Handling.html">http://packetstormsecurity.com/files/166421/containerd-Image-Volume-Insecure-Handling.html</a><br><a href="https://access.redhat.com/security/cve/CVE-2022-23648">https://access.redhat.com/security/cve/CVE-2022-23648</a><br><a href="https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23648">https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-23648</a><br><a href="https://github.com/advisories/GHSA-crp2-qrr5-8pq7">https://github.com/advisories/GHSA-crp2-qrr5-8pq7</a><br><a href="https://github.com/containerd/containerd/commit/10f428dac7cec44c864e1b830a4623af27a9fc70">https://github.com/containerd/containerd/commit/10f428dac7cec44c864e1b830a4623af27a9fc70</a><br><a href="https://github.com/containerd/containerd/releases/tag/v1.4.13">https://github.com/containerd/containerd/releases/tag/v1.4.13</a><br><a href="https://github.com/containerd/containerd/releases/tag/v1.5.10">https://github.com/containerd/containerd/releases/tag/v1.5.10</a><br><a href="https://github.com/containerd/containerd/releases/tag/v1.6.1">https://github.com/containerd/containerd/releases/tag/v1.6.1</a><br><a href="https://github.com/containerd/containerd/security/advisories/GHSA-crp2-qrr5-8pq7">https://github.com/containerd/containerd/security/advisories/GHSA-crp2-qrr5-8pq7</a><br><a href="https://github.com/containerd/containerd/security/advisories/GHSA-crp2-qrr5-8pq7.">https://github.com/containerd/containerd/security/advisories/GHSA-crp2-qrr5-8pq7.</a><br><a href="https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/AUDQUQBZJGBWJPMRVB6QCCCRF7O3O4PA/">https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/AUDQUQBZJGBWJPMRVB6QCCCRF7O3O4PA/</a><br><a href="https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/HFTS2EF3S7HNYSNZSEJZIJHPRU7OPUV3/">https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/HFTS2EF3S7HNYSNZSEJZIJHPRU7OPUV3/</a><br><a href="https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/OCCARJ6FU4MWBTXHZNMS7NELPDBIX2VO/">https://lists.fedoraproject.org/archives/list/package-announce@lists.fedoraproject.org/message/OCCARJ6FU4MWBTXHZNMS7NELPDBIX2VO/</a><br><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-23648">https://nvd.nist.gov/vuln/detail/CVE-2022-23648</a><br><a href="https://ubuntu.com/security/notices/USN-5311-1">https://ubuntu.com/security/notices/USN-5311-1</a><br><a href="https://ubuntu.com/security/notices/USN-5311-2">https://ubuntu.com/security/notices/USN-5311-2</a><br><a href="https://www.debian.org/security/2022/dsa-5091">https://www.debian.org/security/2022/dsa-5091</a><br></details>  |
| github.com/docker/distribution         |    GHSA-qq97-vm5h-rrhg   |   UNKNOWN  |  v2.7.1+incompatible | v2.8.0 | <details><summary>Expand...</summary><a href="https://github.com/advisories/GHSA-qq97-vm5h-rrhg">https://github.com/advisories/GHSA-qq97-vm5h-rrhg</a><br><a href="https://github.com/distribution/distribution/commit/b59a6f827947f9e0e67df0cfb571046de4733586">https://github.com/distribution/distribution/commit/b59a6f827947f9e0e67df0cfb571046de4733586</a><br><a href="https://github.com/distribution/distribution/security/advisories/GHSA-qq97-vm5h-rrhg">https://github.com/distribution/distribution/security/advisories/GHSA-qq97-vm5h-rrhg</a><br><a href="https://github.com/opencontainers/image-spec/pull/411">https://github.com/opencontainers/image-spec/pull/411</a><br></details>  |
| github.com/hashicorp/consul         |    CVE-2022-29153   |   HIGH  |  v1.10.4 | 1.9.17, 1.10.10, 1.11.5 | <details><summary>Expand...</summary><a href="https://discuss.hashicorp.com">https://discuss.hashicorp.com</a><br><a href="https://discuss.hashicorp.com/t/hcsec-2022-10-consul-s-http-health-check-may-allow-server-side-request-forgery/38393">https://discuss.hashicorp.com/t/hcsec-2022-10-consul-s-http-health-check-may-allow-server-side-request-forgery/38393</a><br><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-29153">https://nvd.nist.gov/vuln/detail/CVE-2022-29153</a><br><a href="https://security.netapp.com/advisory/ntap-20220602-0005/">https://security.netapp.com/advisory/ntap-20220602-0005/</a><br></details>  |
| github.com/hashicorp/consul         |    CVE-2022-24687   |   MEDIUM  |  v1.10.4 | 1.9.15, 1.10.8, 1.11.3 | <details><summary>Expand...</summary><a href="https://discuss.hashicorp.com">https://discuss.hashicorp.com</a><br><a href="https://discuss.hashicorp.com/t/hcsec-2022-05-consul-ingress-gateway-panic-can-shutdown-servers/">https://discuss.hashicorp.com/t/hcsec-2022-05-consul-ingress-gateway-panic-can-shutdown-servers/</a><br><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-24687">https://nvd.nist.gov/vuln/detail/CVE-2022-24687</a><br><a href="https://security.netapp.com/advisory/ntap-20220331-0006/">https://security.netapp.com/advisory/ntap-20220331-0006/</a><br></details>  |
