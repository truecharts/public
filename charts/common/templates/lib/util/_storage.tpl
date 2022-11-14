{{/* vim: set filetype=mustache: */}}
{{/*
Return  the proper Storage Class
{{ include "tc.common.storage.classname" ( dict "persistence" .Values.path.to.the.persistence "global" $ ) }}
*/}}
{{- define "tc.common.storage.storageClassName" -}}

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

{{- define "tc.common.storage.storageClass" -}}

{{- if .persistence.storageClass -}}
  {{- if (eq "-" .persistence.storageClass) -}}
    {{- printf "storageClass: \"\"" -}}
  {{- else if and (eq "SCALE-ZFS" .persistence.storageClass ) -}}
    {{- printf "storageClass: %s" .global.Values.global.ixChartContext.storageClassName -}}
  {{- else -}}
    {{- printf "storageClass: %s" .persistence.storageClass -}}
  {{- end -}}
{{- else if .global.Values.global.ixChartContext -}}
  {{- printf "storageClass: %s" .global.Values.global.ixChartContext.storageClassName -}}
{{- end -}}

{{- end -}}

{{- define "tc.common.storage.class" -}}

{{- if .persistence.storageClass -}}
  {{- if (eq "-" .persistence.storageClass) -}}
    {{- printf "\"\"" -}}
  {{- else if and (eq "SCALE-ZFS" .persistence.storageClass ) -}}
    {{- printf "%s" .global.Values.global.ixChartContext.storageClassName -}}
  {{- else -}}
    {{- printf "%s" .persistence.storageClass -}}
  {{- end -}}
{{- else if .global.Values.global.ixChartContext -}}
  {{- printf "%s" .global.Values.global.ixChartContext.storageClassName -}}
{{- end -}}

{{- end -}}
