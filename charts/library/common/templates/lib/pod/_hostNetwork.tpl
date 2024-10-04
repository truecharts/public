{{/* Returns Host Network */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.hostNetwork" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostNet := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.hostNetwork) -}}
    {{- $hostNet = $rootCtx.Values.podOptions.hostNetwork -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- if (kindIs "bool" $objectData.podSpec.hostNetwork) -}}
    {{- $hostNet = $objectData.podSpec.hostNetwork -}}
  {{- end -}}

  {{- $hostNet -}}
{{- end -}}
