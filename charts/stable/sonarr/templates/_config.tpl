{{- define "sonarr.config" -}}
  {{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $secretName := printf "%s-secret" $fname -}}
  {{- $serverUrl := printf "http://%v-server:%v" $fname .Values.service.main.ports.main.port }}
configmap:
  {{- if .Values.exportarr.enabled }}
  exportarr-config:
    enabled: true
    data:
      INTERFACE: 0.0.0.0
      PORT: {{ .Values.service.exportarr.ports.exportarr.port | quote }}
      URL: {{ $serverUrl | quote }}
      CONFIG: "{{.Values.persistence.config.mountPath }}/config.xml"
  {{- end }}
{{- end -}}
