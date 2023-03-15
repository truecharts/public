{{/* Define the worker container */}}
{{- define "authentik.worker" -}}
enabled: true
imageSelector: image
args: ["worker"]
envFrom:
  - secretRef:
      name: 'authentik-secret'
  - configMapRef:
      name: 'authentik-config'
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
