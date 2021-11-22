{{/* vim: set filetype=mustache: */}}
{{/*
Return  the proper Storage Class
{{ include "common.storage.class" ( dict "persistence" .Values.path.to.the.persistence "global" $) }}
*/}}
{{- define "common.storage.class" -}}

{{- $storageClass := .persistence.storageClass -}}
{{- if .global -}}
    {{- if .global.storageClass -}}
        {{- $storageClass = .global.storageClass -}}
    {{- end -}}
{{- end -}}

{{- if $storageClass -}}
  {{- if (eq "-" $storageClass) -}}
    {{- printf "storageClassName: \"\"" -}}
  {{- else if (eq "SCALE-ZFS" $storageClass ) }}
    {{ ( printf "storageClassName: ix-storage-class-%s"  .Release.Name ) }}
  {{- else }}
    {{- printf "storageClassName: %s" $storageClass -}}
  {{- end -}}
{{- end -}}

{{- if or ( .Values.global.isSCALE ) ( .Values.ixChartContext ) ( .Values.global.ixChartContext ) }}
  {{ ( printf "storageClassName: ix-storage-class-%s"  .Release.Name ) }}
{{- end }}

{{- end -}}
