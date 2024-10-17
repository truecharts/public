---
title: EnvList
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/envlist#full-examples) section for complete examples.

:::

:::tip

Variable names will be scanned for duplicates across all
[secrets](/common/secret), [configmaps](/common/configmap),
[env](/common/container/env), [envList](/common/container/envlist) and [fixedEnv](/common/container/fixedenv)
and will throw an error if it finds any.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`

---

## `envList`

Define env(s) for the container

:::note

- This should not be used unless you have instructions from the maintainer to do so.
- For native helm charts, use [env](/common/container/env) instead.

:::

|            |                                                   |
| ---------- | ------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envList` |
| Type       | `list` of `strings`                               |
| Required   | ❌                                                |
| Helm `tpl` | ❌                                                |
| Default    | `[]`                                              |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envList: []
```

---

### `envList.name`

Define the env name

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envList[].name` |
| Type       | `string`                                                 |
| Required   | ✅                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `""`                                                     |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envList:
            - name: ENV_NAME
```

---

### `envList.value`

Define the env value

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.envList[].value` |
| Type       | `string`                                                  |
| Required   | ❌                                                        |
| Helm `tpl` | ✅                                                        |
| Default    | `""`                                                      |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          envList:
            - name: ENV_NAME
              value: ENV_VALUE
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
          envList:
            - name: ENV_NAME1
              value: ENV_VALUE
            - name: ENV_NAME2
              value: "{{ .Values.some.path }}"
            - name: ENV_NAME3
              value: ""
```
