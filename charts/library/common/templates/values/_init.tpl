{{/* Merge chart values and the common chart defaults */}}
{{/* The ".common" is the name of the library */}}
{{/* Call this template:
{{ include "tc.v1.common.values.init" $ }}
*/}}

{{- define "tc.v1.common.values.init" -}}
  {{- if .Values.common -}}
    {{- $commonValues := mustDeepCopy .Values.common -}}
    {{- $chartValues := mustDeepCopy (omit .Values "common") -}}
    {{- $mergedValues := mustMergeOverwrite $commonValues $chartValues -}}
    {{- range .Values.dependencies -}}
      {{- if .enabled -}}
        {{- $dependencyValues := omit . "global "-}}
        {{- $dependencyValues := omit $dependencyValues "securityContext "-}}
        {{- $dependencyValues := omit $dependencyValues "podOptions "-}}
        {{- $mergedValues = mustMergeOverwrite $mergedValues $dependencyValues -}}
      {{- end -}}
    {{- end -}}
    {{- $_ := set . "Values" (mustDeepCopy $mergedValues) -}}
  {{- end -}}
{{- end -}}
