---
title: Priority Class
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/priorityclass#full-examples) section for complete examples.

:::

## Appears in

- `.Values.priorityClass`

## Naming scheme

- `$FullName-$PriorityClassName` (release-name-chart-name-priorityClassName)

:::tip

- Replace references to `$name` with the actual name you want to use.

:::

---

## `priorityClass`

Define priority classes

|            |                 |
| ---------- | --------------- |
| Key        | `priorityClass` |
| Type       | `map`           |
| Required   | ❌              |
| Helm `tpl` | ❌              |
| Default    | `{}`            |

Example

```yaml
priorityClass: {}
```

---

### `$name`

Define priority class

|            |                       |
| ---------- | --------------------- |
| Key        | `priorityClass.$name` |
| Type       | `map`                 |
| Required   | ✅                    |
| Helm `tpl` | ❌                    |
| Default    | `{}`                  |

Example

```yaml
priorityClass:
  priority-class-name: {}
```

---

#### `enabled`

Enables or Disables the priority class

|            |                               |
| ---------- | ----------------------------- |
| Key        | `priorityClass.$name.enabled` |
| Type       | `bool`                        |
| Required   | ✅                            |
| Helm `tpl` | ✅                            |
| Default    | `false`                       |

Example

```yaml
priorityClass:
  priority-class-name:
    enabled: true
```

---

#### `namespace`

Define the namespace for this object

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `priorityClass.$name.namespace` |
| Type       | `string`                        |
| Required   | ❌                              |
| Helm `tpl` | ✅ (On value only)              |
| Default    | `""`                            |

Example

```yaml
priorityClass:
  priority-class-name:
    namespace: some-namespace
```

---

#### `labels`

Additional labels for priority class

|            |                              |
| ---------- | ---------------------------- |
| Key        | `priorityClass.$name.labels` |
| Type       | `map`                        |
| Required   | ❌                           |
| Helm `tpl` | ✅ (On value only)           |
| Default    | `{}`                         |

Example

```yaml
priorityClass:
  priority-class-name:
    labels:
      key: value
```

---

#### `annotations`

Additional annotations for priority class

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `priorityClass.$name.annotations` |
| Type       | `map`                             |
| Required   | ❌                                |
| Helm `tpl` | ✅ (On value only)                |
| Default    | `{}`                              |

Example

```yaml
priorityClass:
  priority-class-name:
    annotations:
      key: value
```

---

#### `value`

Define the value for this priority class

|            |                             |
| ---------- | --------------------------- |
| Key        | `priorityClass.$name.value` |
| Type       | `int`                       |
| Required   | ❌                          |
| Helm `tpl` | ❌                          |
| Default    | `1000000`                   |

Example

```yaml
priorityClass:
  priority-class-name:
    value: 1000000
```

---

#### `globalDefault`

Define if this priority class is the global default

|            |                                     |
| ---------- | ----------------------------------- |
| Key        | `priorityClass.$name.globalDefault` |
| Type       | `bool`                              |
| Required   | ❌                                  |
| Helm `tpl` | ❌                                  |
| Default    | `false`                             |

Example

```yaml
priorityClass:
  priority-class-name:
    globalDefault: true
```

---

#### `description`

Define the description for this priority class

|            |                                   |
| ---------- | --------------------------------- |
| Key        | `priorityClass.$name.description` |
| Type       | `string`                          |
| Required   | ❌                                |
| Helm `tpl` | ❌                                |
| Default    | `No description given`            |

Example

```yaml
priorityClass:
  priority-class-name:
    description: "some description"
```

---

#### `preemptionPolicy`

Define the preemption policy for this priority class

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `priorityClass.$name.preemptionPolicy` |
| Type       | `string`                               |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | `Immediate`                            |

Valid values are:

- `PreemptLowerPriority`
- `Never`

Example

```yaml
priorityClass:
  priority-class-name:
    preemptionPolicy: PreemptLowerPriority
```

---

## Full Examples

```yaml
priorityClass:
  example:
    enabled: true
    value: 1000000
    preemptionPolicy: PreemptLowerPriority
    globalDefault: false
    description: "some description"
```
