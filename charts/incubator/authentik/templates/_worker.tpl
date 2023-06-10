{{/* Define the worker container */}}
{{- define "authentik.worker.container" -}}
enabled: true
primary: false
imageSelector: image
args: ["worker"]
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-authentik-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-authentik-config'
probes:
  readiness:
    enabled: true
    type: exec
    command:
        - /lifecycle/ak
        - healthcheck
  liveness:
    enabled: true
    type: exec
    command:
        - /lifecycle/ak
        - healthcheck
  startup:
    enabled: true
    type: exec
    command:
        - /lifecycle/ak
        - healthcheck
{{- end -}}
