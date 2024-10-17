---
title: Args
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/args#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`

---

## `args`

Define arg(s). If it's single, can be defined as string

|            |                                                |
| ---------- | ---------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.args` |
| Type       | `string` or `list` of `string`                 |
| Required   | ❌                                             |
| Helm `tpl` | ✅                                             |
| Default    | `[]`                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          args:
            - arg1
            - arg2
# Or
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          args: arg
```

---

## `extraArgs`

Define extraArg(s).

:::note

Those are appended **after** the `args`.
Useful for adding args after the ones defined by the chart.

:::

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.extraArgs` |
| Type       | `string` or `list` of `string`                      |
| Required   | ❌                                                  |
| Helm `tpl` | ✅                                                  |
| Default    | `[]`                                                |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          extraArgs:
            - extraArg1
            - extraArg2
# Or
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          extraArgs: extraArg
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
          args: arg
          extraArgs:
            - extraArg
```
