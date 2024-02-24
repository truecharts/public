{{/* Returns Runtime Class Name */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.runtimeClassName" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.runtimeClassName" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $runtime := "" -}}

  {{/* Initialize from the "defaults" */}}
  {{- with $rootCtx.Values.podOptions.runtimeClassName -}}
    {{- $runtime = tpl . $rootCtx -}}
  {{- end -}}

  {{/* Override from the pod values, if defined */}}
  {{- with $objectData.podSpec.runtimeClassName -}}
    {{- $runtime = tpl . $rootCtx -}}
  {{- end -}}

  {{/* If on SCALE... */}}
  {{- if hasKey $rootCtx.Values.global "ixChartContext" -}}
    {{- $r := include "tc.v1.common.lib.pod.runtimeClassName.scale" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
    {{- if $r -}}
      {{- $runtime = $r -}}
    {{- end -}}
  {{- end -}}

  {{- $runtime -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.runtimeClassName.scale" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $runtime := "" -}}
  {{- $nvidia := (include "tc.v1.common.lib.pod.resources.hasGPU" (dict "rootCtx" $rootCtx "objectData" $objectData "gpuType" "nvidia.com/gpu")) -}}
  {{- if eq $nvidia "true" -}}
    {{/* https://github.com/truenas/middleware/blob/0bfc05166c3f95b1ab4ca4a9614691f14303db2e/src/middlewared/middlewared/plugins/kubernetes_linux/utils.py#L16 */}}
    {{- $runtime = "nvidia" -}}
  {{- end -}}

  {{- $runtime -}}
{{- end -}}
