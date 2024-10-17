---
title: Volume Snapshot Class
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/volumesnapshotclass#full-examples) section for complete examples.

:::

## Appears in

- `.Values.volumeSnapshotClass`

---

## `volumeSnapshotClass`

Define a volume snapshot class

|            |                       |
| ---------- | --------------------- |
| Key        | `volumeSnapshotClass` |
| Type       | `map`                 |
| Required   | ❌                    |
| Helm `tpl` | ❌                    |
| Default    | `{}`                  |

Example

```yaml
volumeSnapshotClass: {}
```

---

### `$name`

Define a volume snapshot class

|            |                             |
| ---------- | --------------------------- |
| Key        | `volumeSnapshotClass.$name` |
| Type       | `map`                       |
| Required   | ❌                          |
| Helm `tpl` | ❌                          |
| Default    | `{}`                        |

Example

```yaml
volumeSnapshotClass:
  example1: {}
```

---

#### `labels`

Define the labels of the volume snapshot class

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `volumeSnapshotClass.$name.labels` |
| Type       | `map`                              |
| Required   | ❌                                 |
| Helm `tpl` | ✅ (On value only)                 |
| Default    | `{}`                               |

Example

```yaml
volumeSnapshotClass:
  example1:
    labels:
      key: value
```

---

#### `annotations`

Define the annotations of the volume snapshot class

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `volumeSnapshotClass.$name.annotations` |
| Type       | `map`                                   |
| Required   | ❌                                      |
| Helm `tpl` | ✅ (On value only)                      |
| Default    | `{}`                                    |

Example

```yaml
volumeSnapshotClass:
  example1:
    annotations:
      key: value
```

---

#### `enabled`

Enable volume snapshot class

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `volumeSnapshotClass.$name.enabled` |
| Type       | `bool`                              |
| Required   | ✅                                  |
| Helm `tpl` | ✅                                  |
| Default    | `false`                             |

Example

```yaml
volumeSnapshotClass:
  example1:
    enabled: true
```

---

#### `isDefault`

Sets the annotation `snapshot.storage.kubernetes.io/is-default-class` to `"true"` or `"false"`

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `volumeSnapshotClass.$name.isDefault` |
| Type       | `bool`                                |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |
| Default    | `false`                               |

Example

```yaml
volumeSnapshotClass:
  example1:
    isDefault: true
```

---

#### `driver`

Define the driver of the volume snapshot class

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `volumeSnapshotClass.$name.driver` |
| Type       | `string`                           |
| Required   | ✅                                 |
| Helm `tpl` | ✅                                 |
| Default    | `""`                               |

Example

```yaml
volumeSnapshotClass:
  example1:
    driver: csi-hostpath-snapshots
```

---

#### `deletionPolicy`

Define the deletion policy of the volume snapshot class

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `volumeSnapshotClass.$name.deletionPolicy` |
| Type       | `string`                                   |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | `Retain`                                   |

Example

```yaml
volumeSnapshotClass:
  example1:
    deletionPolicy: Delete
```

---

#### `parameters`

Define the parameters of the volume snapshot class

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `volumeSnapshotClass.$name.parameters` |
| Type       | `map`                                  |
| Required   | ❌                                     |
| Helm `tpl` | ✅ (On both key and value)             |
| Default    | `{}`                                   |

Example

```yaml
volumeSnapshotClass:
  example1:
    parameters:
      key: value
```

---

## Full Examples

```yaml
volumeSnapshotClass:
  class1:
    enabled: true
    driver: csi-hostpath-snapshots
    deletionPolicy: Delete
    labels:
      label1: "{{ .Values.label1 }}"
      label2: label2
    annotations:
      annotation1: "{{ .Values.annotation1 }}"
      annotation2: annotation2
  class2:
    enabled: true
    isDefault: true
    driver: "{{ .Values.some_driver }}"
    labels:
      label1: "{{ .Values.label1 }}"
      label2: label2
    annotations:
      annotation1: "{{ .Values.annotation1 }}"
      annotation2: annotation2
    parameters:
      "{{ .Values.some_key }}": "{{ .Values.some_value }}"
      parameter2: 5
```
