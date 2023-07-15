{{- define "exportarr.container" -}}
enabled: true
imageSelector: exportarrImage
args: ["sonarr"]
envFrom:
  - configMapRef:
      name: exportarr-config
volumeMounts:
  - name: config
    mountPath: "/config"
probes:
  liveness:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.metrics.ports.metrics.port }}
  readiness:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.metrics.ports.metrics.port }}
  startup:
    enabled: true
    type: http
    path: /metrics
    port: {{ .Values.service.metrics.ports.metrics.port }}
{{- end -}}
