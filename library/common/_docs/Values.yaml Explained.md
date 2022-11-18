# Values.yaml Explained

## global

<details>
<summary>Show / Hide</summary>
Available options:

```yaml
global:
  nameOverride: ""
  annotations: {}
  labels: {}
```

### nameOverride

<details>
<summary>Show / Hide</summary>

Sets an override for the suffix of the full name.
(Applies to current chart and all sub-charts)

- Type: `string`
- Default: `""`
- Helm template: ❌

Examples: Values.yaml

```yaml
global:
  nameOverride: something
```

Appends `something` to:

- Deployment
  - metadata.name
  - spec.template.spec.containers[0].name

Sets `something` to:

- Deployment
  - metadata.app
  - metadata.app.kubernetes.io/name
  - spec.selector.matchLabels.app
  - spec.selector.matchLabels.app.kubernetes.io/name
  - spec.template.metadata.annotations.app
  - spec.template.metadata.annotations.app
  - spec.template.metadata.labels.app.kubernetes.io/name
  - spec.template.metadata.labels.app.kubernetes.io/name

</details>

### annotations

<details>
<summary>Show / Hide</summary>

Sets additional global annotations.

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Examples: Values.yaml

```yaml
global:
  annotations:
    key1: value
    key2: "{{ .Values.some.key }}"
```

Sets all `key: value` pairs to:

- Deployment
  - metadata.annotations

</details>

### labels

<details>
<summary>Show / Hide</summary>

Set additional global labels. Helm templates can be used.

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Examples:

Values.yaml

```yaml
global:
  labels:
    key1: value
    key2: "{{ .Values.some.key }}"
```

Sets all `key: value` pairs to:

- Deployment
  - metadata.labels

</details>
</details> <!-- End of global -->

## nameOverride

Sets an override for the suffix of the full name.
(Applies to current chart only)

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm template: ❌

Examples: Values.yaml

```yaml
nameOverride: something
```

Appends `something` to:

- Deployment
  - metadata.name
  - spec.template.spec.containers[0].name

Sets `something` to:

- Deployment
  - metadata.app
  - metadata.app.kubernetes.io/name
  - spec.selector.matchLabels.app
  - spec.selector.matchLabels.app.kubernetes.io/name
  - spec.template.metadata.annotations.app
  - spec.template.metadata.annotations.app
  - spec.template.metadata.labels.app.kubernetes.io/name
  - spec.template.metadata.labels.app.kubernetes.io/name

</details>

## podAnnotations

Set annotations on the pod.

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Examples: Values.yaml

```yaml
podAnnotations:
  key1: value
  key2: "{{ .Values.some.key }}"
```

Sets all `key: value` pairs to:

- Deployment
  - spec.template.metadata.annotations

</details>

## podLabels

Set labels on the pod.

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Examples: Values.yaml

```yaml
podLabels:
  key1: value
  key2: "{{ .Values.some.key }}"
```

Sets all `key: value` pairs to:

- Deployment
  - spec.template.metadata.labels

</details>

## command

Override the command(s) for the main container

<details>
<summary>Show / Hide</summary>

- Type: `string` or `list`
- Default: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
command: entrypoint.sh

command: "{{ .Values.some.key }}"

command:
  - /bin/sh
  - -c
  - |
    echo "something"

command:
  - "{{ .Values.shell.option }}"
  - -c
  - |
    echo {{ .Values.some.key | quote }}
```

Coverts command to a list and sets it to:

- Deployment
  - spec.template.spec.containers[0].command

</details>

## args

Override the args for the main container

<details>
<summary>Show / Hide</summary>

- Type: `string` or `list`
- Default: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
args: worker

args: "{{ .Values.some.key }}"

args:
  - --port
  - 8000

args:
  - --port
  - "{{ .Values.some.key }}"
```

Coverts args to a list and sets it to:

- Deployment
  - spec.template.spec.containers[0].args

</details>

## extraArgs

Appends args to the `args` for the main container.
If no `args` are defined, `extraArgs` will still be set.
Mainly built for the SCALE GUI

<details>
<summary>Show / Hide</summary>

- Type: `string` or `list`
- Default: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
extraArgs: something

extraArgs: "{{ .Values.some.key }}"

extraArgs:
  - --photosPath
  - /something

extraArgs:
  - --photosPath
  - "{{ .Values.some.key }}"
