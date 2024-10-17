---
title: Probes
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/probes#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`

---

## `probes`

Define probes for the container

|            |                                                  |
| ---------- | ------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.probes` |
| Type       | `map`                                            |
| Required   | ✅                                               |
| Helm `tpl` | ❌                                               |
| Default    | `{}`                                             |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes: {}
```

### `probes.liveness`

Define the liveness probe

|            |                                                           |
| ---------- | --------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.liveness` |
| Type       | `map`                                                     |
| Required   | ✅                                                        |
| Helm `tpl` | ❌                                                        |
| Default    | `{}`                                                      |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness: {}
```

---

### `probes.readiness`

Define the readiness probe

|            |                                                            |
| ---------- | ---------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.readiness` |
| Type       | `map`                                                      |
| Required   | ✅                                                         |
| Helm `tpl` | ❌                                                         |
| Default    | `{}`                                                       |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            readiness: {}
```

---

### `probes.startup`

Define the startup probe

|            |                                                          |
| ---------- | -------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.startup` |
| Type       | `map`                                                    |
| Required   | ✅                                                       |
| Helm `tpl` | ❌                                                       |
| Default    | `{}`                                                     |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            startup: {}
```

---

#### `probes.$probe.enabled`

Enable or disable the probe

|            |                                                                 |
| ---------- | --------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.enabled` |
| Type       | `bool`                                                          |
| Required   | ✅                                                              |
| Helm `tpl` | ❌                                                              |
| Default    | `true`                                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              enabled: true
```

---

#### `probes.$probe.type`

Define probe type

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.type` |
| Type       | `string`                                                     |
| Required   | ❌                                                           |
| Helm `tpl` | ✅                                                           |
| Default    | `http`                                                       |

Valid Values:

- `exec`
- `http`
- `https`
- `tcp`
- `grpc`

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              type: http
```

---

#### `probes.$probe.command`

Define command(s)

:::note

- Only applies when `type: exec`
- It is **required**

:::

See [Command](/common/container/command#command) for more information.

---

#### `probes.$probe.port`

Define the port

:::note

- Only applies when `type: grpc/tcp/http/https`

:::

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.port` |
| Type       | `int`                                                        |
| Required   | ✅                                                           |
| Helm `tpl` | ✅                                                           |
| Default    | unset                                                        |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              port: 8080
```

---

#### `probes.$probe.path`

Define the path

:::note

- Only applies when `type: http/https`

:::

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.path` |
| Type       | `string`                                                     |
| Required   | ❌                                                           |
| Helm `tpl` | ✅                                                           |
| Default    | `/`                                                          |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              path: /healthz
```

---

#### `probes.$probe.httpHeaders`

Define the httpHeaders

:::note

- Only applies when `type: http/https`

:::

|            |                                                                     |
| ---------- | ------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.httpHeaders` |
| Type       | `map`                                                               |
| Required   | ❌                                                                  |
| Helm `tpl` | ✅ (On value only)                                                  |
| Default    | `{}`                                                                |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              httpHeaders:
                key1: value1
                key2: value2
```

---

#### `probes.$probe.spec`

Define the probe spec

|            |                                                              |
| ---------- | ------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec` |
| Type       | `map`                                                        |
| Required   | ❌                                                           |
| Helm `tpl` | ❌                                                           |
| Default    | `{}`                                                         |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              spec: {}
```

---

##### `probes.$probe.spec.initialDelaySeconds`

Define the initialDelaySeconds in seconds

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec.initialDelaySeconds`   |
| Type       | `int`                                                                              |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See defaults for each probe [here](/common/fallbackdefaults#probetimeouts) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              spec:
                initialDelaySeconds: 10
```

---

##### `probes.$probe.spec.periodSeconds`

Define the periodSeconds in seconds

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec.periodSeconds`         |
| Type       | `int`                                                                              |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See defaults for each probe [here](/common/fallbackdefaults#probetimeouts) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              spec:
                periodSeconds: 10
```

---

##### `probes.$probe.spec.timeoutSeconds`

Define the timeoutSeconds in seconds

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec.timeoutSeconds`        |
| Type       | `int`                                                                              |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See defaults for each probe [here](/common/fallbackdefaults#probetimeouts) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              spec:
                timeoutSeconds: 10
```

---

##### `probes.$probe.spec.failureThreshold`

Define the failureThreshold in seconds

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec.failureThreshold`      |
| Type       | `int`                                                                              |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See defaults for each probe [here](/common/fallbackdefaults#probetimeouts) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            liveness:
              spec:
                failureThreshold: 10
```

---

##### `probes.$probe.spec.successThreshold`

Define the successThreshold in seconds. `liveness` and `startup` must always be 1

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.probes.$probe.spec.successThreshold`      |
| Type       | `int`                                                                              |
| Required   | ❌                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See defaults for each probe [here](/common/fallbackdefaults#probetimeouts) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          probes:
            readiness:
              spec:
                successThreshold: 10
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
          probes:
            liveness:
              enabled: true
              type: https
              port: 8080
              path: /healthz
              httpHeaders:
                key1: value1
                key2: value2
              spec:
                initialDelaySeconds: 10
                periodSeconds: 10
                timeoutSeconds: 10
                failureThreshold: 10
                successThreshold: 10
            readiness:
              enabled: true
              type: tcp
              port: 8080
              spec:
                initialDelaySeconds: 10
                periodSeconds: 10
                timeoutSeconds: 10
                failureThreshold: 10
                successThreshold: 10
            startup:
              enabled: true
              type: exec
              command:
                - command1
                - command2
              spec:
                initialDelaySeconds: 10
                periodSeconds: 10
                timeoutSeconds: 10
                failureThreshold: 10
                successThreshold: 10
```
