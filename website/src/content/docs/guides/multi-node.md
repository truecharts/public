---
title: Fix pods stuck terminating after node failure
---


Node failures can lead to pods beeing stuck in terminating and not beeing evicted.
This requires either node removal (with the API) or force-removing pods.
Descheduler can solve this issue.

Example Descheduler configuration values:

```yaml

replicas: 2
kind: Deployment
deschedulerPolicyAPIVersion: descheduler/v1alpha2
deschedulerPolicy:
  profiles:
    - name: Default
      pluginConfig:
        - name: DefaultEvictor
          args:
            evictFailedBarePods: true
            evictLocalStoragePods: true
            evictSystemCriticalPods: true
        - name: RemoveFailedPods
          args:
            reasons:
              - ContainerStatusUnknown
              - NodeAffinity
              - NodeShutdown
              - Terminated
              - UnexpectedAdmissionError
            includingInitContainers: true
            excludeOwnerKinds:
              - Job
            minPodLifetimeSeconds: 1800
        - name: RemovePodsViolatingInterPodAntiAffinity
        - name: RemovePodsViolatingNodeAffinity
          args:
            nodeAffinityType:
              - requiredDuringSchedulingIgnoredDuringExecution
        - name: RemovePodsViolatingNodeTaints
        - name: RemovePodsViolatingTopologySpreadConstraint
      plugins:
        balance:
          enabled:
            - RemovePodsViolatingTopologySpreadConstraint
        deschedule:
          enabled:
            - RemoveFailedPods
            - RemovePodsViolatingInterPodAntiAffinity
            - RemovePodsViolatingNodeAffinity
            - RemovePodsViolatingNodeTaints
service:
  enabled: true
serviceMonitor:
  enabled: true
leaderElection:
  enabled: true

```
