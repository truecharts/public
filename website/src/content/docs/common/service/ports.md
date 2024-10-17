---
title: Ports
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/service/ports#full-examples) section for complete examples.
- See the [Service](/common/service) documentation for more information

:::

## Appears in

- `.Values.service.$name.ports`

---

## Target Selector

- `targetSelector` (string): Define the container to link the port
- `targetSelector` (empty): Assign the service to the primary container

---

## `$port-name`

Define the port dict

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `service.$name.ports.$port-name` |
| Type       | `map`                            |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | `{}`                             |

Example

```yaml
service:
  service-name:
    ports:
      port-name: {}
```

---

### `port`

Define the port that will be exposed by the service

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `service.$name.ports.$port-name.port` |
| Type       | `int`                                 |
| Required   | ✅                                    |
| Helm `tpl` | ✅                                    |
| Default    | unset                                 |

Example

```yaml
service:
  service-name:
    ports:
      port-name:
        port: 80
```

---

### `targetPort`

Define the target port (No named ports)

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `service.$name.ports.$port-name.targetPort` |
| Type       | `int`                                       |
| Required   | ❌                                          |
| Helm `tpl` | ✅                                          |
| Default    | (Defaults to `port` if not set)             |

Example

```yaml
service:
  service-name:
    ports:
      port-name:
        targetPort: 80
```

---

### `protocol`

Define the port protocol Used by the container ports and probes, http and https are converted to tcp where needed

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `service.$name.ports.$port-name.protocol`                            |
| Type       | `string`                                                             |
| Required   | ❌                                                                   |
| Helm `tpl` | ✅                                                                   |
| Default    | See default [here](/common/fallbackdefaults#serviceprotocol) |

Valid Values:

- `tcp`
- `udp`
- `http`
- `https`

Example

```yaml
service:
  service-name:
    ports:
      port-name:
        protocol: tcp
```

---

### `hostPort`

Define the hostPort, should be **avoided**, unless **ABSOLUTELY** necessary

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `service.$name.ports.$port-name.hostPort` |
| Type       | `int`                                     |
| Required   | ❌                                        |
| Helm `tpl` | ✅                                        |
| Default    | unset                                     |

Example

```yaml
service:
  service-name:
    ports:
      port-name:
        hostPort: 30000
```

---

### `targetSelector`

Define the container to link this port (Must be on under the pod linked above)

|            |                                                 |
| ---------- | ----------------------------------------------- |
| Key        | `service.$name.ports.$port-name.targetSelector` |
| Type       | `string`                                        |
| Required   | ❌                                              |
| Helm `tpl` | ✅                                              |
| Default    | unset                                           |

Example

```yaml
service:
  service-name:
    ports:
      port-name:
        targetSelector: some-container
```

## Full Examples

Full examples can be found under each service type

- [ClusterIP](/common/service/clusterip)
- [LoadBalancer](/common/service/loadbalancer)
- [NodePort](/common/service/nodeport)
- [ExternalName](/common/service/externalname)
- [ExternalIP](/common/service/externalip)
