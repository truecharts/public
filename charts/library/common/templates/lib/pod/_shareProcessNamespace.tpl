{{/* Returns Share Process Namespace */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.shareProcessNamespace" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.shareProcessNamespace" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $shareProcessNamespace := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.shareProcessNamespace) -}}
    {{- $shareProcessNamespace = $rootCtx.Values.podOptions.shareProcessNamespace -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- if (kindIs "bool" $objectData.podSpec.shareProcessNamespace) -}}
    {{- $shareProcessNamespace = $objectData.podSpec.shareProcessNamespace -}}
  {{- end -}}

  {{- $shareProcessNamespace -}}
{{- end -}}
