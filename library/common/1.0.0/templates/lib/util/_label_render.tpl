{{/* Takes a "root" object and a "labels" object */}}
{{/* Returns rendered labels */}}
{{- define "ix.v1.common.util.labels.render" -}}
  {{- $root := .root -}}
  {{- $labels := .labels -}}
  {{- if $labels -}}
    {{- range $k, $v := $labels }}
{{ $k }}: {{ tpl $v $root | quote }}
    {{- end }}
  {{- end -}}
{{- end -}}
