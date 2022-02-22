---
hide:
  - toc
---

# Security Overview

<link href="https://truecharts.org/_static/trivy.css" type="text/css" rel="stylesheet" />

## Helm-Chart

##### Scan Results

#### Chart Object: metallb/charts/metallb/templates/controller.yaml



| Type         |    Misconfiguration ID   |   Check  |  Severity |                   Explaination                   | Links  |
|:----------------|:------------------:|:-----------:|:------------------:|-----------------------------------------|-----------------------------------------|
| Kubernetes Security Check         |    KSV011   |   CPU not limited  |  LOW | <details><summary>Expand...</summary> Enforcing CPU limits prevents DoS via resource exhaustion. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;resources.limits.cpu&#39; </details>| <details><summary>Expand...</summary><a href="https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits">https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits</a><br><a href="https://avd.aquasec.com/appshield/ksv011">https://avd.aquasec.com/appshield/ksv011</a><br></details>  |
| Kubernetes Security Check         |    KSV015   |   CPU requests not specified  |  LOW | <details><summary>Expand...</summary> When containers have resource requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;resources.requests.cpu&#39; </details>| <details><summary>Expand...</summary><a href="https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits">https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits</a><br><a href="https://avd.aquasec.com/appshield/ksv015">https://avd.aquasec.com/appshield/ksv015</a><br></details>  |
| Kubernetes Security Check         |    KSV016   |   Memory requests not specified  |  LOW | <details><summary>Expand...</summary> When containers have memory requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;resources.requests.memory&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-resources-limits-memory/">https://kubesec.io/basics/containers-resources-limits-memory/</a><br><a href="https://avd.aquasec.com/appshield/ksv016">https://avd.aquasec.com/appshield/ksv016</a><br></details>  |
| Kubernetes Security Check         |    KSV018   |   Memory not limited  |  LOW | <details><summary>Expand...</summary> Enforcing memory limits prevents DoS via resource exhaustion. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;resources.limits.memory&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-resources-limits-memory/">https://kubesec.io/basics/containers-resources-limits-memory/</a><br><a href="https://avd.aquasec.com/appshield/ksv018">https://avd.aquasec.com/appshield/ksv018</a><br></details>  |
| Kubernetes Security Check         |    KSV020   |   Runs with low user ID  |  MEDIUM | <details><summary>Expand...</summary> Force the container to run with user ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;securityContext.runAsUser&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/appshield/ksv020">https://avd.aquasec.com/appshield/ksv020</a><br></details>  |
| Kubernetes Security Check         |    KSV021   |   Runs with low group ID  |  MEDIUM | <details><summary>Expand...</summary> Force the container to run with group ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;controller&#39; of Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;securityContext.runAsGroup&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/appshield/ksv021">https://avd.aquasec.com/appshield/ksv021</a><br></details>  |
| Kubernetes Security Check         |    KSV029   |   A root primary or supplementary GID set  |  LOW | <details><summary>Expand...</summary> Containers should be forbidden from running with a root primary or supplementary GID. <br> <hr> <br> Deployment &#39;RELEASE-NAME-metallb-controller&#39; should set &#39;spec.securityContext.runAsGroup&#39;, &#39;spec.securityContext.supplementalGroups[*]&#39; and &#39;spec.securityContext.fsGroup&#39; to integer greater than 0 </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/appshield/ksv029">https://avd.aquasec.com/appshield/ksv029</a><br></details>  |


| No Misconfigurations found         |
|:---------------------------------|




