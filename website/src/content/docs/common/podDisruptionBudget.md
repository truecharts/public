---
title: Pod Disruption Budget
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/poddisruptionbudget#full-examples) section for complete examples.

:::

## Appears in

- `.Values.podDisruptionBudget`

## Naming scheme

- `$FullName-$podDisruptionBudgetName` (release-name-chart-name-podDisruptionBudgetName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `podDisruptionBudget`

Create Pod Disruption Budget objects

|            |                       |
| ---------- | --------------------- |
| Key        | `podDisruptionBudget` |
| Type       | `map`                 |
| Required   | ❌                    |
| Helm `tpl` | ❌                    |
| Default    | `{}`                  |

Example

```yaml
podDisruptionBudget: {}
```

---

### `$name`

Define Pod Disruption Budget

:::note

At least one of the following keys must be defined

[`minAvailable`](/common/poddisruptionbudget#minavailable), [`maxUnavailable`](/common/poddisruptionbudget#maxunavailable)

:::

|            |                             |
| ---------- | --------------------------- |
| Key        | `podDisruptionBudget.$name` |
| Type       | `map`                       |
| Required   | ✅                          |
| Helm `tpl` | ❌                          |
| Default    | `{}`                        |

Example

```yaml
podDisruptionBudget:
  pdb-name: {}
```

---

#### `enabled`

Enables or Disables the Pod Disruption Budget

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `podDisruptionBudget.$name.enabled` |
| Type       | `bool`                              |
| Required   | ✅                                  |
| Helm `tpl` | ✅                                  |
| Default    | `false`                             |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                                       |
| ---------- | ------------------------------------- |
| Key        | `podDisruptionBudget.$name.namespace` |
| Type       | `string`                              |
| Required   | ❌                                    |
| Helm `tpl` | ✅                                    |
| Default    | `""`                                  |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for Pod Disruption Budget

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `podDisruptionBudget.$name.labels` |
| Type       | `map`                              |
| Required   | ❌                                 |
| Helm `tpl` | ✅ (On value only)                 |
| Default    | `{}`                               |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for Pod Disruption Budget

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `podDisruptionBudget.$name.annotations` |
| Type       | `map`                                   |
| Required   | ❌                                      |
| Helm `tpl` | ✅ (On value only)                      |
| Default    | `{}`                                    |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    annotations:
      key: value
```

---

#### `minAvailable`

Define the minAvailable.

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `podDisruptionBudget.$name.minAvailable` |
| Type       | `int` or `string`                        |
| Required   | ❌                                       |
| Helm `tpl` | ✅                                       |
| Default    | `""`                                     |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    minAvailable: 1
```

---

#### `maxUnavailable`

Define the maxUnavailable.

|            |                                            |
| ---------- | ------------------------------------------ |
| Key        | `podDisruptionBudget.$name.maxUnavailable` |
| Type       | `int` or `string`                          |
| Required   | ❌                                         |
| Helm `tpl` | ✅                                         |
| Default    | `""`                                       |

Example

```yaml
podDisruptionBudget:
  pdb-name:
    maxUnavailable: 1
```

---

#### `unhealthyPodEvictionPolicy`

Define the unhealthyPodEvictionPolicy

|            |                                                        |
| ---------- | ------------------------------------------------------ |
| Key        | `podDisruptionBudget.$name.unhealthyPodEvictionPolicy` |
| Type       | `string`                                               |
| Required   | ❌                                                     |
| Helm `tpl` | ✅                                                     |
| Default    | `""`                                                   |

Valid Values:

- `IfHealthyBudget`
- `AlwaysAllow`

Example

```yaml
podDisruptionBudget:
  pdb-name:
    unhealthyPodEvictionPolicy: IfHealthyBudget
```

---

## Full Examples

```yaml
podDisruptionBudget:
  pdb-name:
    enabled: true
    labels:
      key: value
      keytpl: "{{ .Values.some.value }}"
    annotations:
      key: value
      keytpl: "{{ .Values.some.value }}"
    minAvailable: 1
    maxUnavailable: 1
    unhealthyPodEvictionPolicy: IfHealthyBudget

  other-pdb-name:
    enabled: true
    namespace: some-namespace
    minAvailable: 1
```
