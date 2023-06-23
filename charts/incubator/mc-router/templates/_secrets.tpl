{{/* Define the secrets */}}
{{- define "mcrouter.secrets" -}}
{{- $mcrouter := .Values.mcrouter -}}
{{- $mappings := list }}
{{- range $item := $mcrouter.host_minecraft }}
  {{- $mappings = mustAppend $mappings $item.domain_minecraft_service }}
{{- end }}
enabled: true
data:
  MAPPING: {{ join "," $mappings | quote }}
{{- end -}}
