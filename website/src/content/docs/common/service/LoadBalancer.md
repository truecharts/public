---
title: LoadBalancer
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/loadbalancer#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name`

:::tip

- See available service keys [here](/common/service).
- This options apply only when `type: LoadBalancer`.

:::

---

## `sharedKey`

Sets the shared key in `metallb.io/allow-shared-ip` **MetalLB** Annotation

|            |                           |
| ---------- | ------------------------- |
| Key        | `service.$name.sharedKey` |
| Type       | `string`                  |
| Required   | ❌                        |
| Helm `tpl` | ✅                        |
| Default    | `$FullName`               |

Example

```yaml
service:
  some-service:
    sharedKey: custom-shared-key
```

## `loadBalancerIP`

Define the load balancer IP, sets the `metallb.io/loadBalancerIPs` **MetalLB** annotation. Mutually exclusive with `loadBalancerIPs`

|            |                                |
| ---------- | ------------------------------ |
| Key        | `service.$name.loadBalancerIP` |
| Type       | `string`                       |
| Required   | ❌                             |
| Helm `tpl` | ✅                             |
| Default    | `""`                           |

Example

```yaml
service:
  some-service:
    loadBalancerIP: 1.2.3.4
```

## `loadBalancerIPs`

Define the load balancer IPs, sets the `metallb.io/loadBalancerIPs` **MetalLB** annotation. Mutually exclusive with `loadBalancerIP`

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `service.$name.loadBalancerIPs` |
| Type       | `list` of `string`              |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On entries only)            |
| Default    | `[]`                            |

Example

```yaml
service:
  some-service:
    loadBalancerIPs:
      - 1.2.3.4
      - 5.6.7.8
```

---

## `loadBalancerSourceRanges`

Define the load balancer source ranges

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `service.$name.loadBalancerSourceRanges` |
| Type       | `list` of `string`                       |
| Required   | ❌                                       |
| Helm `tpl` | ✅ (On entries only)                     |
| Default    | `[]`                                     |

Example

```yaml
service:
  some-service:
    loadBalancerSourceRanges:
      - 10.100.100.0/24
      - 10.100.200.0/24
```

---

## Full Examples

```yaml
service:
  service-lb:
    enabled: true
    primary: true
    type: LoadBalancer
    loadBalancerIP: 10.100.100.2
    loadBalancerSourceRanges:
      - 10.100.100.0/24
    clusterIP: 172.16.20.233
    sharedKey: custom-shared-key
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
    externalTrafficPolicy: Cluster
    targetSelector: pod-name
    ports:
      port-name:
        enabled: true
        primary: true
        targetSelector: container-name
        port: 80
        protocol: HTTP
        targetPort: 8080
```
