{{- define "immich.microservices" -}}
enabled: true
imageSelector: image
command:
  - /bin/sh
  - ./start-microservices.sh
envFrom:
  - secretRef:
      name: secret
  - secretRef:
      name: deps-secret
  - configMapRef:
      name: common-config
  - configMapRef:
      name: server-config
probes:
  {{/* TODO: Create probes */}}
  readiness:
    enabled: false
  liveness:
    enabled: false
  startup:
    enabled: false
{{- end -}}
