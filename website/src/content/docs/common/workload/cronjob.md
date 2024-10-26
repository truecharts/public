---
title: CronJob
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/workload/cronjob#full-examples) section for complete examples.
- See the [Workload](/common/workload) documentation for more information

:::

:::tip

Replace references to `$name` with the actual name you want to use.

:::

## Appears in

- `.Values.workload.$name`

## Notes

Value of `workload.$name.podSpec.restartPolicy` can **not** be `Always` for this type of workload

## `schedule`

Define the schedule

|            |                           |
| ---------- | ------------------------- |
| Key        | `workload.$name.schedule` |
| Type       | `string`                  |
| Required   | ✅                        |
| Helm `tpl` | ✅                        |
| Default    | `""`                      |

Example

```yaml
workload:
  workload-name:
    schedule: "{{ .Values.cron }}"
```

---

## `timezone`

Define the timezone

|            |                                |
| ---------- | ------------------------------ |
| Key        | `workload.$name.timezone`      |
| Type       | `string`                       |
| Required   | ❌                             |
| Helm `tpl` | ✅                             |
| Default    | See [here](/common#tz) |

Example

```yaml
workload:
  workload-name:
    timezone: "{{ .Values.someTimezone }}"
```

---

## `concurrencyPolicy`

Define the concurrencyPolicy

|            |                                    |
| ---------- | ---------------------------------- |
| Key        | `workload.$name.concurrencyPolicy` |
| Type       | `string`                           |
| Required   | ❌                                 |
| Helm `tpl` | ✅                                 |
| Default    | `Forbid`                           |

Valid Values:

- `Allow`
- `Replace`
- `Forbid`

Example

```yaml
workload:
  workload-name:
    concurrencyPolicy: Allow
```

---

## `failedJobsHistoryLimit`

Define the failedJobsHistoryLimit

|            |                                         |
| ---------- | --------------------------------------- |
| Key        | `workload.$name.failedJobsHistoryLimit` |
| Type       | `int`                                   |
| Required   | ❌                                      |
| Helm `tpl` | ✅                                      |
| Default    | `1`                                     |

Example

```yaml
workload:
  workload-name:
    failedJobsHistoryLimit: 2
```

---

## `successfulJobsHistoryLimit`

Define the successfulJobsHistoryLimit

|            |                                             |
| ---------- | ------------------------------------------- |
| Key        | `workload.$name.successfulJobsHistoryLimit` |
| Type       | `int`                                       |
| Required   | ❌                                          |
| Helm `tpl` | ❌                                          |
| Default    | `3`                                         |

Example

```yaml
workload:
  workload-name:
    successfulJobsHistoryLimit: 4
```

---

## `startingDeadlineSeconds`

Define the startingDeadlineSeconds

|            |                                          |
| ---------- | ---------------------------------------- |
| Key        | `workload.$name.startingDeadlineSeconds` |
| Type       | `int`                                    |
| Required   | ❌                                       |
| Helm `tpl` | ❌                                       |
| Default    | unset                                    |

Example

```yaml
workload:
  workload-name:
    startingDeadlineSeconds: 100
```

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
    type: CronJob
    schedule: "{{ .Values.cron }}"
    timezone: "{{ .Values.someTimezone }}"
    concurrencyPolicy: Allow
    failedJobsHistoryLimit: 2
    successfulJobsHistoryLimit: 4
    startingDeadlineSeconds: 100
    backoffLimit: 5
    completionMode: Indexed
    completions: 5
    parallelism: 5
    ttlSecondsAfterFinished: 100
    activeDeadlineSeconds: 100
    podSpec:
      restartPolicy: OnFailure

  other-workload-name:
    enabled: true
    primary: false
    type: CronJob
    schedule: "* * * * *"
    podSpec: {}
```
