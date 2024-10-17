---
title: Lifecycle
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/lifecycle#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`

---

## `lifecycle`

Define lifecycle for the container

|            |                                                     |
| ---------- | --------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle` |
| Type       | `map`                                               |
| Required   | ❌                                                  |
| Helm `tpl` | ❌                                                  |
| Default    | `{}`                                                |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle: {}
```

---

### `lifecycle.preStop`

Define preStop lifecycle

|            |                                                             |
| ---------- | ----------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.preStop` |
| Type       | `map`                                                       |
| Required   | ❌                                                          |
| Helm `tpl` | ❌                                                          |
| Default    | `{}`                                                        |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            preStop: {}
```

---

### `lifecycle.postStart`

Define preStop lifecycle

|            |                                                               |
| ---------- | ------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.postStart` |
| Type       | `map`                                                         |
| Required   | ❌                                                            |
| Helm `tpl` | ❌                                                            |
| Default    | `{}`                                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            postStart: {}
```

---

#### `lifecycle.$hook.type`

Define hook type

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.$hook.type` |
| Type       | `string`                                                       |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | `""`                                                           |

Valid Values:

- `exec`
- `http`
- `https`

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            preStop:
              type: exec
```

---

#### `lifecycle.$hook.command`

Define command(s)

:::note

- Only applies when `type: exec`
- It is **required**

:::

See [Command](/common/container/command#command) for more information.

---

#### `lifecycle.$hook.port`

Define the port

:::note

- Only applies when `type: http` or `type: https`
- It is **required**

:::

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.$hook.port` |
| Type       | `int`                                                          |
| Required   | ✅                                                             |
| Helm `tpl` | ✅                                                             |
| Default    | `""`                                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            postStart:
              type: http
              port: 8080
```

---

#### `lifecycle.$hook.host`

Define the host

:::note

- Only applies when `type: http` or `type: https`

:::

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.$hook.host` |
| Type       | `string`                                                       |
| Required   | ❌                                                             |
| Helm `tpl` | ✅                                                             |
| Default    | `""`                                                           |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            postStart:
              type: http
              port: 8080
              host: localhost
```

---

#### `lifecycle.$hook.path`

Define the path

:::note

- Only applies when `type: http` or `type: https`

:::

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.$hook.path` |
| Type       | `string`                                                       |
| Required   | ❌                                                             |
| Helm `tpl` | ✅                                                             |
| Default    | `"/"`                                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            postStart:
              type: http
              port: 8080
              host: localhost
              path: /path
```

---

#### `lifecycle.$hook.httpHeaders`

Define the httpHeaders

|            |                                                                       |
| ---------- | --------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.lifecycle.$hook.httpHeaders` |
| Type       | `map`                                                                 |
| Required   | ❌                                                                    |
| Helm `tpl` | ✅ (On value only)                                                    |
| Default    | `{}`                                                                  |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          lifecycle:
            postStart:
              type: http
              port: 8080
              host: localhost
              path: /path
              httpHeaders:
                key: value
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
          lifecycle:
            preStop:
              type: exec
              command:
                - command
            postStart:
              type: http
              port: 8080
              host: localhost
              path: /path
              httpHeaders:
                key: value
```
