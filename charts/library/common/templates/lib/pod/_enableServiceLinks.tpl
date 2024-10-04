{{/* Returns enableServiceLinks */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.enableServiceLinks" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.enableServiceLinks" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $enableServiceLinks := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.enableServiceLinks) -}}
    {{- $enableServiceLinks = $rootCtx.Values.podOptions.enableServiceLinks -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- if (kindIs "bool" $objectData.podSpec.enableServiceLinks) -}}
    {{- $enableServiceLinks = $objectData.podSpec.enableServiceLinks -}}
  {{- end -}}

  {{- $enableServiceLinks -}}
{{- end -}}
