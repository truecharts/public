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

  {{- $nvidia := false -}}

  {{- if and ($rootCtx.Values.resources) ($rootCtx.Values.resources.limits) -}}
    {{- if gt ((get $rootCtx.Values.resources.limits "nvidia.com/gpu") | int) 0 -}}
      {{- $nvidia = true -}}
    {{- end -}}
  {{- end -}}

  {{- range $rootCtx.Values.workload -}}
    {{- if not .podSpec -}}
      {{- continue -}}
    {{- end -}}

    {{- range $k, $v := .podSpec.containers -}}
      {{- if or (not $v.resources) (not $v.resources.limits) -}}
        {{- continue -}}
      {{- end -}}

      {{- if gt ((get $v.resources.limits "nvidia.com/gpu") | int) 0 -}}
        {{- $nvidia = true -}}
        {{- break -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $nvidia -}}
    {{/* https://github.com/truenas/middleware/blob/0bfc05166c3f95b1ab4ca4a9614691f14303db2e/src/middlewared/middlewared/plugins/kubernetes_linux/utils.py#L16 */}}
    {{- $runtime = "nvidia" -}}
  {{- end -}}

  {{/* Keep backwards compat with .scaleGPU */}}
  {{- if $rootCtx.Values.global.ixChartContext.addNvidiaRuntimeClass -}}
    {{- range $rootCtx.Values.scaleGPU -}}
      {{- if .gpu -}} {{/* Make sure it has a value... */}}
        {{- $scaleGPU := false -}}
        {{- range $k, $v := .gpu -}}
          {{- if $v -}} {{/* Make sure value is not "0" or "" */}}
            {{- $scaleGPU = true -}}
            {{- break -}}
          {{- end -}}
        {{- end -}}

        {{- if $scaleGPU -}}

          {{- if (kindIs "map" .targetSelector) -}}
            {{- range $podName, $containers := .targetSelector -}}

              {{- if eq $objectData.shortName $podName -}} {{/* If the pod is selected */}}
                {{- $runtime = $rootCtx.Values.global.ixChartContext.nvidiaRuntimeClassName -}}
              {{- end -}}

            {{- end -}}
          {{- else if $objectData.primary -}}
            {{/* If the pod is primary and no targetSelector is given, assign to primary */}}
            {{- $runtime = $rootCtx.Values.global.ixChartContext.nvidiaRuntimeClassName -}}
          {{- end -}}

        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $runtime -}}
{{- end -}}
