{{- define "sonarr.exportarr" -}}
enabled: true
imageSelector: exportarrImage
args: sonarr
envFrom:
  - configMapRef:
      name: sonarr-config
probes:
  liveness:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.exportarr.ports.exportarr.port }}
  readiness:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.exportarr.ports.exportarr.port }}
  startup:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.exportarr.ports.exportarr.port }}
{{- end -}}
