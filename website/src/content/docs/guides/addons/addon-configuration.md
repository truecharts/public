---
title: Advanced Addon Configuration
---

Common offers an addon system to easily integrate some predefined addons into your charts without the need to configure additional workloads etc.
While it usually isnt needed people have similar options to the main workload sections of our charts.
Therefore you can configure the workload of each addon with the following section: (for the example codesever is used)

```yaml

addons:
  codeserver:
    enabled: true
    container:
      enabled: true
      probes:
        liveness:
          enabled: true
          port: 12321
          path: "/"
        readiness:
          enabled: true
          port: 12321
          path: "/"
        startup:
          enabled: true
          port: 12321
          path: "/"
      imageSelector: "codeserverImage"
      resources:
        excludeExtra: true
      securityContext:
        runAsUser: 0
        runAsGroup: 0
        runAsNonRoot: false
        readOnlyRootFilesystem: false
      args:
        - "--port"
        - "12321"
        - "/"
        - --auth
        - none

```

As you can see most options of the workload can be edited (even the image beeing used). Feel free to change certain settings if needed.
