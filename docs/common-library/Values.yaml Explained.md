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

Sets it to:

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
- Helm Template: ❌

Examples: Values.yaml

```yaml
security:
  PUID: 568
```

Sets it to:

- Deployment
  - spec.template.spec.containers[0].env[PUID]
  - spec.template.spec.containers[0].env[USER_ID]
  - spec.template.spec.containers[0].env[UID]

</details>

### UMASK

Sets UMASK for the main container

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `"002"`
- Helm Template: ❌

Examples: Values.yaml

```yaml
security:
  UMASK: "002"
```

Sets it to:

- Deployment
  - spec.template.spec.containers[0].env[UMASK]
  - spec.template.spec.containers[0].env[UMASK_SET]

</details>
</details> <!-- End of security -->

## env

Sets env to the main container

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅

Examples: Values.yaml

```yaml
env:
  ENV_VAR: value

env:
  ENV_VAR: "{{ .Values.some.key }}"

env:
  ENV_VAR:
    configMapKeyRef:
      name: configmap-name
      key: confimap-key

env:
  ENV_VAR:
    configMapKeyRef:
      name: "{{ .Values.some.confimap.name }}"
      key: "{{ .Values.some.confimap.key }}"

env:
  ENV_VAR:
    secretKeyRef:
      name: secret-name
      key: secret-key

env:
  ENV_VAR:
    secretKeyRef:
      name: "{{ .Values.some.secret.name }}"
      key: "{{ .Values.some.secret.key }}"

env:
  ENV_VAR:
    secretKeyRef:
      name: secret-name
      key: secret-key
      optional: false

env:
  ENV_VAR:
    secretKeyRef:
      name: "{{ .Values.some.secret.name }}"
      key: "{{ .Values.some.secret.key }}"
      optional: false
```

Sets each key in the dict to:

- Deployment
  - spec.template.spec.containers[0].env[ENV_VAR]

</details>

## envList

Sets env to the main container

<details>
<summary>Show / Hide</summary>

- Type: `list`
- Default: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
envList:
  - name: ENV_VAR
    value: value

envList:
  - name: "{{ .Values.some.name }}"
    value: "{{ .Values.some.value }}"
```

Appends the list to:

- Deployment
  - spec.template.spec.containers[0].env

</details>

## envFrom

Load envs from secret or configMap.

<details>
<summary>Show / Hide</summary>

- Type: `list`
- Default: `[]`
- Helm Template: ✅

Examples: Values.yaml

```yaml
envFrom:
  - configMapRef:
      name: configmap-name

envFrom:
  - configMapRef:
      name: "{{ .Values.some.name }}"

envFrom:
  - secretRef:
      name: secret-name

envFrom:
  - secretRef:
      name: "{{ .Values.some.name }}"
```

Appends the list to:

- Deployment
  - spec.template.spec.containers[0].envFrom

</details>

## persistence

Creates volumes and volumeMounts

<details>
<summary>Show / Hide</summary>

Available options:

```yaml
persistence:
  any_name_here:
    enabled: false
    type: pvc
    nameOverride: ""
    annotations: {}
    labels: {}
    existingClaim: ""
    forceName: ""
    mountPath:  # /config
    readOnly: false
    noMount: false
```

Examples: Values.yaml

```yaml
persistence:
  pvc-example:
    enabled: true
    type: pvc
    mountPath: /config
    size: 1Gi

persistence:
  host-device-example:
    enabled: true
    type: hostPath
    hostPath: /dev
    mountPath: /host/dev

persistence:
  configmap-example:
    enabled: true
    type: configMap
    objectName: configmap-name
    # Either
    mountPath: /config/config.yaml
    subPath: config.yaml
    # or
    mountPath: /config
    items:
      - key: config.yaml
        path: config.yaml

persistence:
  secret-example:
    enabled: true
    type: secret
    objectName: secret-name
    # Either
    mountPath: /config/config.yaml
    subPath: config.yaml
    # or
    mountPath: /config
    items:
      - key: config.yaml
        path: config.yaml

persistence:
  nfs-example:
    enabled: true
    type: nfs
    server: 192.168.1.10
    path: /some-path
    mountPath: /some-mount-path

persistence:
  emptydir-shm-example:
    enabled: true
    type: emptyDir
    mountPath: /dev/shm
    medium: Memory

