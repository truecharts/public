---
title: Security Context
---

:::note

- Examples under each key are only to be used as a placement guide
- See the [Full Examples](/common/container/securitycontext#full-examples) section for complete examples.

:::

## Appears in

- `.Values.workload.$name.podSpec.containers.$name`
- `.Values.workload.$name.podSpec.initContainers.$name`

---

## `securityContext`

Define securityContext for the container

|            |                                                                      |
| ---------- | -------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext`            |
| Type       | `map`                                                                |
| Required   | ✅                                                                   |
| Helm `tpl` | ❌                                                                   |
| Default    | See [here](/common/securitycontext#securitycontextcontainer) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext: {}
```

---

### `securityContext.runAsUser`

Define the runAsUser for the container

|            |                                                                               |
| ---------- | ----------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.runAsUser`           |
| Type       | `int`                                                                         |
| Required   | ✅                                                                            |
| Helm `tpl` | ❌                                                                            |
| Default    | See [here](/common/securitycontext#securitycontextcontainerrunasuser) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            runAsUser: 568
```

---

### `securityContext.runAsGroup`

Define the runAsGroup for the container

|            |                                                                                |
| ---------- | ------------------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.runAsGroup`           |
| Type       | `int`                                                                          |
| Required   | ✅                                                                             |
| Helm `tpl` | ❌                                                                             |
| Default    | See [here](/common/securitycontext#securitycontextcontainerrunasgroup) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            runAsGroup: 568
```

---

### `securityContext.readOnlyRootFilesystem`

Define the readOnlyRootFilesystem for the container

|            |                                                                                            |
| ---------- | ------------------------------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.readOnlyRootFilesystem`           |
| Type       | `bool`                                                                                     |
| Required   | ✅                                                                                         |
| Helm `tpl` | ❌                                                                                         |
| Default    | See [here](/common/securitycontext#securitycontextcontainerreadonlyrootfilesystem) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            readOnlyRootFilesystem: true
```

---

### `securityContext.allowPrivilegeEscalation`

Define the allowPrivilegeEscalation for the container

|            |                                                                                              |
| ---------- | -------------------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.allowPrivilegeEscalation`           |
| Type       | `bool`                                                                                       |
| Required   | ✅                                                                                           |
| Helm `tpl` | ❌                                                                                           |
| Default    | See [here](/common/securitycontext#securitycontextcontainerallowprivilegeescalation) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            allowPrivilegeEscalation: false
```

---

### `securityContext.privileged`

Define the privileged for the container

|            |                                                                                |
| ---------- | ------------------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.privileged`           |
| Type       | `bool`                                                                         |
| Required   | ✅                                                                             |
| Helm `tpl` | ❌                                                                             |
| Default    | See [here](/common/securitycontext#securitycontextcontainerprivileged) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            privileged: false
```

---

### `securityContext.runAsNonRoot`

Define the runAsNonRoot for the container

|            |                                                                                  |
| ---------- | -------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.runAsNonRoot`           |
| Type       | `bool`                                                                           |
| Required   | ✅                                                                               |
| Helm `tpl` | ❌                                                                               |
| Default    | See [here](/common/securitycontext#securitycontextcontainerrunasnonroot) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            runAsNonRoot: true
```

---

### `securityContext.capabilities`

Define the capabilities for the container

:::note

If at least one capability is defined in either [`add`](/common/container/securitycontext/#securitycontextcapabilitiesadd) or [`drop`](/common/container/securitycontext/#securitycontextcapabilitiesdrop)
on container level, it will **NOT** get merged with the value(s) from the `.Values.securityContext.container.capabilities.[add/drop]`.
But it will override them.

:::

:::tip

When setting capabilities for containers, remember to **NOT** include `CAP_` prefix.
For example, `CAP_NET_ADMIN` should be `NET_ADMIN`. This is not specific to this chart,
but a general Kubernetes thing.

:::

|            |                                                                                  |
| ---------- | -------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.capabilities`           |
| Type       | `map`                                                                            |
| Required   | ✅                                                                               |
| Helm `tpl` | ❌                                                                               |
| Default    | See [here](/common/securitycontext#securitycontextcontainercapabilities) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            capabilities: {}
```

---

#### `securityContext.capabilities.add`

Define the capabilities.add for the container

|            |                                                                                     |
| ---------- | ----------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.capabilities.add`          |
| Type       | `list` of `string`                                                                  |
| Required   | ✅                                                                                  |
| Helm `tpl` | ❌                                                                                  |
| Default    | See [here](/common/securitycontext#securitycontextcontainercapabilitiesadd) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            capabilities:
              add: []
```

---

#### `securityContext.capabilities.drop`

Define the capabilities.drop for the container

|            |                                                                                      |
| ---------- | ------------------------------------------------------------------------------------ |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.capabilities.drop`          |
| Type       | `list` of `string`                                                                   |
| Required   | ✅                                                                                   |
| Helm `tpl` | ❌                                                                                   |
| Default    | See [here](/common/securitycontext#securitycontextcontainercapabilitiesdrop) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            capabilities:
              drop: []
```

---

### `securityContext.seccompProfile`

Define the seccompProfile for the container

|            |                                                                                    |
| ---------- | ---------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.seccompProfile`           |
| Type       | `map`                                                                              |
| Required   | ✅                                                                                 |
| Helm `tpl` | ❌                                                                                 |
| Default    | See [here](/common/securitycontext#securitycontextcontainerseccompprofile) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            seccompProfile: {}
```

---

#### `securityContext.seccompProfile.type`

Define the seccompProfile.type for the container

|            |                                                                                        |
| ---------- | -------------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.seccompProfile.type`          |
| Type       | `string`                                                                               |
| Required   | ✅                                                                                     |
| Helm `tpl` | ❌                                                                                     |
| Default    | See [here](/common/securitycontext#securitycontextcontainerseccompprofiletype) |

Valid Values:

- `RuntimeDefault`
- `Localhost`
- `Unconfined`

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            seccompProfile:
              type: Localhost
```

---

#### `securityContext.seccompProfile.profile`

Define the seccompProfile.profile for the container

:::note

Only **required** when `securityContext.seccompProfile.type` is `Localhost`.

:::

|            |                                                                                           |
| ---------- | ----------------------------------------------------------------------------------------- |
| Key        | `workload.$name.podSpec.containers.$name.securityContext.seccompProfile.profile`          |
| Type       | `string`                                                                                  |
| Required   | ✅                                                                                        |
| Helm `tpl` | ❌                                                                                        |
| Default    | See [here](/common/securitycontext#securitycontextcontainerseccompprofileprofile) |

Example

```yaml
workload:
  workload-name:
    podSpec:
      containers:
        container-name:
          securityContext:
            seccompProfile:
              type: Localhost
              profile: path/to/profile.json
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
          securityContext:
            runAsNonRoot: true
            runAsUser: 568
            runAsGroup: 568
            readOnlyRootFilesystem: true
            allowPrivilegeEscalation: false
            privileged: false
            seccompProfile:
              type: Localhost
              profile: path/to/profile.json
            capabilities:
              add: []
              drop:
                - ALL
```
