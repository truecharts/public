{{/* Returns node selector */}}
{{- define "ix.v1.common.nodeSelector" -}}
  {{- $nodeSelector := .nodeSelector -}}
  {{- $root := .root -}}

  {{- with $nodeSelector -}}
    {{- range $k, $v := . }}
      {{- if (not $v) -}}
        {{- fail "Value is required on every key in <nodeSelector>" -}}
      {{- end }}
{{ $k }}: {{ tpl $v $root }}
    {{- end }}
  {{- end -}}
{{- end -}}
