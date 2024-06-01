{{/* PVC - Storage Class Name */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.storageClassName" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The object data of the pvc
*/}}
{{- define "tc.v1.common.lib.storage.storageClassName" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $caller := .caller -}}

  {{/*
    If storageClass is defined on the objectData:
      *  "-" returns "", which means requesting a PV without class
      *   Else return the original defined storageClass

    Else if there is a storageClass defined in Values.global.fallbackDefaults.storageClass, return this

    In any other case, return nothing
  */}}

  {{- $className := "" -}}
  {{- if $objectData.storageClass -}}
    {{- $storageClass := (tpl $objectData.storageClass $rootCtx) -}}

    {{- if eq "-" $storageClass -}}
      {{- $className = "\"\"" -}}
    {{- else -}}
      {{- $className = tpl $storageClass $rootCtx -}}
    {{- end -}}

  {{- else if $rootCtx.Values.global.fallbackDefaults.storageClass -}}

    {{- $className = tpl $rootCtx.Values.global.fallbackDefaults.storageClass $rootCtx -}}

  {{- end -}}

  {{- $className -}}
{{- end -}}
