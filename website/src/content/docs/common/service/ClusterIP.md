---
title: ClusterIP
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/clusterip#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name`

:::tip

- See available service keys [here](/common/service).
- This options apply only when `type: ClusterIP`.

:::

---

## Full Examples

```yaml
service:
  service-clusterip:
    enabled: true
    primary: true
    publishNotReadyAddresses: true
    clusterIP: 172.16.20.233
    publishNotReadyAddresses: true
    ipFamilyPolicy: SingleStack
    ipFamilies:
      - IPv4
    externalIPs:
      - 10.200.230.34
    sessionAffinity: ClientIP
    sessionAffinityConfig:
      clientIP:
        timeoutSeconds: 86400
    targetSelector: pod-name
    ports:
      port-name:
        enabled: true
        primary: true
        targetSelector: container-name
        port: 80
        protocol: http
        targetPort: 8080
```
