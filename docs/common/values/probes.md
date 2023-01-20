# Probes

## key: probes

Info:

- Type: `dict`
- Default:

  ```yaml
  probes:
    liveness:
      enabled: true
    readiness:
      enabled: true
    startup:
      enabled: true
  ```

- Helm Template:
  - probes.PROBENAME.command - Single String: ✅
  - probes.PROBENAME.command - List Entry: ✅
  - probes.PROBENAME.port: ✅
  - probes.PROBENAME.path: ✅
  - probes.PROBENAME.httpHeaders.value: ✅
  - probes.PROBENAME.httpHeaders.key: ❌
  - probes.PROBENAME.enabled: ❌
  - probes.PROBENAME.type: ❌
  - probes.PROBENAME.spec: ❌

Can be defined in:

- `.Values`.probes
- `.Values.additionalContainers.[container-name]`.probes

---

With the above mentioned default and without defining anything else,
common will result in the following initial state of probes.
You can override every value, you don't have to rewrite every key.
Only the one's you want to change.

```yaml
  probes:
    liveness:
      enabled: true
      type: auto
      # Optional
      path: "/"
      # Optional
      port: ""
      # Optional
      command: []
      # Optional
      httpHeaders: {}
      # Optional
      spec:
        initialDelaySeconds: 10
        periodSeconds: 10
        timeoutSeconds: 5
        failureThreshold: 5
    readiness:
      enabled: true
      type: auto
      path: "/"
      port: ""
      command: []
      spec:
        initialDelaySeconds: 10
        periodSeconds: 10
        timeoutSeconds: 5
        failureThreshold: 5
    startup:
      enabled: true
      type: auto
      path: "/"
      port: ""
      command: []
      spec:
        initialDelaySeconds: 10
        timeoutSeconds: 2
        periodSeconds: 5
        failureThreshold: 60
```

`probes` key contains the probes for the container.
`liveness`, `readiness` and `startup` probes, behave the same.
Below examples will use `liveness`. But applies to all probes.

`auto` type, will automatically define a probe type and it's properties
based on the `primary` service's `primary` port protocol.
> (Only available on main container)

`spec` contains the timeouts for the probe (or the custom probe).
If not defined it will use the defaults from `.Values.global.defaults.probes.[probe-name].spec`.

- `http` and `https` type, will result in `httpGet` probe
- `tcp` type, will result in `tcp` probe
- `exec` type, will result in a `exec` probe
- `grpc` type, will result in a `grpc` probe
- `custom` type, will require a 1:1 definition from k8s docs

`port` defaults to `targetPort` of `primary` service/port,
or `port` if `targetPort` is missing

Example:

```yaml
# - auto type
# Main service and main port is by default enabled and primary
service:
  main:
    ports:
      main:
        port: 10000
        protocol: HTTP
        targetPort: 80
# No need to define anything under probes
# as it defaults to auto

# ---

# - HTTP Probe
probes:
  liveness:
    type: http # Defines the scheme
    path: /health # Hardcoded
    # path: "{{ .Values.some.path }}"  # tpl
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl
    # Headers - hardcoded
    # httpHeaders:
    #   header: value
    # Headers - tpl
    # httpHeaders:
    #   header: "{{ .Values.some.path }}"
    spec: # Only if you want to override the defaults
      initialDelaySeconds: 10
      timeoutSeconds: 2
      periodSeconds: 5
      failureThreshold: 60

# - TCP Probe
probes:
  liveness:
    type: tcp
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl

# - GRPC Probe
probes:
  liveness:
    type: grpc
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl

# - EXEC Probe
probes:
  liveness:
    type: exec
    command: healthcheck.sh # Hardcoded
    # command: "{{ .Values.healthcheck_command }}" # tpl

    # command: # Hardcoded List
    #   - /bin/sh
    #   - -c
    #   - |
    #     healthcheck.sh

    # command: # tpl List
    #   - /bin/sh
    #   - -c
    #   - {{ .Values.healthcheck_command }}

# - CUSTOM Probe - Pure k8s definition, no tpl enabled
# Not recommended, above options should give all the flexibility needed.
probes:
  liveness:
    type: custom
    spec:
      httpGet:
        path: /
        scheme: HTTP
        port: 65535
      initialDelaySeconds: 10
      failureThreshold: 60
      timeoutSeconds: 2
      periodSeconds: 5

# - Disable Probe
probes:
  liveness:
    enabled: false
```
