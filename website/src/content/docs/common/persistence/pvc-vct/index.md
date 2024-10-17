---
title: PVC / VCT
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/persistence/pvc-vct#full-examples) section for complete examples.

:::

## Appears in

- `.Values.persistence.$name`

:::tip

- See available persistence keys [here](/common/persistence).
- This options apply only when `type: pvc` or `type: vct`.

:::

---

## `labels`

Additional labels for persistence

|            |                            |
| ---------- | -------------------------- |
| Key        | `persistence.$name.labels` |
| Type       | `map`                      |
| Required   | ❌                         |
| Helm `tpl` | ✅ (On value only)         |
| Default    | `{}`                       |

Example

```yaml
persistence:
  pvc-vol:
    labels:
      label1: value1
```

---

## `annotations`

Additional annotations for persistence

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `persistence.$name.annotations` |
| Type       | `map`                           |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On value only)              |
| Default    | `{}`                            |

Example

```yaml
persistence:
  pvc-vol:
    annotations:
      annotation1: value1
```

---

## `namespace`

Define the namespace for this object

|            |                               |
| ---------- | ----------------------------- |
| Key        | `persistence.$name.namespace` |
| Type       | `string`                      |
| Required   | ❌                            |
| Helm `tpl` | ✅                            |
| Default    | `""`                          |

Example

```yaml
persistence:
  pvc-vol:
    namespace: some-namespace
```

---

## `retain`

