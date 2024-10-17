---
title: Termination
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/termination#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`

---

## `termination`

Define termination for the container

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.termination` |
| Type       | `map`                                                 |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | `{}`                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          termination: {}
```

---

### `termination.messagePath`

Define termination message path for the container

|            |                                                                   |
| ---------- | ----------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.termination.messagePath` |
| Type       | `string`                                                          |
| Required   | ❌                                                                |
| Helm `tpl` | ✅                                                                |
| Default    | `""`                                                              |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          termination:
            messagePath: /dev/termination-log
```

---

### `termination.messagePolicy`

Define termination message policy for the container

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.termination.messagePolicy` |
| Type       | `string`                                                            |
| Required   | ❌                                                                  |
| Helm `tpl` | ✅                                                                  |
| Default    | `""`                                                                |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          termination:
            messagePolicy: File
```

---

## Full Examples

```yaml
workload:
  workload-name:
    enabled: true
    primary: true
    podSpec:
      containers:
        container-name:
          enabled: true
          primary: true
          termination:
            messagePath: /dev/termination-log
            messagePolicy: File
```
