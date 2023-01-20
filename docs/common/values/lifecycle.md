# Lifecycle

## Key: lifecycle

Info:

- Type: `dict`
- Default: `{}`
- Helm Template:
  - lifecycle.preStop.command - String: ✅
  - lifecycle.preStop.command - List entry: ✅
  - lifecycle.postStart.command - String: ✅
  - lifecycle.postStart.command - List entry: ✅

Can be defined in:

- `.Values`.lifecycle
- `.Values.additionalContainers.[container-name]`.lifecycle

---

`lifecycle` key defines hooks that can run on the pod. Like `preStop` or `postStart`

Examples `preStop`:

```yaml
# String / Single command
lifecycle:
  preStop:
    command: ./custom-script.sh
# String / Single command (tpl)
lifecycle:
  preStop:
    command: "{{ .Values.customCommand }}"

# List
lifecycle:
  preStop:
    command:
      - /bin/sh
      - -c
      - |
        echo "Doing things..."
# List (tpl)
lifecycle:
  preStop:
    command:
      - /path/to/executable
      - --port
      - "{{ .Values.service.main.ports.main.port }}"
```

Examples `postStart`:

```yaml
# String / Single command
lifecycle:
  postStart:
    command: ./custom-script.sh
# String / Single command (tpl)
lifecycle:
  postStart:
    command: "{{ .Values.customCommand }}"

# List
lifecycle:
  postStart:
    command:
      - /bin/sh
      - -c
      - |
        echo "Doing things..."
# List (tpl)
lifecycle:
  postStart:
    command:
      - /path/to/executable
      - --port
      - "{{ .Values.service.main.ports.main.port }}"
```

Kubernetes Documentation:

- [Lifecycle Hooks](https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks)
