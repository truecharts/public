{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $secretName := (printf "%s-mcrouter-secrets" (include "tc.v1.common.lib.chart.names.fullname" $)) -}}
{{- $mcrouter := .Values.mcrouter -}}
{{- $mappings := list }}
{{- range $item := $mcrouter.host_minecraft }}
  {{- $mappings = mustAppend $mappings $item.domain_minecraft_service }}
{{- end }}
enabled: true
data:
  MAPPING: {{ join "," $mappings | quote }}
{{- end -}}
