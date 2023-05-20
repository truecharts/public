{{- define "immich.server" -}}
enabled: true
primary: true
imageSelector: image
command: /bin/sh
args: ./start-server.sh
envFrom:
  - configMapRef:
      name: server-config
  - configMapRef:
      name: common-config
  - secretRef:
      name: deps-secret
  - secretRef:
      name: secret
probes:
  liveness:
    enabled: true
    type: http
    path: /server-info/ping
    port: {{ .Values.service.server.ports.server.port }}
  readiness:
    enabled: true
    type: http
    path: /server-info/ping
    port: {{ .Values.service.server.ports.server.port }}
  startup:
    enabled: true
    type: http
    path: /server-info/ping
    port: {{ .Values.service.server.ports.server.port }}
{{- end -}}
