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
</details>

## nameOverride

<details>
<summary>Show / Hide</summary>

Sets an override for the suffix of the full name.
(Applies to current chart only)

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

<details>
<summary>Show / Hide</summary>

Set annotations on the pod.

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

<details>
<summary>Show / Hide</summary>

Set labels on the pod.

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

<details>
<summary>Show / Hide</summary>

Override the command(s) for the default container

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

<details>
<summary>Show / Hide</summary>

Override the args for the default container

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

<details>
<summary>Show / Hide</summary>

Appends args to the `args` for the default container.
If no `args` are defined, `extraArgs` will still be set.
Mainly built for the SCALE GUI

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

<details>
<summary>Show / Hide</summary>

Specifies whether the default container in a pod runs with `TTY` enabled.

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
tty: true

tty: false
```

Coverts extraArgs to a list and appends it to:

- Deployment
  - spec.template.spec.containers[0].tty

</details>

## stdin

<details>
<summary>Show / Hide</summary>

Specifies whether the default container in a pod runs with `stdin` enabled.

- Type: `boolean`
- Default: `false`
- Helm Template: ❌

Examples: Values.yaml

```yaml
stdin: true

stdin: false
```

Coverts extraArgs to a list and appends it to:

- Deployment
  - spec.template.spec.containers[0].stdin

</details>
