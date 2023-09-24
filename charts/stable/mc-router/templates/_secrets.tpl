{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $mcrouter := .Values.mcrouter }}

{{- $mappings := list -}}
{{- range $id, $value := $mcrouter.mappings -}}
  {{ $mappings = mustAppend $mappings (printf "%s=%s" $value.domain $value.service) }}
{{- end -}}

enabled: true
data:
  MAPPING: {{ join "," $mappings }}
{{- end -}}
