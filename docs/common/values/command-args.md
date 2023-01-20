# Command / Args

## Key: command

Info:

- Type: `list` or `string`
- Default: `""` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

Can be defined in:

- `.Values`.command
- `.Values.additionalContainers.[container-name]`.command
- `.Values.initContainers.[container-name]`.command
- `.Values.installContainers.[container-name]`.command
- `.Values.upgradeContainers.[container-name]`.command
- `.Values.systemContainers.[container-name]`.command
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.command

---

Overrides the entrypoint of the container

Examples:

```yaml
# String / Single command
command: ./custom-script.sh
# String / Single command (tpl)
command: "{{ .Values.customCommand }}"

# List
command:
  - /bin/sh
  - -c
  - |
    echo "Doing things..."
# List (tpl)
command:
  - /path/to/executable
  - --port
  - "{{ .Values.service.main.ports.main.port }}"
```

---
---

## Key: args

Info:

- Type: `list`
- Default: `string` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

Can be defined in:

- `.Values`.args
- `.Values.additionalContainers.[container-name]`.args
- `.Values.initContainers.[container-name]`.args
- `.Values.installContainers.[container-name]`.args
- `.Values.upgradeContainers.[container-name]`.args
- `.Values.systemContainers.[container-name]`.args
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.args

---

Adds arguments to the entrypoint of the container

Examples:

```yaml
# String / Single args
args: worker
# String / Single arg (tpl)
arg: "{{ .Values.mode }}"

# List
arg:
  - --port
  - 8080
# List (tpl)
arg:
  - --port
  - "{{ .Values.service.main.ports.main.port }}"
```

---
---

## Key: extraArgs

Info:

- Type: `list`
- Default: `string` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

Can be defined in:

- `.Values`.extraArgs
- `.Values.additionalContainers.[container-name]`.extraArgs
- `.Values.initContainers.[container-name]`.extraArgs
- `.Values.installContainers.[container-name]`.extraArgs
- `.Values.upgradeContainers.[container-name]`.extraArgs
- `.Values.systemContainers.[container-name]`.extraArgs
- `.Values.jobs.[job-name].podSpec.containers.[container-name].[container-name]`.extraArgs

---

Appends arguments to `args` of the container.
This is useful for exposing it on SCALE GUI, so users can append
arguments on top of the ones defined from the chart developer

Examples:

```yaml
# String / Single args
extraArgs: some_extra_arg
# String / Single arg (tpl)
extraArgs: "{{ .Values.some_key }}"

# List
extraArgs:
  - --photos_path
  - /path/to/photos
# List (tpl)
extraArgs:
  - --photos_path
  - "{{ .Values.persistence.photos.mountPath }}"
```

Kubernetes Documentation:

- [Command / Args](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#define-a-command-and-arguments-when-you-create-a-pod)
