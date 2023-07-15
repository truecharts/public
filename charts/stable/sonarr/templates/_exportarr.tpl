{{- define "exportarr.container" -}}
enabled: true
imageSelector: exportarrImage
args: ["sonarr"]
envFrom:
  - secretRef:
      name: exportarr-secrets
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

{{/* Define the secrets */}}
{{- define "exportarr.secrets" -}}
{{- $serverUrl := printf "http://%v-server:%v" $fname .Values.service.main.ports.main.port }}
enabled: true
data:
  INTERFACE: 0.0.0.0
  PORT: {{ .Values.service.metrics.ports.metrics.port | quote }}
  URL: {{ $serverUrl | quote }}
  CONFIG: {{.Values.persistence.config.mountPath  | quote }}
{{- end -}}