| Type         |    Misconfiguration ID   |   Check  |  Severity |                   Explaination                   | Links  |
|:----------------|:------------------:|:-----------:|:------------------:|-----------------------------------------|-----------------------------------------|
| Kubernetes Security Check         |    KSV009   |   Access to host network  |  HIGH | <details><summary>Expand...</summary> Sharing the host’s network namespace permits processes in the pod to communicate with processes bound to the host’s loopback adapter. <br> <hr> <br> DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should not set &#39;spec.template.spec.hostNetwork&#39; to true </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline">https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline</a><br><a href="https://avd.aquasec.com/appshield/ksv009">https://avd.aquasec.com/appshield/ksv009</a><br></details>  |
| Kubernetes Security Check         |    KSV011   |   CPU not limited  |  LOW | <details><summary>Expand...</summary> Enforcing CPU limits prevents DoS via resource exhaustion. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;resources.limits.cpu&#39; </details>| <details><summary>Expand...</summary><a href="https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits">https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits</a><br><a href="https://avd.aquasec.com/appshield/ksv011">https://avd.aquasec.com/appshield/ksv011</a><br></details>  |
| Kubernetes Security Check         |    KSV012   |   Runs as root user  |  MEDIUM | <details><summary>Expand...</summary> &#39;runAsNonRoot&#39; forces the running image to run as a non-root user to ensure least privileges. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;securityContext.runAsNonRoot&#39; to true </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted">https://kubernetes.io/docs/concepts/security/pod-security-standards/#restricted</a><br><a href="https://avd.aquasec.com/appshield/ksv012">https://avd.aquasec.com/appshield/ksv012</a><br></details>  |
| Kubernetes Security Check         |    KSV015   |   CPU requests not specified  |  LOW | <details><summary>Expand...</summary> When containers have resource requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;resources.requests.cpu&#39; </details>| <details><summary>Expand...</summary><a href="https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits">https://cloud.google.com/blog/products/containers-kubernetes/kubernetes-best-practices-resource-requests-and-limits</a><br><a href="https://avd.aquasec.com/appshield/ksv015">https://avd.aquasec.com/appshield/ksv015</a><br></details>  |
| Kubernetes Security Check         |    KSV016   |   Memory requests not specified  |  LOW | <details><summary>Expand...</summary> When containers have memory requests specified, the scheduler can make better decisions about which nodes to place pods on, and how to deal with resource contention. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;resources.requests.memory&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-resources-limits-memory/">https://kubesec.io/basics/containers-resources-limits-memory/</a><br><a href="https://avd.aquasec.com/appshield/ksv016">https://avd.aquasec.com/appshield/ksv016</a><br></details>  |
| Kubernetes Security Check         |    KSV018   |   Memory not limited  |  LOW | <details><summary>Expand...</summary> Enforcing memory limits prevents DoS via resource exhaustion. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;resources.limits.memory&#39; </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-resources-limits-memory/">https://kubesec.io/basics/containers-resources-limits-memory/</a><br><a href="https://avd.aquasec.com/appshield/ksv018">https://avd.aquasec.com/appshield/ksv018</a><br></details>  |
| Kubernetes Security Check         |    KSV020   |   Runs with low user ID  |  MEDIUM | <details><summary>Expand...</summary> Force the container to run with user ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;securityContext.runAsUser&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/appshield/ksv020">https://avd.aquasec.com/appshield/ksv020</a><br></details>  |
| Kubernetes Security Check         |    KSV021   |   Runs with low group ID  |  MEDIUM | <details><summary>Expand...</summary> Force the container to run with group ID &gt; 10000 to avoid conflicts with the host’s user table. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should set &#39;securityContext.runAsGroup&#39; &gt; 10000 </details>| <details><summary>Expand...</summary><a href="https://kubesec.io/basics/containers-securitycontext-runasuser/">https://kubesec.io/basics/containers-securitycontext-runasuser/</a><br><a href="https://avd.aquasec.com/appshield/ksv021">https://avd.aquasec.com/appshield/ksv021</a><br></details>  |
| Kubernetes Security Check         |    KSV022   |   Non-default capabilities added  |  MEDIUM | <details><summary>Expand...</summary> Adding NET_RAW or capabilities beyond the default set must be disallowed. <br> <hr> <br> Container &#39;speaker&#39; of DaemonSet &#39;RELEASE-NAME-metallb-speaker&#39; should not set &#39;securityContext.capabilities.add&#39; </details>| <details><summary>Expand...</summary><a href="https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline">https://kubernetes.io/docs/concepts/security/pod-security-standards/#baseline</a><br><a href="https://avd.aquasec.com/appshield/ksv022">https://avd.aquasec.com/appshield/ksv022</a><br></details>  |

## Containers

##### Detected Containers

        quay.io/metallb/controller:v0.12.1
        quay.io/metallb/speaker:v0.12.1

##### Scan Results


#### Container: quay.io/metallb/controller:v0.12.1 (alpine 3.15.0)


**alpine**


| No Vulnerabilities found         |
|:---------------------------------|



**gobinary**


| Package         |    Vulnerability   |   Severity  |  Installed Version | Fixed Version |                   Links                   |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|
| golang.org/x/text         |    CVE-2021-38561   |   UNKNOWN  |  v0.3.6 | 0.3.7 | <details><summary>Expand...</summary></details>  |


#### Container: quay.io/metallb/speaker:v0.12.1 (alpine 3.15.0)


**alpine**


| No Vulnerabilities found         |
|:---------------------------------|



**gobinary**


| Package         |    Vulnerability   |   Severity  |  Installed Version | Fixed Version |                   Links                   |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|
| golang.org/x/text         |    CVE-2021-38561   |   UNKNOWN  |  v0.3.6 | 0.3.7 | <details><summary>Expand...</summary></details>  |

**gobinary**


| Package         |    Vulnerability   |   Severity  |  Installed Version | Fixed Version |                   Links                   |
|:----------------|:------------------:|:-----------:|:------------------:|:-------------:|-----------------------------------------|
| golang.org/x/text         |    CVE-2021-38561   |   UNKNOWN  |  v0.3.6 | 0.3.7 | <details><summary>Expand...</summary></details>  |