persistence:
  emptydir-tmp-example:
    enabled: true
    type: emptyDir
    mountPath: /tmp
```

### enabled

Specifies where the volume and volumeMount will be enabled

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    enabled: false

persistence:
  any_name_here:
    enabled: true
```

</details>

### type

Specifies type of the volume

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `pvc`
- Helm Template: ❌

Valid options:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    type: pvc

persistence:
  any_name_here:
    type: emptyDir

persistence:
  any_name_here:
    type: secret

persistence:
  any_name_here:
    type: configMap

persistence:
  any_name_here:
    type: hostPath

persistence:
  any_name_here:
    type: custom
```

</details>

### mountPath

Specifies where the volume will be mounted in the container

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    mountPath: /config
```

</details>

### noMount

Specifies where the volumeMount will be created.

<details>
<summary>Show / Hide</summary>

When set to true, it only creates the volume, without mounting it on the main container

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    noMount: true
```

</details>

### readOnly

Specifies whether the volumeMount will be readOnly.

<details>
<summary>Show / Hide</summary>

When set to true, it mounts the volume to the main container as read only.

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    readOnly: true
```

</details>

### objectName

Specifies the name of the configMap or secret that will be mounted.

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `secret`
- `configMap`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    objectName: "{{ .Value.some.name }}"

persistence:
  any_name_here:
    objectName: some-name
```

</details>

### defaultMode

Specifies the defaultMode the secret will be mounted

<details>
<summary>Show / Hide</summary>

- Type: `int` or `string`
- Default: `0644`
- Helm Template: ✅

Applies to types:

- `secret`
- `configMap`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    defaultMode: "{{ .Value.some.default.mode }}"

persistence:
  any_name_here:
    defaultMode: 0644
```

</details>

### server

Specifies the nfs server address.

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `nfs`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    server: "192.168.1.10"
```

</details>

### path

Specifies path on the nfs server.

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `nfs`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    path: /some-path
```

</details>

### medium

Specifies medium of the emptyDir

<details>
<summary>Show / Hide</summary>

If not set, uses the node's default storage.
If set, sets the storage medium for the emptyDir

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `emptyDir`

Valid options:

- ""
- Memory

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    medium: Memory

persistence:
  any_name_here:
    medium:
```

</details>

### sizeLimit

Specifies sizeLimit of the emptyDir

<details>
<summary>Show / Hide</summary>

Only if the `SizeMemoryBackedVolumes` feature gate is enabled

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `emptyDir`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    sizeLimit: 1Gi
```

</details>

### size

Specifies size of the pvc

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    size: 1Gi
```

</details>

### accessMode

Specifies accessMode of the pvc

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `ReadWriteOnce`
- Helm Template: ❌

Valid options:

- `ReadWriteOnce`
- `ReadOnlyMany`
- `ReadWriteMany`
- `ReadWriteOncePod`

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    accessMode: ReadWriteOnce
```

</details>

### existingClaim

Specifies existingClaim for the PVC

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    existingClaim: some-claim-name
```

</details>

### nameOverride

Sets an override for the suffix of this volume

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    nameOverride: some-name
```

</details>

### forceName

Sets the complete name of this volume

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    forceName: some-name
```

</details>

### annotations

Add annotations to the PVC object

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    annotations:
      key: value
```

</details>

### labels

Add labels to the PVC object

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On values only

Applies to types:

- `pvc`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    labels:
      key: value
```

</details>

### hostPath

Specifies the hostPath of the volume

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ❌

Applies to types:

- `hostPath`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    hostPath: /some-path
```

</details>

### hostPathType

Specifies the hostPathType of the volume

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Valid options:

- `""`
- `DirectoryOrCreate`
- `Directory`
- `FileOrCreate`
- `File`
- `Socket`
- `CharDevice`
- `BlockDevice`

Applies to types:

- `hostPath`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    hostPathType: Directory
```

</details>

### subPath

Specifies the a subPath for the volumeMount

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    subPath: target
```

</details>

### items

Specifies items to be mounted in the volumeMount

<details>
<summary>Show / Hide</summary>

- Type: `list`
- Default: `""`
- Helm Template: ✅

Applies to types:

- `configMap`
- `secret`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    items:
      - key: config.yaml
        path: default.yaml
