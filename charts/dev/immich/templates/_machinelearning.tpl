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
    enabled: false
  liveness:
    enabled: false
  startup:
    enabled: false
{{- end -}}
