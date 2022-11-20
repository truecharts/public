{{/* Returns Pod labels */}}
{{- define "ix.v1.common.podLabels" -}}
  {{- with .Values.podLabels -}}
    {{- range $k, $v := . }}
{{ $k }}: {{ tpl $v $ }}
    {{- end }}
  {{- end -}}
{{- end -}}
