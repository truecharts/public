# Command / Args

## Key: command

- Type: `list`
- Default: `string` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

`command` key overrides the entrypoint of the container

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

## Key: args

- Type: `list`
- Default: `string` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

`args` key adds arguments to the entrypoint of the container

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

## Key: extraArgs

- Type: `list`
- Default: `string` or `[]`
- Helm Template:
  - String: ✅
  - List entry: ✅

`extraArgs` key appends arguments to `args` of the container.
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

- [command - args](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#define-a-command-and-arguments-when-you-create-a-pod)
