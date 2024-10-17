---
title: NodePort
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/nodeport#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name`

:::tip

- See available service keys [here](/common/service).
- This options apply only when `type: NodePort`.

:::

---

## `ports.$port-name.nodePort`

Define the node port that will be exposed on the node

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `service.$name.ports.$port-name.nodePort` |
| Type       | `int`                                     |
| Required   | ✅                                        |
| Helm `tpl` | ✅                                        |
| Default    | unset                                     |

Example

```yaml
service:
  some-service:
    nodePort: 30080
```

---

## Full Examples

```yaml
service:
  service-nodeport:
    enabled: true
    primary: true
    type: NodePort
    clusterIP: 172.16.20.233
    publishNotReadyAddresses: true
    externalIPs:
      - 10.200.230.34
    sessionAffinity: ClientIP
    sessionAffinityConfig:
      clientIP:
        timeoutSeconds: 86400
    externalTrafficPolicy: Cluster
    targetSelector: pod-name
    ports:
      port-name:
        enabled: true
        primary: true
        targetSelector: container-name
        port: 80
        protocol: http
        targetPort: 8080
        nodePort: 30080
```
