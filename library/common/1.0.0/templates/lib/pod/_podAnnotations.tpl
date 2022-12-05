{{/* Returns Pod annotations */}}
{{- define "ix.v1.common.podAnnotations" -}}
  {{- with .Values.podAnnotations -}}
    {{- range $k, $v := . }}
{{ $k }}: {{ tpl $v $ }}
    {{- end }}
  {{- end -}}
{{- end -}}
