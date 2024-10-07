{{/* Define the secrets */}}
{{- define "wg.config-secret" -}}
enabled: true
data:
  wg0.conf: |
{{ .Values.wg.config.data | indent 4 }}
{{- end -}}
