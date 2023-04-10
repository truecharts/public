{{/* Define the web container */}}
{{- define "immich.web" -}}
enabled: true
imageSelector: webImage
command:
  - /bin/sh
  - ./entrypoint.sh
envFrom:
  - configMapRef:
      name: common-config
  - secretRef:
      name: deps-secret
probes:
  readiness:
    enabled: true
    type: http
    path: /
    port: 3000
  liveness:
    enabled: true
    type: http
    path: /
    port: 3000
  startup:
    enabled: true
    type: http
    path: /
    port: 3000
{{- end -}}
