---
title: Installation Notes
---

To use this to protect multiple apps setup the traefik middleware "modsecurity" in the Traefik Chart `.Values`.

```yaml
middlewares:
  modsecurity:
    - name: modsecurity
      modSecurityUrl: http://modsecurity-crs-modsecurity-crs.svc.cluster.local:8081
      timeoutMillis: 1000
      maxBodySize: 1024
```

If you do not plan to use traefik or only want to protect a single app, just add a variable "BACKEND" in the Environment Variables.
The value can be `<http://ip:port>` or `<http://modsecurity-crs-modsecurity-crs.svc.cluster.local:8081>`.

```yaml
workload:
  main:
    podSpec:
      containers:
        main:
          env:
            BACKEND: "http://ip:port"
```
