---
title: Configmap
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/configmap#full-examples) section for complete examples.

:::

## Appears in

- `.Values.configmap`

## Naming scheme

- `$FullName-$ConfigmapName` (release-name-chart-name-configmap-name)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `configmap`

Create Configmap objects

|            |             |
| ---------- | ----------- |
| Key        | `configmap` |
| Type       | `map`       |
| Required   | ❌          |
| Helm `tpl` | ❌          |
| Default    | `{}`        |

Example

```yaml
configmap: {}
```

---

### `$name`

Define Configmap

|            |                   |
| ---------- | ----------------- |
| Key        | `configmap.$name` |
| Type       | `map`             |
| Required   | ✅                |
| Helm `tpl` | ❌                |
| Default    | `{}`              |

Example

```yaml
configmap:
  configmap-name: {}
```

---

#### `enabled`

Enables or Disables the Configmap

|            |                           |
| ---------- | ------------------------- |
| Key        | `configmap.$name.enabled` |
| Type       | `bool`                    |
| Required   | ✅                        |
| Helm `tpl` | ✅                        |
| Default    | `false`                   |

Example

```yaml
configmap:
  configmap-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                             |
| ---------- | --------------------------- |
| Key        | `configmap.$name.namespace` |
| Type       | `string`                    |
| Required   | ❌                          |
| Helm `tpl` | ✅                          |
| Default    | `""`                        |

Example

```yaml
configmap:
  configmap-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for configmap

|            |                          |
| ---------- | ------------------------ |
| Key        | `configmap.$name.labels` |
| Type       | `map`                    |
| Required   | ❌                       |
| Helm `tpl` | ✅ (On value only)       |
| Default    | `{}`                     |

Example

```yaml
configmap:
  configmap-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for configmap

|            |                               |
| ---------- | ----------------------------- |
| Key        | `configmap.$name.annotations` |
| Type       | `map`                         |
| Required   | ❌                            |
| Helm `tpl` | ✅ (On value only)            |
| Default    | `{}`                          |

Example

```yaml
configmap:
  configmap-name:
    annotations:
      key: value
```

---

#### `data`

Define the data of the configmap

|            |                        |
| ---------- | ---------------------- |
| Key        | `configmap.$name.data` |
| Type       | `map`                  |
| Required   | ✅                     |
| Helm `tpl` | ✅                     |
| Example    | `{}`                   |

```yaml
configmap:
  configmap-name:
    data:
      key: value
```

---

## Full Examples

```yaml
configmap:
  configmap-name:
    enabled: true
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    data:
      key: value

  other-configmap-name:
    enabled: true
    namespace: some-namespace
    data:
      key: |
        multi line
        text value
```
