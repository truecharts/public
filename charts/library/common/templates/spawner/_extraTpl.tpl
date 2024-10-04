{{- define "tc.v1.common.spawner.extraTpl" -}}
  {{- range $item := .Values.extraTpl }}
    {{- if not $item -}}
      {{- fail "Extra tpl - Expected non-empty [extraTpl] item" -}}
    {{- end }}
---
    {{- if kindIs "string" $item }}
      {{- tpl $item $ | nindent 0 }}
    {{- else }}
      {{- tpl ($item | toYaml) $ | nindent 0 }}
    {{- end }}
  {{- end }}
{{- end }}