```

Coverts extraArgs to a list and appends it to:

- Deployment
  - spec.template.spec.containers[0].args

</details>

## tty

Specifies whether the main container in a pod runs with `TTY` enabled.

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#debugging)

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
tty: true

tty: false
```

Sets tty to:

- Deployment
  - spec.template.spec.containers[0].tty

</details>

## stdin

Specifies whether the main container in a pod runs with `stdin` enabled.

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#debugging)

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
stdin: true

stdin: false
```

Sets stdin to:

- Deployment
  - spec.template.spec.containers[0].stdin

</details>

## podSecurityContext

Configure the Security Context for the Pod

<details>
<summary>Show / Hide</summary>

Available options:

```yaml
podSecurityContext:
  runAsUser: 568
  runAsGroup: 568
  fsGroup: 568
  supplementalGroups: []
  fsGroupChangePolicy: OnRootMismatch
```

</details> <!-- End of podSecurityContext -->

## securityContext

Configure the Security Context for the main container

<details>
<summary>Show / Hide</summary>

Available options:

```yaml
securityContext:
  privileged: false
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  runAsNonRoot: true
  capabilities:
    add: []
    drop: []
```

### privileged

Specifies privileged status on securityContext for the main container

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1)

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
securityContext:
  privileged: false

securityContext:
  privileged: true
```

Sets privileged on securityContext to:

- Deployment
  - spec.template.spec.containers[0].securityContext.privileged

</details>

### readOnlyRootFilesystem

Specifies readOnlyRootFilesystem status on securityContext for the main container

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1)

- Type: `boolean`
- Default: `true`
- Helm Template: ❌

Examples: Values.yaml

```yaml
securityContext:
  readOnlyRootFilesystem: false

securityContext:
  readOnlyRootFilesystem: true
```

Sets readOnlyRootFilesystem on securityContext to:

- Deployment
  - spec.template.spec.containers[0].securityContext.readOnlyRootFilesystem

</details>

### allowPrivilegeEscalation

Specifies allowPrivilegeEscalation status on securityContext for the main container

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1)

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
securityContext:
  allowPrivilegeEscalation: false

securityContext:
  allowPrivilegeEscalation: true
```

Sets allowPrivilegeEscalation on securityContext to:

- Deployment
  - spec.template.spec.containers[0].securityContext.allowPrivilegeEscalation

</details>

### runAsNonRoot

Specifies runAsNonRoot status on securityContext for the main container

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1)

- Type: `boolean`
- Default: `true`
- Helm Template: ❌

Examples: Values.yaml

```yaml
securityContext:
  runAsNonRoot: false

securityContext:
  runAsNonRoot: true
```

Sets runAsNonRoot on securityContext to:

- Deployment
  - spec.template.spec.containers[0].securityContext.runAsNonRoot

</details>

### capabilities

Specifies capabilities to add or drop on securityContext for the main container

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1)

- Type: `boolean`
- Default:
  - add: `[]`
  - drop: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
  capabilities:
    add:
      - SYS_ADMIN
      - "{{ .Values.some.key }}"
    drop:
      - NET_RAW
      - "{{ .Values.some.key }}"
```

Sets capabilities to add or drop on securityContext to:

- Deployment
  - spec.template.spec.containers[0].securityContext.capabilities.add
  - spec.template.spec.containers[0].securityContext.capabilities.drop

</details>

</details> <!-- End of securityContext -->

## lifecycle

Configure the lifecycle for the main container.

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)

- Type: `dict`
- Default: `{}`
- Helm Template: ✅

Examples: Values.yaml

```yaml
lifecycle:
  postStart:
    command:
      - command1
      - "{{ .Values.some.key }}"
  preStop:
    command:
      - command1
      - "{{ .Values.some.key }}"

  postStart:
    command: some_command
  preStop:
    command: some_command
```

Sets lifecycle to:

- Deployment
  - spec.template.spec.containers[0].lifecycle.preStop
  - spec.template.spec.containers[0].lifecycle.postStart

</details>

## termination

Configure the termination for the main container.

<details>
<summary>Show / Hide</summary>
Available options:

```yaml
termination:
  messagePath: ""
  messagePolicy: ""
  gracePeriodSeconds: 10
```

### messagePath

Configure the path at which the file to which the main container's
termination message will be written

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)

- Type: `string`
- Default: `""`
- Helm Template: ✅

Examples: Values.yaml

```yaml
termination:
  messagePath: /some/path
```

Sets messagePath to:

- Deployment
  - spec.template.spec.containers[0].terminationMessagePath

</details>

### messagePolicy

