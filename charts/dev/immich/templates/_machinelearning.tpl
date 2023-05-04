{{/* Define the machinelearning container */}}
{{- define "immich.machinelearning" -}}
enabled: true
imageSelector: mlImage
envFrom:
  - configMapRef:
      name: common-config
  - configMapRef:
      name: server-config
  - secretRef:
      name: deps-secret
  - secretRef:
      name: secret
probes:
  readiness:
    enabled: true
    type: http
    path: /ping
    port: 3003
  liveness:
    enabled: true
    type: http
    path: /ping
    port: 3003
  startup:
    enabled: true
    type: http
    path: /ping
    port: 3003
{{- end -}}
