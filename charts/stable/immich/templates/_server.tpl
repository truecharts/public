{{- define "immich.server" -}}
enabled: true
primary: true
imageSelector: image
resources:
  excludeExtra: true
command: /bin/sh
args:
  - -c
  - /usr/src/app/start-server.sh
securityContext:
  capabilities:
    disableS6Caps: true
envFrom:
  - configMapRef:
      name: server-config
  - configMapRef:
      name: common-config
  - secretRef:
      name: deps-secret
probes:
  liveness:
    enabled: true
    type: http
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.port }}
  readiness:
    enabled: true
    type: http
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.port }}
  startup:
    enabled: true
    type: http
    path: /api/server-info/ping
    port: {{ .Values.service.main.ports.main.port }}
{{- end -}}
