# Environment Variable

## Key: env

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - key: ❌
  - value: ✅
  - secretKeyRef.name: ✅
  - secretKeyRef.key: ✅
  - configMapKeyRef.name: ✅
  - configMapKeyRef.key: ✅

Can be defined in:

- `.Values`.env
- `.Values.additionalContainers.[container-name]`.env
- `.Values.initContainers.[container-name]`.env
- `.Values.installContainers.[container-name]`.env
- `.Values.upgradeContainers.[container-name]`.env
- `.Values.systemContainers.[container-name]`.env
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.env

---

Contains environment variables and can be defined in few different formats

Examples:

```yaml
env:
# Key/Value pairs
  ADMIN_PASS: password
# Key/Value pairs (tpl)
  ADMIN_PASS: "{{ .Values.app.password }}"

# ConfigMap Key Reference
  ADMIN_PASS:
    configMapKeyRef:
      name: configMap_name
      key: configMap_key
# ConfigMap Key Reference (tpl)
  ADMIN_PASS:
    configMapKeyRef:
      name: "{{ .Values.config.name }}"
      key: "{{ .Values.config.key }}"

# Secret Key Reference
  ADMIN_PASS:
    secretKeyRef:
      optional: true / false
      name: secret_name
      key: secret_key
# Secret Key Reference (tpl)
  ADMIN_PASS:
    secretKeyRef:
      optional: true / false
      name: "{{ .Values.config.name }}"
      key: "{{ .Values.config.key }}"
```

---
---

## Key: envList

Info:

- Type: `list`
- Default: `[]`
- Helm Template:
  - name: ✅
  - value: ✅

Can be defined in:

- `.Values`.envList
- `.Values.additionalContainers.[container-name]`.envList
- `.Values.initContainers.[container-name]`.envList
- `.Values.installContainers.[container-name]`.envList
- `.Values.upgradeContainers.[container-name]`.envList
- `.Values.systemContainers.[container-name]`.envList
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.envList

---

Mainly designed to be used in the SCALE GUI.
So users can pass additional environment variables.

Examples:

```yaml
envList:
  # List entry
  - name: ADMIN_PASS
    value: password
  # List entry (tpl)
  - name: "{{ .Values.envName }}"
    value: "{{ .Values.password }}"
```

---
---

## Key: envFrom

Info:

- Type: `list`
- Default: `[]`
- Helm Template:
  - name: ✅
  - value: ✅

Can be defined in:

- `.Values`.envFrom
- `.Values.additionalContainers.[container-name]`.envFrom
- `.Values.initContainers.[container-name]`.envFrom
- `.Values.installContainers.[container-name]`.envFrom
- `.Values.upgradeContainers.[container-name]`.envFrom
- `.Values.systemContainers.[container-name]`.envFrom
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.envFrom

---

Used to load multiple environment variables
from a `configMap` or a `secret`. With a single list entry,
it will load all keys as environment variables
defined in the specified object.

Examples:

```yaml
envFrom:
  # List entry
  - secretRef:
      name: secretName
  - configMapRef:
      name: configMapName
  # List entry (tpl)
  - secretRef:
      name: "{{ .Values.secretName }}"
  - configMapRef:
      name: "{{ .Values.configMapName }}"
```

---
---

## Key: TZ

Info:

- Type: `string`
- Default: `UTC`
- Helm Template: ❌

Can be defined in:

- `.Values`.TZ
- `.Values.additionalContainers.[container-name]`.TZ
- `.Values.initContainers.[container-name]`.TZ
- `.Values.installContainers.[container-name]`.TZ
- `.Values.upgradeContainers.[container-name]`.TZ
- `.Values.systemContainers.[container-name]`.TZ
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.TZ

---

Usually defined from the SCALE's GUI dropdown.
It is also injected as environment variable into the container.
It can also be used to pass timezone to other environment variables
an app would use.

> Only applied used when `injectFixedEnvs` is set to `true`.

Example:

```yaml
TZ: UTC

env:
  PHP_TZ: "{{ .Values.TZ }}"
```

---
---

## Key: security

Info:

- Type: `dict`
- Default:

  ```yaml
  security:
    PUID: 568
    UMASK: 002
  ```

- Helm Template: ❌

Can be defined in:

- `.Values`.security
- `.Values.additionalContainers.[container-name]`.security
- `.Values.initContainers.[container-name]`.security
- `.Values.installContainers.[container-name]`.security
- `.Values.upgradeContainers.[container-name]`.security
- `.Values.systemContainers.[container-name]`.security
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.security

---

Used to define a default `PUID` and `UMASK` to containers.

> If not defined it will use the `.Values.global.defaults.security`
> Only applied used when `injectFixedEnvs` is set to `true`.

Examples:

```yaml
security:
  PUID: 0
  UMASK: 002
```

---
---

## Key: nvidiaCaps

Info:

- Type: `list`
- Default:

  ```yaml
  nvidiaCaps:
    - all
  ```

- Helm Template: ❌

Can be defined in:

- `.Values`.nvidiaCaps
- `.Values.additionalContainers.[container-name]`.nvidiaCaps
- `.Values.initContainers.[container-name]`.nvidiaCaps
- `.Values.installContainers.[container-name]`.nvidiaCaps
- `.Values.upgradeContainers.[container-name]`.nvidiaCaps
- `.Values.systemContainers.[container-name]`.nvidiaCaps
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.nvidiaCaps

---

Defines the value of nvidia capabilities variable that will be injected in the container.

> If it's empty it will use the `.Values.global.defaults.nvidiaCaps`
> Only applied when a GPU is passed through

Example:

```yaml
nvidiaCaps:
  - compute
  - utility
```

---
---

## Key: injectFixedEnvs

Info:

- Type: `boolean`
- Default: `true`
- Helm Template: ❌

Can be defined in:

- `.Values`.injectFixedEnvs
- `.Values.additionalContainers.[container-name]`.injectFixedEnvs
- `.Values.initContainers.[container-name]`.injectFixedEnvs
- `.Values.installContainers.[container-name]`.injectFixedEnvs
- `.Values.upgradeContainers.[container-name]`.injectFixedEnvs
- `.Values.systemContainers.[container-name]`.injectFixedEnvs
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.injectFixedEnvs

If **enabled**, injects environment variables to the container.
> If not defined, it will use the `.Values.global.defaults.injectFixedEnvs`

`TZ`:
> Applied always. No conditions.

`UMASK`, `UMASK_SET`:
> Applied always. No conditions.

`NVIDIA_VISIBLE_DEVICES`:
> Applied and set to `void`, if container has no GPU pass through.

`NVIDIA_DRIVER_CAPABILITIES`:
> Applied when a GPU is passed through to the container.
> Value is defined based on the `nvidiaCaps` key

`PGID`, `GROUP_ID`, `GID`:
> Applied when container runs as `root` user or `root` group.
> `PGID`, `GROUP_ID`, `GID` is always equal to `fsGroup`.

`PUID`, `USER_ID`, `UID`:
> Applied when container runs as `root` user or `root` group.

`S6_READ_ONLY_ROOT`:
> Applied when container runs as `root` user or `root` group
> or has `readOnlyRootFilesystem` set to true

Example:

```yaml
injectFixedEnvs: true
```

Kubernetes Documentation:

- [Environment Variables](https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/#define-an-environment-variable-for-a-container)
