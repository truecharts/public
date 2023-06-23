{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $secretName := (printf "%s-mcrouter-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $mcrouter := .Values.mcrouter -}}

enabled: true
data:
  MAPPING: {{ join "," $mcrouter.host_minecraft | quote }}
{{- end -}}
