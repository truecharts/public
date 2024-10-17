---
title: Persistence
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence`

## Naming scheme

- `$FullName-$PersistenceName` (release-name-chart-name-PersistenceName)

:::tip

- Replace references to `$name`, `$podName`, `$containerName` with the actual name you want to use.

:::

---

## Target Selector

- `targetSelectAll` (bool): Whether to define the volume to all pods and mount it on all containers. `targetSelector` is ignored in this case. Useful for shared volumes.
- `targetSelector` (map): Define the pod(s) and container(s) to define the volume and mount it.
- `targetSelector` (empty): Define the volume to the primary pod and mount it on the primary container

## `persistence`

Define persistence objects

|            |               |
| ---------- | ------------- |
| Key        | `persistence` |
| Type       | `map`         |
| Required   | ❌            |
| Helm `tpl` | ❌            |
| Default    | `{}`          |

Example

```yaml
persistence: {}
```

---

### `$name`

Define persistence

|            |                     |
| ---------- | ------------------- |
| Key        | `persistence.$name` |
| Type       | `map`               |
| Required   | ✅                  |
| Helm `tpl` | ❌                  |
| Default    | `{}`                |

Example

```yaml
persistence:
  some-vol: {}
```

---

#### `enabled`

Enables or Disables the persistence

|            |                             |
| ---------- | --------------------------- |
| Key        | `persistence.$name.enabled` |
| Type       | `bool`                      |
| Required   | ✅                          |
| Helm `tpl` | ✅                          |
| Default    | `false`                     |

Example

```yaml
persistence:
  some-vol:
    enabled: true
```

---

#### `type`

Define the persistence type

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `persistence.$name.type`                                             |
| Type       | `string`                                                             |
| Required   | ❌                                                                   |
| Helm `tpl` | ❌                                                                   |
| Default    | See default [here](/common/fallbackdefaults#persistencetype) |

Valid Values:

- [`hostPath`](/common/persistence/hostpath)
- [`configmap`](/common/configmap)
- [`secret`](/common/secret)
- [`device`](/common/persistence/device)
- [`pvc`](/common/persistence/pvc-vct)
- [`vct`](/common/persistence/pvc-vct)
- [`nfs`](/common/persistence/nfs)
- [`emptyDir`](/common/persistence/emptydir)
- [`iscsi`](/common/persistence/iscsi)

Example

```yaml
persistence:
  some-vol:
    type: pvc
```

---

#### `mountPath`

Define the mountPath for the persistence, applies to all containers that are selected

|            |                               |
| ---------- | ----------------------------- |
| Key        | `persistence.$name.mountPath` |
| Type       | `string`                      |
| Required   | ✅                            |
| Helm `tpl` | ✅                            |
| Default    | `""`                          |

Example

```yaml
persistence:
  some-vol:
    mountPath: /path
```

---

#### `mountPropagation`

Define the mountPropagation for the persistence, applies to all containers that are selected

|            |                                      |
| ---------- | ------------------------------------ |
| Key        | `persistence.$name.mountPropagation` |
| Type       | `string`                             |
| Required   | ❌                                   |
| Helm `tpl` | ✅                                   |
| Default    | `""`                                 |

Valid Values:

- `None`
- `HostToContainer`
- `Bidirectional`

Example

```yaml
persistence:
  some-vol:
    mountPropagation: HostToContainer
```

---

#### `subPath`

Define the subPath for the persistence, applies to all containers that are selected

|            |                             |
| ---------- | --------------------------- |
| Key        | `persistence.$name.subPath` |
| Type       | `string`                    |
| Required   | ❌                          |
| Helm `tpl` | ✅                          |
| Default    | `""`                        |

Example

```yaml
persistence:
  some-vol:
    subPath: some-path
```

---

#### `readOnly`

Define the readOnly for the persistence, applies to all containers that are selected

|            |                              |
| ---------- | ---------------------------- |
| Key        | `persistence.$name.readOnly` |
| Type       | `bool`                       |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | `false`                      |

Example

```yaml
persistence:
  some-vol:
    readOnly: true
