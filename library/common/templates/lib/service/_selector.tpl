{{- define "ix.v1.common.class.serivce.selector" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}
selector:
  {{- with $svcValues.selector -}} {{/* If custom selector defined */}}
    {{- range $k, $v := . }}
  {{ $k }}: {{ tpl $v $root }}
    {{- end -}}
  {{- else -}} {{/* else use the generated selectors */}}
    {{- include "ix.v1.common.labels.selectorLabels" $root | nindent 2 -}}
  {{- end -}}
{{- end -}}
