{{/* Returns host aliases */}}
{{- define "ix.v1.common.hostAliases" -}}
  {{- range .Values.hostAliases }}
- ip: {{ (tpl (required "<ip> field is required in hostAliases" .ip) $ | quote) }}
    {{- if .hostnames }}
  hostnames:
      {{- range .hostnames }}
    - {{ tpl . $ }}
      {{- end}}
    {{- else -}}
      {{- fail "At least one <hostnames> is required in hostAliases" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
