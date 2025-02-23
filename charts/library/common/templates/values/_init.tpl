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
    {{- range $name, $dependencyValues := .Values.dependencies -}}
      {{ $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                      "rootCtx" $ "objectData" $dependencyValues
                      "name" $name "caller" "dependency"
                      "key" "dependencies")) }}
      {{- if eq $enabled "true" -}}
        {{- $dependencyValues := omit $dependencyValues "global " -}}
        {{- $dependencyValues := omit $dependencyValues "securityContext  " -}}
        {{- $dependencyValues := omit $dependencyValues "podOptions " -}}
        {{- $mergedValues = mustMergeOverwrite $mergedValues $dependencyValues -}}
      {{- end -}}
      {{- range $mergedValues.addons -}}
        {{- if .enabled -}}
          {{- $mergedValues = mustMergeOverwrite $mergedValues . -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
    {{- $_ := set . "Values" (mustDeepCopy $mergedValues) -}}
  {{- end -}}
{{- end -}}
