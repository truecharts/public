---
title: Storage Class
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/storageclass#full-examples) section for complete examples.

:::

## Appears in

- `.Values.storageClass`

## Naming scheme

- `$FullName-$StorageClassName` (release-name-chart-name-storageClassName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `storageClass`

Define storage classes

|            |                |
| ---------- | -------------- |
| Key        | `storageClass` |
| Type       | `map`          |
| Required   | ❌             |
| Helm `tpl` | ❌             |
| Default    | `{}`           |

Example

```yaml
storageClass: {}
```

---

### `$name`

Define storage class

|            |                      |
| ---------- | -------------------- |
| Key        | `storageClass.$name` |
| Type       | `map`                |
| Required   | ✅                   |
| Helm `tpl` | ❌                   |
| Default    | `{}`                 |

Example

```yaml
storageClass:
  storage-class-name: {}
```

---

#### `enabled`

Enables or Disables the storage class

|            |                              |
| ---------- | ---------------------------- |
| Key        | `storageClass.$name.enabled` |
| Type       | `bool`                       |
| Required   | ✅                           |
| Helm `tpl` | ✅                           |
| Default    | `false`                      |

Example

```yaml
storageClass:
  storage-class-name:
    enabled: true
```

---

#### `labels`

Additional labels for storage class

|            |                             |
| ---------- | --------------------------- |
| Key        | `storageClass.$name.labels` |
| Type       | `map`                       |
| Required   | ❌                          |
| Helm `tpl` | ✅ (On value only)          |
| Default    | `{}`                        |

Example

```yaml
storageClass:
  storage-class-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for storage class

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `storageClass.$name.annotations` |
| Type       | `map`                            |
| Required   | ❌                               |
| Helm `tpl` | ✅ (On value only)               |
| Default    | `{}`                             |

Example

```yaml
storageClass:
  storage-class-name:
    annotations:
      key: value
```

#### `provisioner`

Define the provisioner for this storage class

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `storageClass.$name.provisioner` |
| Type       | `string`                         |
| Required   | ✅                               |
| Helm `tpl` | ❌                               |
| Default    | `""`                             |

Example

```yaml
storageClass:
  storage-class-name:
    provisioner: some.provisioner.io
```

---

#### `parameters`

Define the parameters for this storage class

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `storageClass.$name.parameters` |
| Type       | `map`                           |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On value only)              |
| Default    | `{}`                            |

Example

```yaml
storageClass:
  storage-class-name:
    parameters:
      key: value
```

---

#### `reclaimPolicy`

Define the reclaim policy for this storage class

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `storageClass.$name.reclaimPolicy` |
| Type       | `string`                           |
| Required   | ❌                                 |
| Helm `tpl` | ❌                                 |
| Default    | `Retain`                           |

Valid values are:

- `Delete`
- `Retain`

Example

```yaml
storageClass:
  storage-class-name:
    reclaimPolicy: retain
```

---

#### `allowVolumeExpansion`

Define if volume expansion is allowed for this storage class

|            |                                           |
| ---------- | ----------------------------------------- |
| Key        | `storageClass.$name.allowVolumeExpansion` |
| Type       | `bool`                                    |
| Required   | ❌                                        |
| Helm `tpl` | ❌                                        |
| Default    | `false`                                   |

Example

```yaml
storageClass:
  storage-class-name:
    allowVolumeExpansion: true
```

---

#### `volumeBindingMode`

Define the volume binding mode for this storage class

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `storageClass.$name.volumeBindingMode` |
| Type       | `string`                               |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | `Immediate`                            |

Valid values are:

- `Immediate`
- `WaitForFirstConsumer`

Example

```yaml
storageClass:
  storage-class-name:
    volumeBindingMode: Immediate
```

---

#### `mountOptions`

Define the mount options for this storage class

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `storageClass.$name.mountOptions` |
| Type       | `list` of `string`                |
| Required   | ❌                                |
| Helm `tpl` | ✅ (On each entry only)           |
| Default    | `[]`                              |

Example

```yaml
storageClass:
  storage-class-name:
    mountOptions:
      - option1
      - option2=value
```

---

## Full Examples

```yaml
storageClass:
  example:
    provisioner: some.provisioner.io
    enabled: true
    parameters:
      param1: value1
      param2: value2
    reclaimPolicy: retain
    allowVolumeExpansion: true
    volumeBindingMode: Immediate
    mountOptions:
      - option1
      - option2=value
```