```

</details>

### setPermissions

Specifies whether an init container will run to chown the volume

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Applies to types:

- `pvc`
- `emptyDir`
- `secret`
- `configMap`
- `hostPath`
- `ix-volumes`
- `custom`

Examples: Values.yaml

```yaml
persistence:
  any_name_here:
    setPermissions: true
```

</details>

</details> <!-- End of persistence -->

## probes

Specifies the probes for the main container

<details>
<summary>Show / Hide</summary>

Available options:

```yaml
probes:
  liveness:
    enabled: true
    custom: false
    type: AUTO
    path: "/"
    command: []
    httpHeaders: {}
    spec:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
  readiness:
    enabled: true
    custom: false
    type: AUTO
    path: "/"
    command: []
    httpHeaders: {}
    spec:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
  startup:
    enabled: true
    custom: false
    type: AUTO
    path: "/"
    command: []
    httpHeaders: {}
    spec:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5
```

### enabled

Specifies whether the probe is enabled.

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `true`
- Helm Template: ❌

Applies to types:

- `AUTO`
- `TCP`
- `HTTP`
- `HTTPS`
- `GRPC`
- `exec`

Examples: Values.yaml

```yaml
probe:
  liveness:
    enabled: true
```

</details>

### custom

Specifies whether a custom probe will be defined.

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
probe:
  liveness:
    custom: true
```

</details>

### type

Specifies the type of the probe

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `AUTO`
- Helm Template: ❌

Available options:

- `AUTO`
- `TCP`
- `HTTP`
- `HTTPS`
- `GRPC`
- `exec`

Examples: Values.yaml

```yaml
probe:
  liveness:
    type: AUTO

probe:
  liveness:
    type: TCP

probe:
  liveness:
    type: HTTP

probe:
  liveness:
    type: HTTPS

probe:
  liveness:
    type: GRPC

probe:
  liveness:
    type: exec
```

</details>

### path

Specifies the path of the HTTP(S) probe

<details>
<summary>Show / Hide</summary>

- Type: `string`
- Default: `/`
- Helm Template: ✅

Applies to types:

- `AUTO`
- `HTTP`
- `HTTPS`

Examples: Values.yaml

```yaml
probe:
  liveness:
    path: /ping
```

</details>

### command

Specifies the command(s) of the exec probe

<details>
<summary>Show / Hide</summary>

- Type: `list` or `string`
- Default: `[]`
- Helm Template: ✅

Applies to types:

- `exec`

Examples: Values.yaml

```yaml
probe:
  liveness:
    command: healthcheck.sh

probe:
  liveness:
    command: "{{ .Values.some.command }}"

probe:
  liveness:
    command:
      - healthcheck.sh
      - now

probe:
  liveness:
    command:
      - "{{ .Values.some.command }}"
      - now

probe:
  liveness:
    command:
      - /bin/bash
      - -c
      - |
        echo "Running healthcheck"
```

</details>

### httpHeaders

Specifies the httpHeader(s) of the HTTP(S) probe

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default: `{}`
- Helm Template: ✅
  - On Values only

Applies to types:

- `AUTO`
- `HTTP`
- `HTTPS`

Examples: Values.yaml

```yaml
probe:
  liveness:
    httpHeaders:
      key: value

probe:
  liveness:
    httpHeaders:
      key: "{{ .Values.some.value }}"
```

</details>

### spec

Specifies the timeouts on all probes, except on a custom probe defines the whole probe

<details>
<summary>Show / Hide</summary>

- Type: `dict`
- Default:

```yaml
spec:
  initialDelaySeconds: 10
  periodSeconds: 10
  timeoutSeconds: 5
  failureThreshold: 5
```

- Helm Template: ❌

Applies to types:

- `AUTO`
- `TCP`
- `HTTP`
- `HTTPS`
- `GRPC`
- `exec`

Examples: Values.yaml

```yaml
probe:
  liveness:
    spec:
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 5
      failureThreshold: 5

probe:
  liveness:
    spec:
      httpGet:
        path: /healthz
        port: 8080
        httpHeaders:
        - name: Custom-Header
          value: Awesome
      initialDelaySeconds: 3
      periodSeconds: 3
```

</details>

</details> <!-- End of probes -->
