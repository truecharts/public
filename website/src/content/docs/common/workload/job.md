---
title: Job
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/workload/job#full-examples) section for complete examples.
- See the [Workload](/common/workload) documentation for more information

:::

:::tip

Replace references to `$name` with the actual name you want to use.

:::

## Appears in

- `.Values.workload.$name`

## Notes

Value of `workload.$name.podSpec.restartPolicy` can **not** be `Always` for this type of workload

---

## `completionMode`

Define the completionMode

|            |                                 |
| ---------- | ------------------------------- |
| Key        | `workload.$name.completionMode` |
| Type       | `string`                        |
| Required   | ❌                              |
| Helm `tpl` | ❌                              |
| Default    | `NonIndexed`                    |

Valid Values:

- `Indexed`
- `NonIndexed`

Example

```yaml
workload:
  workload-name:
    completionMode: Indexed
```

---

## `backoffLimit`

Define the backoffLimit

|            |                               |
| ---------- | ----------------------------- |
| Key        | `workload.$name.backoffLimit` |
| Type       | `int`                         |
| Required   | ❌                            |
| Helm `tpl` | ❌                            |
| Default    | `5`                           |

Example

```yaml
workload:
  workload-name:
    backoffLimit: 5
```

---

## `completions`

Define the completions

|            |                              |
| ---------- | ---------------------------- |
| Key        | `workload.$name.completions` |
| Type       | `int`                        |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | unset                        |

Example

```yaml
workload:
  workload-name:
    completions: 5
```

---

## `parallelism`

Define the parallelism

|            |                              |
| ---------- | ---------------------------- |
| Key        | `workload.$name.parallelism` |
| Type       | `int`                        |
| Required   | ❌                           |
| Helm `tpl` | ❌                           |
| Default    | `1`                          |

Example

```yaml
workload:
  workload-name:
    parallelism: 5
```

---

## `ttlSecondsAfterFinished`

Define the ttlSecondsAfterFinished

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `workload.$name.ttlSecondsAfterFinished` |
| Type       | `int`                                    |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | `120`                                    |

Example

```yaml
workload:
  workload-name:
    ttlSecondsAfterFinished: 100
```

---

## `activeDeadlineSeconds`

Define the activeDeadlineSeconds

|            |                                        |
| ---------- | -------------------------------------- |
| Key        | `workload.$name.activeDeadlineSeconds` |
| Type       | `int`                                  |
| Required   | ❌                                     |
| Helm `tpl` | ❌                                     |
| Default    | unset                                  |

Example

```yaml
workload:
  workload-name:
    activeDeadlineSeconds: 100
```

---

## Full Examples

```yaml
workload:
  workload-name:
    enabled: true
    primary: true
    type: Job
    backoffLimit: 5
    completionMode: Indexed
    completions: 5
    parallelism: 5
    ttlSecondsAfterFinished: 100
    activeDeadlineSeconds: 100
    podSpec:
      restartPolicy: Never

  other-workload-name:
    enabled: true
    primary: false
    type: Job
    podSpec: {}
```
