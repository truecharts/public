---
title: Command
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/command#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`
- `.Values.workload.$name.podSpec.containers.$name.probes.liveness`
- `.Values.workload.$name.podSpec.containers.$name.probes.readiness`
- `.Values.workload.$name.podSpec.containers.$name.probes.startup`

---

## `command`

Define command(s). If it's single, can be defined as string

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.command` |
| Type       | `string` or `list` of `string`                    |
| Required   | ❌                                                |
| Helm `tpl` | ✅                                                |
| Default    | `[]`                                              |

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
          # As a list
          command:
            - command1
            - command2
          # As a string
          command: command
```
