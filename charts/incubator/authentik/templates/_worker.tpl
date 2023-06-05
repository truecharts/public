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
readinessProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
livenessProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
startupProbe:
  exec:
    command:
      - /lifecycle/ak
      - healthcheck
{{- end -}}
