{{/* Define the secrets */}}
{{- define "flemarr.config" -}}

{{- $configName := printf "%s-flemarr-config" (include "tc.common.names.fullname" .) }}

enabled: true    
data:
  config.yml: |
{{- .Values.flemarrConfig | toYaml | nindent 4 }}
{{- end -}}
