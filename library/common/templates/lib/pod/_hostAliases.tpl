{{/* Returns host aliases */}}
{{- define "ix.v1.common.hostAliases" -}}
  {{- $hostAliases := .hostAliases -}}
  {{- $root := .root -}}

  {{- range $hostAliases }}
- ip: {{ (tpl (required "<ip> field is required in hostAliases" .ip) $root | quote) }}
    {{- if .hostnames }}
  hostnames:
      {{- range .hostnames }}
    - {{ tpl . $root }}
      {{- end}}
    {{- else -}}
      {{- fail "At least one <hostnames> is required in hostAliases" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
