---
title: Service
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service#full-examples) section for complete examples.

:::

## Appears in

- `.Values.service`

## Naming scheme

- Primary: `$FullName` (release-name-chart-name)
- Non-Primary: `$FullName-$ServiceName` (release-name-chart-name-ServiceName)

:::tip

Replace references to `$name` and `$port-name` with the actual name you want to use.

:::

---

## Target Selector

- `targetSelector` (string): Define the pod to link the service
- `targetSelector` (empty): Assign the service to the primary pod

---

## `service`

Define service objects

|            |           |
| ---------- | --------- |
| Key        | `service` |
| Type       | `map`     |
| Required   | ❌        |
| Helm `tpl` | ❌        |
| Default    | `{}`      |

Example

```yaml
service: {}
```

---

### `$name`

Define service

|            |                 |
| ---------- | --------------- |
| Key        | `service.$name` |
| Type       | `map`           |
| Required   | ✅              |
| Helm `tpl` | ❌              |
| Default    | `{}`            |

Example

```yaml
service:
  service-name: {}
```

---

#### `enabled`

Enables or Disables the service

|            |                         |
| ---------- | ----------------------- |
| Key        | `service.$name.enabled` |
| Type       | `bool`                  |
| Required   | ✅                      |
| Helm `tpl` | ✅                      |
| Default    | `false`                 |

Example

```yaml
service:
  service-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                           |
| ---------- | ------------------------- |
| Key        | `service.$name.namespace` |
| Type       | `string`                  |
| Required   | ❌                        |
| Helm `tpl` | ✅ (On value only)`       |
| Default    | `""`                      |

Example

```yaml
service:
  service-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for service

|            |                        |
| ---------- | ---------------------- |
| Key        | `service.$name.labels` |
| Type       | `map`                  |
| Required   | ❌                     |
| Helm `tpl` | ✅ (On value only)`    |
| Default    | `{}`                   |

Example

```yaml
service:
  service-name:
    labels:
      some-label: some-value
```

---

#### `annotations`

Additional annotations for service

|            |                             |
| ---------- | --------------------------- |
| Key        | `service.$name.annotations` |
| Type       | `map`                       |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On value only)`         |
| Default    | `{}`                        |

Example

```yaml
service:
  service-name:
    annotations:
      some-annotation: some-value
```

---

#### `type`

Define the service type

|            |                                                                  |
| ---------- | ---------------------------------------------------------------- |
| Key        | `service.$name.type`                                             |
| Type       | `string`                                                         |
| Required   | ❌                                                               |
| Helm `tpl` | ✅                                                               |
| Default    | See default [here](/common/fallbackdefaults#servicetype) |

Valid Values:

- [`ClusterIP`](/common/service/clusterip)
- [`LoadBalancer`](/common/service/loadbalancer)
- [`NodePort`](/common/service/nodeport)
- [`ExternalName`](/common/service/externalname)
- [`ExternalIP`](/common/service/externalip)

Example

```yaml
service:
  service-name:
    type: ClusterIP
```

---

#### `expandObjectName`

Whether to expand the object name (based on the [naming scheme](/common/service#naming-scheme)) or not

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `service.$name.expandObjectName` |
| Type       | `bool`                           |
| Required   | ❌                               |
| Helm `tpl` | ✅                               |
| Default    | `true`                           |

Example

```yaml
service:
  service-name:
    expandObjectName: false
```

---

#### `clusterIP`

Configure Cluster IP type

|            |                           |
| ---------- | ------------------------- |
| Key        | `service.$name.clusterIP` |
| Type       | `string`                  |
| Required   | ❌                        |
| Helm `tpl` | ✅                        |
| Default    | `""`                      |

Example

```yaml
service:
  some-service:
    clusterIP: 172.16.0.123
