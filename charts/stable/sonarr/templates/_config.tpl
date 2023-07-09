{{- define "sonarr.config" -}}
  {{- $fname := (include "tc.v1.common.lib.chart.names.fullname" .) -}}
  {{- $secretName := printf "%s-secret" $fname -}}
  {{- $serverUrl := printf "http://%v-server:%v" $fname .Values.service.main.ports.main.port }}
configmap:
  {{- if .Values.exportarr.enable }}
  exportarr-config:
    enabled: true
    data:
      INTERFACE: 0.0.0.0
      PORT: {{ .Values.service.exportarr.ports.exportarr.port | quote }}
      URL: {{ $serverUrl | quote }}
      {{- with .Values.exportarr.api_key }}
      API_KEY: {{ . | quote }}
      {{- end }}
      FORM_AUTH: {{ .Values.exportarr.form_auth }}
      {{- with .Values.exportarr.auth_username }}
      AUTH_USERNAME: {{ . | quote }}
      {{- end }}
      {{- with .Values.exportarr.auth_password }}
      AUTH_PASSWORD: {{ . | quote }}
      {{- end }}
      LOG_LEVEL: {{ .Values.exportarr.log_level | quote }}
      DISABLE_SSL_VERIFY: {{ .Values.exportarr.disable_ssl_verify }}
      ENABLE_ADDITIONAL_METRICS: {{ .Values.exportarr.enable_additional_metrics }}
      ENABLE_UNKNOWN_QUEUE_ITEMS: {{ .Values.exportarr.enable_unknown_queue_items }}
  {{- end }}

{{- end -}}
