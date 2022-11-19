{{/* Takes a "root" object and a "annotations" object */}}
{{/* Returns rendered annotations */}}
{{- define "ix.v1.common.util.annotations.render" -}}
  {{- $root := .root -}}
  {{- $annotations := .annotations -}}
  {{- if $annotations }}
    {{- range $k, $v := $annotations }}
{{ $k }}: {{ tpl $v $root | quote }}
    {{- end }}
  {{- end }}
{{- end -}}
