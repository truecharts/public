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
      *  "SCALE-ZFS" returns the value set on Values.global.ixChartContext.storageClassName
      *   Else return the original defined storageClass

    Else if we are in an ixChartContext, always return the storageClassName defined on the ixChartContext

    Else if there is a storageClass defined in Values.global.fallbackDefaults.storageClass, return this

    In any other case, return nothing
  */}}

  {{- $className := "" -}}
  {{- if $objectData.storageClass -}}
    {{- $storageClass := (tpl $objectData.storageClass $rootCtx) -}}

    {{- if eq "-" $storageClass -}}
      {{- $className = "\"\"" -}}
    {{- else if eq "SCALE-ZFS" $storageClass -}}
      {{- if not $rootCtx.Values.global.ixChartContext.storageClassName -}}
        {{- fail (printf "%s - Expected non-empty [global.ixChartContext.storageClassName] on [SCALE-ZFS] storageClass" $caller) -}}
      {{- end -}}
      {{- $className = tpl $rootCtx.Values.global.ixChartContext.storageClassName $rootCtx -}}
    {{- else -}}
      {{- $className = tpl $storageClass $rootCtx -}}
    {{- end -}}

  {{/* On Cobia -> Dragonfish update the ixChartContext should still be there, for existing apps so we can reference it */}}
  {{- else if and $rootCtx.Values.global.ixChartContext $rootCtx.Values.global.ixChartContext.storageClassName -}}
    {{- $scaleClassFound := false -}}
    {{- with (lookup "storage.k8s.io/v1" "StorageClass" "" $rootCtx.Values.global.ixChartContext.storageClassName) -}}
      {{/* Check if there is an actually valid storageClass found */}}
      {{- if .provisioner -}}
        {{- $scaleClassFound = true -}}
      {{- end -}}
    {{- end -}}

    {{- if or $scaleClassFound (and $rootCtx.Values.global.ixChartContext.ci $rootCtx.Values.global.ixChartContext.ci.storageClass) -}}
      {{- $className = tpl $rootCtx.Values.global.ixChartContext.storageClassName $rootCtx -}}
    {{- else if $rootCtx.Values.global.fallbackDefaults.storageClass -}}
      {{- $className = tpl $rootCtx.Values.global.fallbackDefaults.storageClass $rootCtx -}}
    {{- end -}}

  {{- else if $rootCtx.Values.global.fallbackDefaults.storageClass -}}

    {{- $className = tpl $rootCtx.Values.global.fallbackDefaults.storageClass $rootCtx -}}

  {{- end -}}

  {{- $className -}}
{{- end -}}
