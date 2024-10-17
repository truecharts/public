---
title: Volume Snapshot
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/volumesnapshot#full-examples) section for complete examples.

:::

## Appears in

- `.Values.volumeSnapshots`

---

## `volumeSnapshots`

Define a volume snapshot

|            |                   |
| ---------- | ----------------- |
| Key        | `volumeSnapshots` |
| Type       | `map`             |
| Required   | ❌                |
| Helm `tpl` | ❌                |
| Default    | `{}`              |

Example

```yaml
volumeSnapshots: {}
```

---

### `$name`

Define a volume snapshot

|            |                         |
| ---------- | ----------------------- |
| Key        | `volumeSnapshots.$name` |
| Type       | `map`                   |
| Required   | ❌                      |
| Helm `tpl` | ❌                      |
| Default    | `{}`                    |

Example

```yaml
volumeSnapshots:
  example1: {}
```

---

#### `labels`

Define the labels of the volume snapshot

|            |                                |
| ---------- | ------------------------------ |
| Key        | `volumeSnapshots.$name.labels` |
| Type       | `map`                          |
| Required   | ❌                             |
| Helm `tpl` | ✅ (On value only)             |
| Default    | `{}`                           |

Example

```yaml
volumeSnapshots:
  example1:
    labels:
      key: value
```

---

#### `annotations`

Define the annotations of the volume snapshot class

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `volumeSnapshots.$name.annotations` |
| Type       | `map`                               |
| Required   | ❌                                  |
| Helm `tpl` | ✅ (On value only)                  |
| Default    | `{}`                                |

Example

```yaml
volumeSnapshots:
  example1:
    annotations:
      key: value
```

---

#### `enabled`

Enable volume snapshot

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `volumeSnapshots.$name.enabled` |
| Type       | `bool`                          |
| Required   | ✅                              |
| Helm `tpl` | ✅                              |
| Default    | `false`                         |

Example

```yaml
volumeSnapshots:
  example1:
    enabled: true
```

---

#### `source`

Define the source of the volume snapshot

:::note

At least one of the following keys must be defined

[`volumeSnapshotContentName`](/common/volumesnapshot#volumesnapshotcontentname), [`persistentVolumeClaimName`](/common/volumesnapshot#persistentvolumeclaimname)

:::

|            |                                |
| ---------- | ------------------------------ |
| Key        | `volumeSnapshots.$name.source` |
| Type       | `map`                          |
| Required   | ✅                             |
| Helm `tpl` | ❌                             |
| Default    | `{}`                           |

Example

```yaml
volumeSnapshots:
  example1:
    enabled: true
    source: {}
```

##### `volumeSnapshotContentName`

Define the volume snapshot content name

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `volumeSnapshots.$name.source.volumeSnapshotContentName` |
| Type       | `string`                                                 |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `""`                                                     |

Example

```yaml
volumeSnapshots:
  example1:
    enabled: true
    source:
      volumeSnapshotContentName: some-name
```

---

##### `persistentVolumeClaimName`

Define the persistent volume claim name

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `volumeSnapshots.$name.source.persistentVolumeClaimName` |
| Type       | `string`                                                 |
| Required   | ❌                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `""`                                                     |

Example

```yaml
volumeSnapshots:
  example1:
    enabled: true
    source:
      persistentVolumeClaimName: some-pvc-name
```

---

## Full Examples

```yaml
volumeSnapshots:
  example1:
    enabled: true
    source:
      volumeSnapshotContentName: some-name
  example2:
    enabled: true
    source:
      persistentVolumeClaimName: some-pvc-name
```