Indicate how the main container's termination message should be populated.

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle-1)

- Type: `string`
- Default: `""`
- Helm Template: ✅

Valid options:

- File
- FallbackToLogsOnError

Examples: Values.yaml

```yaml
termination:
  messagePolicy: File
```

Sets messagePolicy to:

- Deployment
  - spec.template.spec.containers[0].terminationMessagePolicy

</details>

### gracePeriodSeconds

Duration in seconds the pod needs to terminate gracefully

<details>
<summary>Show / Hide</summary>

[Kubernetes docs](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#lifecycle)

- Type: `int`
- Default: `10`
- Helm Template: ❌

Examples: Values.yaml

```yaml
termination:
  gracePeriodSeconds: 10
```

Sets gracePeriodSeconds to:

- Deployment
  - TODO:

</details>
</details> <!-- End of termination -->

## nvidiaCaps

Specifies what NVIDIA capabilities will be set.

<details>
<summary>Show / Hide</summary>

- Type: `list`
- Default: `["all"]`
- Helm Template: ❌

Examples: Values.yaml

```yaml
nvidiaCaps:
  - all

nvidiaCaps:
  - compute
  - utility
```

Converts the list to a `,` separated string and sets it to:

- Deployment
  - spec.template.spec.containers[0].env[NVIDIA_DRIVER_CAPABILITIES]

</details>

## injectFixedEnvs

Specifies whether to inject some predefined fixed envs.

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `true`
- Helm Template: ❌

Fixed envs injected:

- `TZ`
  - Equal to `.Values.TZ`
- `UMASK`
  - Equal to `.Values.security.UMASK`
- `UMASK_SET`
  - Equal to `.Values.security.UMASK`
- `NVIDIA_VISIBLE_DEVICES`
  - Set to `void`
  - (Only if there are **no** `.Values.scaleGPU` set)
- `NVIDIA_DRIVER_CAPABILITIES`
  - Equal to `.Values.nvidiaCaps`
  - (Only if there **are** `.Values.scaleGPU` set)
- `PUID`
  - Equal to `.Values.security.PUID`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `USER_ID`
  - Equal to `.Values.security.PUID`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `UID`
  - Equal to `.Values.security.PUID`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `PGID`
  - Equal to `.Values.podSecurityContext.fsGroup`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `GROUP_ID`
  - Equal to `.Values.podSecurityContext.fsGroup`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `GID`
  - Equal to `.Values.podSecurityContext.fsGroup`
  - (Only if runs as `root` (user or group) and `PUID` is set)
- `S6_READ_ONLY_ROOT`
  - Set to `1`
  - (Only if runs as `root` (user) or `readOnlyRootFilesystem` is true)

Examples: Values.yaml

```yaml
injectFixedEnvs: true

injectFixedEnvs: false
```

Converts the list to a `,` separated string and sets it to:

- Deployment
  - spec.template.spec.containers[0].env[NVIDIA_DRIVER_CAPABILITIES]

</details>

## TZ

Sets main container's timezone

<details>
<summary>Show / Hide</summary>

Used mainly in Scale GUI

- Type: `string`
- Default: `UTC`
- Helm Template: ✅

Examples: Values.yaml

```yaml
TZ: UTC

TZ: "{{ .Values.some_key }}"
```

- Deployment
  - spec.template.spec.containers[0].env[TZ]

</details>

## security

Sets some security related environment variables

<details>
<summary>Show / Hide</summary>

Available options:

```yaml
security:
  PUID: 568
  UMASK: 002
```

### PUID

Sets PUID for the main container

<details>
<summary>Show / Hide</summary>

- Type: `int`
- Default: `568`
- Helm Template: ✅

Examples: Values.yaml

```yaml
security:
  PUID: 568

security:
  PUID: "{{ .Values.some_key }}"
```

- Deployment
  - spec.template.spec.containers[0].env[PUID]
  - spec.template.spec.containers[0].env[USER_ID]
  - spec.template.spec.containers[0].env[UID]

</details>

### UMASK

Sets UMASK for the main container

<details>
<summary>Show / Hide</summary>

- Type: `int`
- Default: `002`
- Helm Template: ✅

Examples: Values.yaml

```yaml
security:
  UMASK: 002

security:
  UMASK: "{{ .Values.some_key }}"
```

- Deployment
  - spec.template.spec.containers[0].env[UMASK]
  - spec.template.spec.containers[0].env[UMASK_SET]

</details>

</details> <!-- End of security -->