```

---

#### `ipFamilyPolicy`

Define the ipFamilyPolicy

:::warning

Does **not** apply to `type` of `ExternalName` or `ExternalIP`

:::

|            |                                |
| ---------- | ------------------------------ |
| Key        | `service.$name.ipFamilyPolicy` |
| Type       | `string`                       |
| Required   | ❌                             |
| Helm `tpl` | ✅                             |
| Default    | `""`                           |

Valid Values:

- `SingleStack`
- `PreferDualStack`
- `RequireDualStack`

Example

```yaml
service:
  some-service:
    ipFamilyPolicy: SingleStack
```

---

#### `ipFamilies`

Define the ipFamilies

:::warning

Does **not** apply to `type` of `ExternalName` or `ExternalIP`

:::

|            |                            |
| ---------- | -------------------------- |
| Key        | `service.$name.ipFamilies` |
| Type       | `list` of `string`         |
| Required   | ❌                         |
| Helm `tpl` | ✅ (On entries only)       |
| Default    | `[]`                       |

Example

```yaml
service:
  some-service:
    ipFamilies:
      - IPv4
```

---

#### `sessionAffinity`

Define the session affinity (ClientIP, None)

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `service.$name.sessionAffinity` |
| Type       | `string`                        |
| Required   | ❌                              |
| Helm `tpl` | ✅                              |
| Default    | `""`                            |

Valid Values:

- `ClientIP`
- `None`

Example

```yaml
service:
  some-service:
    sessionAffinity: ClientIP
```

---

#### `sessionAffinityConfig.clientIP.timeoutSeconds`

Define the timeout for ClientIP session affinity (0-86400)

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `service.$name.sessionAffinityConfig.clientIP.timeoutSeconds` |
| Type       | `int`                                                         |
| Required   | ❌                                                            |
| Helm `tpl` | ✅                                                            |
| Default    | `""`                                                          |

Valid Values:

- `0` - `86400`

Example

```yaml
service:
  some-service:
    sessionAffinityConfig:
      clientIP:
        timeoutSeconds: 86400
```

---

#### `externalIPs`

Define externalIPs

|            |                             |
| ---------- | --------------------------- |
| Key        | `service.$name.externalIPs` |
| Type       | `list` of `string`          |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On entries only)        |
| Default    | `[]`                        |

Example

```yaml
service:
  some-service:
    externalIPs:
      - 1.2.3.4
      - 5.6.7.8
```

---

#### `externalTrafficPolicy`

Define the external traffic policy (Cluster, Local)

:::warning

Does **not** apply to `type` of `ClusterIP`

:::

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `service.$name.externalTrafficPolicy` |
| Type       | `string`                              |
| Required   | ❌                                    |
| Helm `tpl` | ✅                                    |
| Default    | `""`                                  |

Valid Values:

- `Cluster`
- `Local`

Example

```yaml
service:
  some-service:
    externalTrafficPolicy: Cluster
```

---

#### `publishNotReadyAddresses`

Define whether to publishNotReadyAddresses or not

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `service.$name.publishNotReadyAddresses` |
| Type       | `bool`                                   |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | `false`                                  |

Example

```yaml
service:
  service-name:
    publishNotReadyAddresses: true
```

---

#### `targetSelector`

Define the pod to link the service, by default will use the primary pod

|            |                                |
| ---------- | ------------------------------ |
| Key        | `service.$name.targetSelector` |
| Type       | `string`                       |
| Required   | ❌                             |
| Helm `tpl` | ❌                             |
| Default    | `""`                           |

Example

```yaml
service:
  service-name:
    targetSelector: some-pod
```

---

#### `ports`

Define the ports of the service

See [Ports](/common/service/ports)

|            |                       |
| ---------- | --------------------- |
| Key        | `service.$name.ports` |
| Type       | `map`                 |
| Required   | ✅                    |
| Helm `tpl` | ❌                    |
| Default    | `{}`                  |

Example

```yaml
service:
  service-name:
    ports: {}
```

---

## Full Examples

Full examples can be found under each service type

- [ClusterIP](/common/service/clusterip)
- [LoadBalancer](/common/service/loadbalancer)
- [NodePort](/common/service/nodeport)
- [ExternalName](/common/service/externalname)
- [ExternalIP](/common/service/externalip)
