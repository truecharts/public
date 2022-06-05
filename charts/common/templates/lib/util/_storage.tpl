{{/* vim: set filetype=mustache: */}}
{{/*
Return  the proper Storage Class
{{ include "tc.common.storage.class" ( dict "persistence" .Values.path.to.the.persistence "global" $ ) }}
*/}}
{{- define "tc.common.storage.class" -}}

{{- if .persistence.storageClass -}}
  {{- if (eq "-" .persistence.storageClass) -}}
    {{- printf "storageClassName: \"\"" -}}
  {{- else if and (eq "SCALE-ZFS" .persistence.storageClass ) -}}
    {{- printf "storageClassName: %s" .global.Values.global.ixChartContext.storageClassName -}}
  {{- else -}}
    {{- printf "storageClassName: %s" .persistence.storageClass -}}
  {{- end -}}
{{- else if .global.Values.global.ixChartContext -}}
  {{- printf "storageClassName: %s" .global.Values.global.ixChartContext.storageClassName -}}
{{- end -}}

{{- end -}}
