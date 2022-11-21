{{/* Returns node selector */}}
{{- define "ix.v1.common.nodeSelector" -}}
  {{- with .Values.nodeSelector -}}
    {{- range $k, $v := . }}
      {{- if (not $v) -}}
        {{- fail "Value is required on every key in <nodeSelector>" -}}
      {{- end }}
{{ $k }}: {{ tpl $v $ }}
    {{- end }}
  {{- end -}}
{{- end -}}