Define wether the to add helm annotation to retain resource on uninstall.
This does not **guarantee** that the resource will be retained.

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `persistence.$name.retain`                             |
| Type       | `bool`                                                 |
| Required   | ❌                                                     |
| Helm `tpl` | ❌                                                     |
| Default    | See default [here](/common/fallbackdefaults#pvcretain) |

Example

```yaml
persistence:
  pvc-vol:
    retain: true
```

---

## `accessModes`

Define the accessModes of the PVC, if it's single can be defined as a string, multiple as a list

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `persistence.$name.accessModes`                          |
| Type       | `string` or `list`                                       |
| Required   | ❌                                                       |
| Helm `tpl` | ✅                                                       |
| Default    | See default [here](/common/fallbackdefaults#accessmodes) |

Example

```yaml
persistence:
  pvc-vol:
    accessModes: ReadWriteOnce

persistence:
  pvc-vol:
    accessModes:
      - ReadWriteOnce
      - ReadWriteMany
```

---

## `volumeName`

Define the volumeName of a PV, backing the claim

|            |                                |
| ---------- | ------------------------------ |
| Key        | `persistence.$name.volumeName` |
| Type       | `string`                       |
| Required   | ❌                             |
| Helm `tpl` | ✅                             |
| Default    | `""`                           |

Example

```yaml
persistence:
  pvc-vol:
    volumeName: volume-name-backing-the-pvc
```

---

## `existingClaim`

Define an existing claim to use

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `persistence.$name.existingClaim` |
| Type       | `string`                          |
| Required   | ❌                                |
| Helm `tpl` | ✅                                |
| Default    | `""`                              |

Example

```yaml
persistence:
  pvc-vol:
    existingClaim: existing-claim-name
```

---

## `size`

Define the size of the PVC

|            |                                                                                                         |
| ---------- | ------------------------------------------------------------------------------------------------------- |
| Key        | `persistence.$name.size`                                                                                |
| Type       | `string`                                                                                                |
| Required   | ❌                                                                                                      |
| Helm `tpl` | ✅                                                                                                      |
| Default    | See default [pvcSize](/common/fallbackdefaults#pvcsize) and [vctSize](/common/fallbackdefaults#vctsize) |

Example

```yaml
persistence:
  pvc-vol:
    size: 2Gi
```

---

## `storageClass`

Define the storageClass to use

:::note How storageClass is resolved

- If storageClass is defined on the `persistence`
  - `-` **->** `""`, (which means requesting a PV without class)
  - Else **->** as is
- Else if [fallback storageClass](/common/fallbackdefaults#storageclass), **->** this
- Else **->** _nothing_ (which means requesting a PV without class)

:::

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.storageClass` |
| Type       | `string`                         |
| Required   | ❌                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
persistence:
  pvc-vol:
    storageClass: storage-class-name
```

---

## `dataSource`

Define dataSource for the pvc

|            |                                |
| ---------- | ------------------------------ |
| Key        | `persistence.$name.dataSource` |
| Type       | `map`                          |
| Required   | ❌                             |
| Helm `tpl` | ❌                             |
| Default    | `{}`                           |

Example

```yaml
persistence:
  pvc-vol:
    dataSource: {}
```

---

### `dataSource.kind`

Define the kind of the dataSource

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `persistence.$name.dataSource.kind` |
| Type       | `string`                            |
| Required   | ✅                                  |
| Helm `tpl` | ❌                                  |
| Default    | `""`                                |

Valid Values

- `PersistentVolumeClaim`
- `VolumeSnapshot`

Example

```yaml
persistence:
  pvc-vol:
    dataSource:
      kind: "PersistentVolumeClaim"
```

---

### `dataSource.name`

Define the name of the dataSource

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `persistence.$name.dataSource.name` |
| Type       | `string`                            |
| Required   | ✅                                  |
| Helm `tpl` | ❌                                  |
| Default    | `""`                                |

Example

```yaml
persistence:
  pvc-vol:
    dataSource:
      name: "existingPVC"
```

---

## `static`

Define static provisioning for the pvc

|            |                            |
| ---------- | -------------------------- |
| Key        | `persistence.$name.static` |
| Type       | `map`                      |
| Required   | ❌                         |
| Helm `tpl` | ❌                         |
| Default    | `{}`                       |

Example

```yaml
persistence:
  pvc-vol:
    static: {}
```

---

### `static.mode`

Define the mode of the static provisioning

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `persistence.$name.static.mode` |
| Type       | `string`                        |
| Required   | ✅                              |
| Helm `tpl` | ❌                              |
| Default    | `""`                            |

Valid Values

- [`nfs`](/common/persistence/pvc-vct/static-nfs)
- [`smb`](/common/persistence/pvc-vct/static-smb)
- [`custom`](/common/persistence/pvc-vct/static-custom)

Example

```yaml
persistence:
  pvc-vol:
    static:
      mode: nfs
```

---

## `mountOptions`

Define mountOptions for the pvc.
Available only for `static.mode: nfs|smb`

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `persistence.$name.mountOptions` |
| Type       | `list` of `map`                  |
| Required   | ❌                               |
| Helm `tpl` | ❌                               |
| Default    | `[]`                             |

Example

```yaml
persistence:
  pvc-vol:
    mountOptions: []
```

### `mountOptions[].key`

Define the key of the mountOption

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `persistence.$name.mountOptions[].key` |
| Type       | `string`                               |
| Required   | ✅                                     |
| Helm `tpl` | ✅                                     |
| Default    | `""`                                   |

Example

```yaml
persistence:
  pvc-vol:
    mountOptions:
      - key: some-key
```

---

### `mountOptions[].value`

Define the value of the mountOption

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `persistence.$name.mountOptions[].value` |
| Type       | `string`                                 |
| Required   | ❌                                       |
| Helm `tpl` | ✅                                       |
| Default    | `""`                                     |

Example

```yaml
persistence:
  pvc-vol:
    mountOptions:
      - value: some-value
```

---

## `volumeSnapshots`

Define volumeSnapshots for the pvc

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `persistence.$name.volumeSnapshots` |
| Type       | `list` of `map`                     |
| Required   | ❌                                  |
| Helm `tpl` | ❌                                  |
| Default    | `[]`                                |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots: []
```

### `volumeSnapshots[].name`

Define the name of the volumeSnapshot

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `persistence.$name.volumeSnapshots[].name` |
| Type       | `string`                                   |
| Required   | ❌                                         |
| Helm `tpl` | ❌                                         |
| Default    | `""`                                       |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots:
      - name: example1
```

### `volumeSnapshots[].enabled`

Define if the volumeSnapshot is enabled

|            |                                               |
| ---------- | --------------------------------------------- |
| Key        | `persistence.$name.volumeSnapshots[].enabled` |
| Type       | `bool`                                        |
| Required   | ❌                                            |
| Helm `tpl` | ❌                                            |
| Default    | `false`                                       |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots:
      - enabled: true
```

### `volumeSnapshots[].labels`

Define the labels of the volumeSnapshot

|            |                                              |
| ---------- | -------------------------------------------- |
| Key        | `persistence.$name.volumeSnapshots[].labels` |
| Type       | `map`                                        |
| Required   | ❌                                           |
| Helm `tpl` | ✅ (On value only)                           |
| Default    | `{}`                                         |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots:
      - labels:
          label1: value1
```

### `volumeSnapshots[].annotations`

Define the annotations of the volumeSnapshot

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `persistence.$name.volumeSnapshots[].annotations` |
| Type       | `map`                                             |
| Required   | ❌                                                |
| Helm `tpl` | ✅ (On value only)                                |
| Default    | `{}`                                              |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots:
      - annotations:
          annotation1: value1
```

### `volumeSnapshots[].volumeSnapshotClassName`

Define the volumeSnapshotClassName of the volumeSnapshot

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `persistence.$name.volumeSnapshots[].volumeSnapshotClassName` |
| Type       | `string`                                                      |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | `""`                                                          |

Example

```yaml
persistence:
  pvc-vol:
    volumeSnapshots:
      - volumeSnapshotClassName: some-name
```

---

## Full Examples

```yaml
persistence:
  pvc-vol:
    enabled: true
    type: pvc
    namespace: some-namespace
    labels:
      label1: value1
    annotations:
      annotation1: value1
    dataSource:
      kind: "PersistentVolumeClaim"
      name: "existingPVC"
    accessModes: ReadWriteOnce
    volumeName: volume-name-backing-the-pvc
    existingClaim: existing-claim-name
    retain: true
    size: 2Gi
    mountOptions:
      - key: some-key
        value: some-value
    # static:
    #   mode: custom
    #   provisioner: provisioner
    #   driver: driver
    #   csi:
    #     key: value
    volumeSnapshots:
      - name: example1
        enabled: true
        labels:
          label1: value1
        annotations:
          annotation1: value1
        volumeSnapshotClassName: some-name
    # targetSelectAll: true
    targetSelector:
      pod-name:
        container-name:
          mountPath: /path/to/mount
```
