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

Override the command(s) for the default container

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

Override the args for the default container

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

Appends args to the `args` for the default container.
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

Specifies whether the default container in a pod runs with `TTY` enabled.

<details>
<summary>Show / Hide</summary>

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

Specifies whether the default container in a pod runs with `stdin` enabled.

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
stdin: true

stdin: false
```

Sets stin to:

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

Configure the Security Context for the default container

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

Specifies privileged status on securityContext for the default container

<details>
<summary>Show / Hide</summary>

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

Specifies readOnlyRootFilesystem status on securityContext for the default container

<details>
<summary>Show / Hide</summary>

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

Specifies allowPrivilegeEscalation status on securityContext for the default container

<details>
<summary>Show / Hide</summary>

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

Specifies runAsNonRoot status on securityContext for the default container

<details>
<summary>Show / Hide</summary>

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

Specifies capabilities to add or drop on securityContext for the default container

<details>
<summary>Show / Hide</summary>

- Type: `boolean`
- Default:
  - add:`[]`
  - drop:`[]`
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
