---
title: ExternalName
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/externalname#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name`

:::tip

- See available service keys [here](/common/service).
- This options apply only when `type: ExternalName`.

:::

---

## `externalName`

Configure ExternalName type

|            |                              |
| ---------- | ---------------------------- |
| Key        | `service.$name.externalName` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `""`                         |

Example

```yaml
service:
  some-service:
    externalName: external-name
```

---

## Full Examples

```yaml
service:
  # Special type
  service-external-name:
    enabled: true
    primary: true
    type: ExternalName
    externalName: external-name
    clusterIP: 172.16.20.233
    publishNotReadyAddresses: true
    externalIPs:
      - 10.200.230.34
    sessionAffinity: ClientIP
    sessionAffinityConfig:
      clientIP:
        timeoutSeconds: 86400
    externalTrafficPolicy: Cluster
    ports:
      port-name:
        enabled: true
        primary: true
        targetSelector: container-name
        port: 80
        protocol: HTTP
```
