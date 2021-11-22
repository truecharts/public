{{/* vim: set filetype=mustache: */}}
{{/*
Return  the proper Storage Class
{{ include "common.storage.class" ( dict "persistence" .Values.path.to.the.persistence "global" $ ) }}
*/}}
{{- define "common.storage.class" -}}

{{- $storageClass := .persistence.storageClass -}}

{{- if $storageClass -}}
  {{- if (eq "-" $storageClass) -}}
    {{- printf "storageClassName: \"\"" -}}
  {{- else if (eq "SCALE-ZFS" $storageClass ) }}
    {{ ( printf "storageClassName: ix-storage-class-%s"  .Release.Name ) }}
  {{- else }}
    {{- printf "storageClassName: %s" $storageClass -}}
  {{- end -}}
{{- end -}}

{{- if .global }}
{{- if .global.Values.global  -}}
  {{- if .global.Values.global.storageClass -}}
    {{- $storageClass = .global.Values.global.storageClass -}}
  {{- end -}}
  {{- if or ( .global.Values.global.ixChartContext ) ( .global.Values.global.isSCALE ) -}}
    {{ ( printf "storageClassName: ix-storage-class-%s"  .global.Release.Name ) }}
  {{- end }}
{{- end -}}

{{- if .global.Values.storageClass -}}
  {{- $storageClass = .global.Values.storageClass -}}
{{- end -}}

{{- if .global.Values.ixChartContext }}
  {{ ( printf "storageClassName: ix-storage-class-%s"  .global.Release.Name ) }}
{{- end }}
{{- end }}

{{- end -}}
