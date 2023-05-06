{{/* Define the typesense container */}}
{{- define "immich.typesense" -}}
enabled: true
imageSelector: typesenseImage
envFrom:
  - secretRef:
      name: typesense-secret
probes:
  readiness:
    enabled: true
    type: http
    path: /health
    port: 8108
  liveness:
    enabled: true
    type: http
    path: /health
    port: 8108
  startup:
    enabled: true
    type: http
    path: /health
    port: 8108
{{- end -}}
