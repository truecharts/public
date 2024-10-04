{{/* Returns Scheduler Name */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.schedulerName" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.schedulerName" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $scheduler := "" -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.schedulerName -}}
    {{- $scheduler = tpl . $rootCtx -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- with $objectData.podSpec.schedulerName -}}
    {{- $scheduler = tpl . $rootCtx -}}
  {{- end -}}

  {{- $scheduler -}}
{{- end -}}
