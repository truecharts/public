---
title: Service Account
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/serviceaccount#full-examples) section for complete examples.

:::

## Appears in

- `.Values.serviceAccount`

## Naming scheme

- Primary: `$FullName` (release-name-chart-name)
- Non-Primary: `$FullName-$ServiceAccountName` (release-name-chart-name-ServiceAccountName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## Target Selector

- `targetSelectAll` (bool): Whether to assign the serviceAccount to all pods or not. `targetSelector` is ignored in this case
- `targetSelector` (list): Define the pod(s) to assign the serviceAccount
- `targetSelector` (empty): Assign the serviceAccount to the primary pod

---

## `serviceAccount`

Create serviceAccount objects

|            |                  |
| ---------- | ---------------- |
| Key        | `serviceAccount` |
| Type       | `map`            |
| Required   | ❌               |
| Helm `tpl` | ❌               |
| Default    | `{}`             |

Example

```yaml
serviceAccount: {}
```

---

### `serviceAccount.$name`

Define serviceAccount

|            |                        |
| ---------- | ---------------------- |
| Key        | `serviceAccount.$name` |
| Type       | `map`                  |
| Required   | ✅                     |
| Helm `tpl` | ❌                     |
| Default    | `{}`                   |

Example

```yaml
serviceAccount:
  sa-name: {}
```

---

#### `enabled`

Enables or Disables the serviceAccount

|            |                                |
| ---------- | ------------------------------ |
| Key        | `serviceAccount.$name.enabled` |
| Type       | `bool`                         |
| Required   | ✅                             |
| Helm `tpl` | ✅                             |
| Default    | `false`                        |

Example

```yaml
serviceAccount:
  sa-name:
    enabled: true
```

---

#### `primary`

Sets the serviceAccount as primary

|            |                                |
| ---------- | ------------------------------ |
| Key        | `serviceAccount.$name.primary` |
| Type       | `bool`                         |
| Required   | ❌                             |
| Helm `tpl` | ❌                             |
| Default    | `false`                        |

Example

```yaml
serviceAccount:
  sa-name:
    primary: true
```

---

#### `namespace`

Define the namespace for this object

|            |                                  |
| ---------- | -------------------------------- |
| Key        | `serviceAccount.$name.namespace` |
| Type       | `string`                         |
| Required   | ❌                               |
| Helm `tpl` | ✅                               |
| Default    | `""`                             |

Example

```yaml
serviceAccount:
  sa-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for service account

|            |                               |
| ---------- | ----------------------------- |
| Key        | `serviceAccount.$name.labels` |
| Type       | `map`                         |
| Required   | ❌                            |
| Helm `tpl` | ✅ (On value only)            |
| Default    | `{}`                          |

Example

```yaml
serviceAccount:
  sa-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for service account

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `serviceAccount.$name.annotations` |
| Type       | `map`                              |
| Required   | ❌                                 |
| Helm `tpl` | ✅ (On value only)                 |
| Default    | `{}`                               |

Example

```yaml
serviceAccount:
  sa-name:
    annotations:
      key: value
```

---

#### `targetSelectAll`

Whether to assign the serviceAccount to all pods or not

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `serviceAccount.$name.targetSelectAll` |
| Type       | `bool`                                 |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | unset                                  |

Example

```yaml
serviceAccount:
  sa-name:
    targetSelectAll: true
```

---

#### `targetSelector`

Define the pod(s) to assign the serviceAccount

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `serviceAccount.$name.targetSelector` |
| Type       | `list` of `string`                    |
| Required   | ❌                                    |
| Helm `tpl` | ❌                                    |
| Default    | `[]`                                  |

Example

```yaml
serviceAccount:
  sa-name:
    targetSelector:
      - workload-name1
      - workload-name2
```

---

## Full Examples

```yaml
serviceAccount:
  sa-name:
    enabled: true
    primary: true
    namespace: some-namespace
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    targetSelectAll: true

  other-sa-name:
    enabled: true
    namespace: some-namespace
    targetSelector:
      - pod-name
      - other-pod-name
```
