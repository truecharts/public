# Probes

## key: probes

- Type: `dict`
- Default:

  ```yaml
  probes:
    liveness:
      enabled: true
      type: AUTO
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
      type: AUTO
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
      type: AUTO
      path: "/"
      port: ""
      command: []
      spec:
        initialDelaySeconds: 10
        timeoutSeconds: 2
        periodSeconds: 5
        failureThreshold: 60
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

`probes` key contains the probes for the container.
`liveness`, `readiness` and `startup` probes, behave the same.
Below examples will use `liveness`. But applies to all probes.

`AUTO` type, will automatically define a probe type and it's properties
based on the `primary` service's `primary` port protocol.

- `HTTP` and `HTTPS` protocols, will result in `httpGet` probe
- `TCP` protocol, will result in `TCP` probe

`port` defaults to `targetPort` of `primary` service/port,
or `port` if `targetPort` is missing

Example:

```yaml
# - AUTO Type
# Main service and main port is by default enabled and primary
service:
  main:
    ports:
      main:
        port: 10000
        protocol: HTTP
        targetPort: 80
# No need to define anything under probes
# it's set by default to AUTO

# ---

# - HTTP Probe
probes:
  liveness:
    type: HTTP # Defines the scheme
    path: /health # Hardcoded
    # path: "{{ .Values.some.path }}"  # tpl
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl
    spec: # Only if you want to override the defaults
      initialDelaySeconds: 10
      timeoutSeconds: 2
      periodSeconds: 5
      failureThreshold: 60

# - TCP Probe
probes:
  liveness:
    type: TCP
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl

# - GRPC Probe
probes:
  liveness:
    type: GRPC
    port: 80  # Hardcoded
    # port: "{{ .Values.service.some_service.ports.some_port.targetPort }}"  # tpl

# - EXEC Probe
probes:
  liveness:
    type: EXEC
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
    type: CUSTOM
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
