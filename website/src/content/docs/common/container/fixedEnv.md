---
title: FixedEnv
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/fixedenv#full-examples) section for complete examples.

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

## `fixedEnv`

Override fixedEnv for the container

:::note

By default it will set the following environment variables:

- `TZ`: [Default TZ](/common#tz) or [fixedEnv.TZ](/common/container/fixedenv#fixedenvtz)
- `UMASK`: [Default UMASK](/common/securitycontext#securitycontextcontainerumask) or [fixedEnv.UMASK](/common/container/fixedenv#fixedenvumask)
- `UMASK_SET`: [Default UMASK](/common/securitycontext#securitycontextcontainerumask) or [fixedEnv.UMASK](/common/container/fixedenv#fixedenvumask)
- `S6_READ_ONLY_ROOT`: `1`
  - Only when [`readOnlyRootFilesystem`](/common/container/securitycontext#securitycontextreadonlyrootfilesystem) or [`runAsNonRoot`](/common/container/securitycontext#securitycontextrunasnonroot) is `true`
- `PUID`, `USER_ID`, `UID`: [Default PUID](/common/securitycontext#securitycontextcontainerpuid) or [fixedEnv.PUID](/common/container/fixedenv#fixedenvpuid)
  - Only when [`runAsUser`](/common/securitycontext#securitycontextcontainerrunasuser) or [`runAsGroup`](/common/securitycontext#securitycontextcontainerrunasgroup) is `0`
- `PGID`, `GROUP_ID`, `GID`: Same as [`fsGroup`](/common/securitycontext#securitycontextpodfsgroup)
  - Only when [`runAsUser`](/common/securitycontext#securitycontextcontainerrunasuser) or [`runAsGroup`](/common/securitycontext#securitycontextcontainerrunasgroup) is `0`
- `NVIDIA_DRIVER_CAPABILITIES`: [Default NVIDIA_CAPS](/common/containeroptions#nvidia_caps) or [fixedEnv.NVIDIA_CAPS](/common/container/fixedenv#fixedenvnvidia_caps)
  - Only when `nvidia.com/gpu` is set to `> 0` under [`resources`](/common/container/resources)

:::

|            |                                                    |
| ---------- | -------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.fixedEnv` |
| Type       | `map`                                              |
| Required   | ❌                                                 |
| Helm `tpl` | ❌                                                 |
| Default    | `{}`                                               |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          fixedEnv: {}
```

---

### `fixedEnv.TZ`

Override the timezone for the container

|            |                                                       |
| ---------- | ----------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.fixedEnv.TZ` |
| Type       | `string`                                              |
| Required   | ❌                                                    |
| Helm `tpl` | ❌                                                    |
| Default    | See [here](/common#tz)                        |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          fixedEnv:
            TZ: "America/New_York"
```

---

### `fixedEnv.UMASK`

Override the umask for the container

|            |                                                                            |
| ---------- | -------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.fixedEnv.UMASK`                   |
| Type       | `string`                                                                   |
| Required   | ❌                                                                         |
| Helm `tpl` | ❌                                                                         |
| Default    | See [here](/common/securitycontext/#securitycontextcontainerumask) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          fixedEnv:
            UMASK: "003"
```

---

### `fixedEnv.PUID`

Override the PUID for the container

|            |                                                                           |
| ---------- | ------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.fixedEnv.PUID`                   |
| Type       | `string`                                                                  |
| Required   | ❌                                                                        |
| Helm `tpl` | ❌                                                                        |
| Default    | See [here](/common/securitycontext/#securitycontextcontainerpuid) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          fixedEnv:
            PUID: "0"
```

---

### `fixedEnv.NVIDIA_CAPS`

Override the NVIDIA_CAPS for the container

|            |                                                                |
| ---------- | -------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.fixedEnv.NVIDIA_CAPS` |
| Type       | `list`                                                         |
| Required   | ❌                                                             |
| Helm `tpl` | ❌                                                             |
| Default    | See [here](/common/containeroptions#nvidia_caps)       |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          fixedEnv:
            NVIDIA_CAPS:
              - compute
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
          fixedEnv:
            TZ: "America/New_York"
            NVIDIA_CAPS:
              - compute
            UMASK: "003"
            PUID: "0"
```
