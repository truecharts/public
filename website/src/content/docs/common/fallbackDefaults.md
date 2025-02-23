---
title: Fallback Defaults
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/fallbackdefaults#full-examples) section for complete examples.

:::

## Appears in

- `.Values.fallbackDefaults`

---

## Defaults

```yaml
fallbackDefaults:
  probeType: http
  serviceProtocol: tcp
  serviceType: ClusterIP
  storageClass:
  persistenceType: emptyDir
  pvcRetain: true
  pvcSize: 100Gi
  vctSize: 100Gi
  accessModes:
    - ReadWriteOnce
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
  topologyKey: kubernetes.io/hostname
```

## `probeType`

Define default probe type when not defined in the container level

|            |                              |
| ---------- | ---------------------------- |
| Key        | `fallbackDefaults.probeType` |
| Type       | `string`                     |
| Required   | ✅                           |
| Helm `tpl` | ❌                           |
| Default    | `http`                       |

Valid Values:

- See [Probe Types](/common/container/probes#probesprobetype)

Example

```yaml
fallbackDefaults:
  probeType: http
```

---

## `serviceProtocol`

Define default service protocol when not defined in the service

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `fallbackDefaults.serviceProtocol` |
| Type       | `string`                           |
| Required   | ✅                                 |
| Helm `tpl` | ❌                                 |
| Default    | `tcp`                              |

Valid Values:

- See [Service Protocols](/common/service/ports#protocol)

Example

```yaml
fallbackDefaults:
  serviceProtocol: tcp
```

---

## `serviceType`

Define default service type when not defined in the service

|            |                                |
| ---------- | ------------------------------ |
| Key        | `fallbackDefaults.serviceType` |
| Type       | `string`                       |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | `ClusterIP`                    |

Valid Values:

- See [Service Types](/common/service#type)

Example

```yaml
fallbackDefaults:
  serviceType: ClusterIP
```

---

## `storageClass`

Define default storage class when not defined in the persistence

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `fallbackDefaults.storageClass` |
| Type       | `string`                        |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | unset                           |

Example

```yaml
fallbackDefaults:
  storageClass: some-storage-class
```

---

## `persistenceType`

Define default persistence type when not defined in the persistence

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `fallbackDefaults.persistenceType` |
| Type       | `string`                           |
| Required   | ✅                                 |
| Helm `tpl` | ❌                                 |
| Default    | `emptyDir`                         |

Valid Values:

- See [Persistence Types](/common/persistence#type)

Example

```yaml
fallbackDefaults:
  persistenceType: pvc
```

---

## `pvcRetain`

Define default pvc retain when not defined in the persistence

|            |                              |
| ---------- | ---------------------------- |
| Key        | `fallbackDefaults.pvcRetain` |
| Type       | `bool`                       |
| Required   | ✅                           |
| Helm `tpl` | ❌                           |
| Default    | `true`                       |

Example

```yaml
fallbackDefaults:
  pvcRetain: true
```

---

## `pvcSize`

Define default pvc size when not defined in the persistence

|            |                            |
| ---------- | -------------------------- |
| Key        | `fallbackDefaults.pvcSize` |
| Type       | `string`                   |
| Required   | ✅                         |
| Helm `tpl` | ❌                         |
| Default    | `100Gi`                    |

Example

```yaml
fallbackDefaults:
  pvcSize: 100Gi
```

---

## `vctSize`

Define default vct size when not defined in the persistence

|            |                            |
| ---------- | -------------------------- |
| Key        | `fallbackDefaults.vctSize` |
| Type       | `string`                   |
| Required   | ✅                         |
| Helm `tpl` | ❌                         |
| Default    | `100Gi`                    |

Example

```yaml
fallbackDefaults:
  vctSize: 100Gi
```

---

## `accessModes`

Define default access modes when not defined in the persistence

|            |                                |
| ---------- | ------------------------------ |
| Key        | `fallbackDefaults.accessModes` |
| Type       | `list` of `string`             |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | `ReadWriteOnce`                |

Example

```yaml
fallbackDefaults:
  accessModes:
    - ReadWriteOnce
```

---

## `probeTimeouts`

Define default probe timeouts if not defined in the container

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts` |
| Type       | `map`                            |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |

Default

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
```

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
```

---

### `probeTimeouts.liveness`

Define default liveness probe timeouts if not defined in the container

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness` |
| Type       | `map`                                     |
| Required   | ✅                                        |
| Helm `tpl` | ❌                                        |

Default

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
```

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
```

---

#### `probeTimeouts.liveness.initialDelaySeconds`

Define default liveness probe initialDelaySeconds if not defined in the container

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness.initialDelaySeconds` |
| Type       | `int`                                                         |
| Required   | ✅                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | `10`                                                          |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
```

---

#### `probeTimeouts.liveness.periodSeconds`

Define default liveness probe periodSeconds if not defined in the container

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness.periodSeconds` |
| Type       | `int`                                                   |
| Required   | ✅                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | `10`                                                    |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      periodSeconds: 10
```

---

#### `probeTimeouts.liveness.timeoutSeconds`

Define default liveness probe timeoutSeconds if not defined in the container

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness.timeoutSeconds` |
| Type       | `int`                                                    |
| Required   | ✅                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `5`                                                      |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      timeoutSeconds: 5
```

---

#### `probeTimeouts.liveness.failureThreshold`

Define default liveness probe failureThreshold if not defined in the container

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness.failureThreshold` |
| Type       | `int`                                                      |
| Required   | ✅                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | `5`                                                        |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      failureThreshold: 5
```

---

#### `probeTimeouts.liveness.successThreshold`

Define default liveness probe successThreshold if not defined in the container

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.liveness.successThreshold` |
| Type       | `int`                                                      |
| Required   | ✅                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | `1`                                                        |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    liveness:
      successThreshold: 1
```

---

### `probeTimeouts.readiness`

Define default readiness probe timeouts if not defined in the container

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `fallbackDefaults.probeTimeouts.readiness` |
| Type       | `map`                                      |
| Required   | ✅                                         |
| Helm `tpl` | ❌                                         |

Default

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
```

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
```

---

#### `probeTimeouts.readiness.initialDelaySeconds`

Define default readiness probe initialDelaySeconds if not defined in the container

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.readiness.initialDelaySeconds` |
| Type       | `int`                                                          |
| Required   | ✅                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | `10`                                                           |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      initialDelaySeconds: 10
```

---

#### `probeTimeouts.readiness.periodSeconds`

Define default readiness probe periodSeconds if not defined in the container

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.readiness.periodSeconds` |
| Type       | `int`                                                    |
| Required   | ✅                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `10`                                                     |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      periodSeconds: 10
```

---

#### `probeTimeouts.readiness.timeoutSeconds`

Define default readiness probe timeoutSeconds if not defined in the container

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.readiness.timeoutSeconds` |
| Type       | `int`                                                     |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | `5`                                                       |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      timeoutSeconds: 5
```

---

#### `probeTimeouts.readiness.failureThreshold`

Define default readiness probe failureThreshold if not defined in the container

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.readiness.failureThreshold` |
| Type       | `int`                                                       |
| Required   | ✅                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `5`                                                         |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      failureThreshold: 5
```

---

#### `probeTimeouts.readiness.successThreshold`

Define default readiness probe successThreshold if not defined in the container

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.readiness.successThreshold` |
| Type       | `int`                                                       |
| Required   | ✅                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `2`                                                         |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    readiness:
      successThreshold: 2
```

---

### `probeTimeouts.startup`

Define default startup probe timeouts if not defined in the container

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.startup` |
| Type       | `map`                                    |
| Required   | ✅                                       |
| Helm `tpl` | ❌                                       |

Default

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
```

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
```

---

#### `probeTimeouts.startup.initialDelaySeconds`

Define default startup probe initialDelaySeconds if not defined in the container

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `fallbackDefaults.probeTimeouts.startup.initialDelaySeconds` |
| Type       | `int`                                                        |
| Required   | ✅                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | `10`                                                         |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      initialDelaySeconds: 10
```

---

#### `probeTimeouts.startup.periodSeconds`

Define default startup probe periodSeconds if not defined in the container

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `fallbackDefaults.probeTimeouts.startup.periodSeconds` |
| Type       | `int`                                                  |
| Required   | ✅                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | `5`                                                    |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      periodSeconds: 5
```

---

#### `probeTimeouts.startup.timeoutSeconds`

Define default startup probe timeoutSeconds if not defined in the container

|            |                                                         |
| ---------- | ------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.startup.timeoutSeconds` |
| Type       | `int`                                                   |
| Required   | ✅                                                      |
| Helm `tpl` | ❌                                                      |
| Default    | `2`                                                     |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      timeoutSeconds: 2
```

---

#### `probeTimeouts.startup.failureThreshold`

Define default startup probe failureThreshold if not defined in the container

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.startup.failureThreshold` |
| Type       | `int`                                                     |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | `60`                                                      |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      failureThreshold: 60
```

---

#### `probeTimeouts.startup.successThreshold`

Define default startup probe successThreshold if not defined in the container

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `fallbackDefaults.probeTimeouts.startup.successThreshold` |
| Type       | `int`                                                     |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | `1`                                                       |

Example

```yaml
fallbackDefaults:
  probeTimeouts:
    startup:
      successThreshold: 1
```

---

## `topologyKey`

Define default topologyKey for topologySpreadConstraints in podOptions


|            |                                |
| ---------- | ------------------------------ |
| Key        | `fallbackDefaults.topologyKey` |
| Type       | `string`                          |
| Required   | ❌                             |
| Helm `tpl` | ❌                             |
| Default    | `kubernetes.io/hostname`                            |


---

## Full Examples

```yaml
fallbackDefaults:
  probeType: http
  serviceProtocol: tcp
  serviceType: ClusterIP
  persistenceType: pvc
  probeTimeouts:
    liveness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 1
    readiness:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
      successThreshold: 2
    startup:
      initialDelaySeconds: 10
      periodSeconds: 5
      timeoutSeconds: 2
      failureThreshold: 60
      successThreshold: 1
  topologyKey: truecharts.org/example
```