```

---

#### `targetSelectAll`

Define wether to define this volume to all workloads and mount it on all containers

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `persistence.$name.targetSelectAll` |
| Type       | `bool`                              |
| Required   | ❌                                  |
| Helm `tpl` | ❌                                  |
| Default    | `false`                             |

Example

```yaml
persistence:
  some-vol:
    targetSelectAll: true
```

---

#### `targetSelector`

Define a map with pod and containers to mount

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `persistence.$name.targetSelector` |
| Type       | `map`                              |
| Required   | ❌                                 |
| Helm `tpl` | ❌                                 |
| Default    | `{}`                               |

Example

```yaml
persistence:
  some-vol:
    targetSelector: {}
```

---

#### `targetSelector.$podName`

Define a map named after the pod to define the volume

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `persistence.$name.targetSelector.$podName` |
| Type       | `map`                                       |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | `{}`                                        |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod: {}
```

---

#### `targetSelector.$podName.$containerName`

Define a map named after the container to mount the volume

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `persistence.$name.targetSelector.$podName.$containerName` |
| Type       | `map`                                                      |
| Required   | ❌                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | `{}`                                                       |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod:
        my-container: {}
```

---

##### `targetSelector.$podName.$containerName.mountPath`

Define the mountPath for the container

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `persistence.$name.targetSelector.$podName.$containerName.mountPath` |
| Type       | `string`                                                             |
| Required   | ❌                                                                   |
| Helm `tpl` | ✅                                                                   |
| Default    | `$name.mountPath`                                                    |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod:
        my-container:
          mountPath: /path
```

---

##### `targetSelector.$podName.$containerName.mountPropagation`

Define the mountPropagation for the container

|            |                                                                             |
| ---------- | --------------------------------------------------------------------------- |
| Key        | `persistence.$name.targetSelector.$podName.$containerName.mountPropagation` |
| Type       | `string`                                                                    |
| Required   | ❌                                                                          |
| Helm `tpl` | ✅                                                                          |
| Default    | `$name.mountPropagation`                                                    |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod:
        my-container:
          mountPropagation: HostToContainer
```

---

##### `targetSelector.$podName.$containerName.subPath`

Define the subPath for the container

|            |                                                                    |
| ---------- | ------------------------------------------------------------------ |
| Key        | `persistence.$name.targetSelector.$podName.$containerName.subPath` |
| Type       | `string`                                                           |
| Required   | ❌                                                                 |
| Helm `tpl` | ✅                                                                 |
| Default    | `$name.subPath`                                                    |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod:
        my-container:
          subPath: some-path
```

---

##### `targetSelector.$podName.$containerName.readOnly`

Define the readOnly for the container

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `persistence.$name.targetSelector.$podName.$containerName.readOnly` |
| Type       | `bool`                                                              |
| Required   | ❌                                                                  |
| Helm `tpl` | ❌                                                                  |
| Default    | `$name.readOnly`                                                    |

Example

```yaml
persistence:
  some-vol:
    targetSelector:
      my-pod:
        my-container:
          readOnly: true
```

---

## Basic Examples

```yaml
# Example of a shared emptyDir volume
persistence:
  shared:
    enabled: true
    type: emptyDir
    mountPath: /shared
    readOnly: false
    targetSelectAll: true
```

```yaml
# Example of a volume mounted to a specific container with a specific mountPath
persistence:
  config:
    enabled: true
    type: emptyDir
    targetSelector:
      my-pod:
        my-container: {}
          mountPath: /path
          readOnly: false
        my-other-container: {}
          mountPath: /other/path
          readOnly: false
```

```yaml
# Example of a volume mounted to a specific container using the default mountPath
persistence:
  config:
    enabled: true
    type: emptyDir
    mountPath: /path
    readOnly: true
    targetSelector:
      my-pod:
        my-container: {}
        my-other-container:
          mountPath: /other/path
          readOnly: false
```

---

## Full Examples

Full examples can be found under each persistence type

- [hostPath](/common/persistence/hostpath)
- [configmap](/common/persistence/configmap)
- [secret](/common/persistence/secret)
- [device](/common/persistence/device)
- [pvc](/common/persistence/pvc-vct)
- [vct](/common/persistence/pvc-vct)
- [nfs](/common/persistence/nfs)
- [emptyDir](/common/persistence/emptydir)
- [iscsi](/common/persistence/iscsi)
