{{/* Merge the local chart values and the common chart defaults */}}
{{/* The .common part comes from the name of this library */}}
{{- define "ix.v1.common.values.init" -}}
  {{- if .Values.common -}}
    {{- $defaultValues := mustDeepCopy .Values.common -}}
    {{- $userValues := mustDeepCopy (omit .Values "common") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (mustDeepCopy $mergedValues) -}}
  {{- end -}}
{{- end -}}
