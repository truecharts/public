{{- define "sonarr.config" -}}
  {{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $secretName := printf "%s-secret" $fname -}}
  {{- $serverUrl := printf "http://%v-server:%v" $fname .Values.service.main.ports.main.port }}
configmap:
  {{- if .Values.exportarr.enabled }}
  exportarr-config:
    enabled: true
    data:
      SERVER_PORT: {{ .Values.service.server.ports.server.port | quote }}
      INTERFACE: 0.0.0.0
      PORT: {{ .Values.service.metrics.ports.metrics.port | quote }}
      URL: {{ $serverUrl | quote }}
      CONFIG: {{.Values.persistence.config.mountPath  | quote }}
  {{- end }}
{{- end -}}
