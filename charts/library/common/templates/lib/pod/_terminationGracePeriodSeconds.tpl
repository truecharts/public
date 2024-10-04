{{/* Returns Termination Grace Period Seconds */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.terminationGracePeriodSeconds" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.terminationGracePeriodSeconds" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $gracePeriod := "" -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.terminationGracePeriodSeconds -}}
    {{- $gracePeriod = . -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- with $objectData.podSpec.terminationGracePeriodSeconds -}}
    {{- $gracePeriod = . -}}
  {{- end -}}

  {{/* Expand tpl */}}
  {{- if (kindIs "string" $gracePeriod) -}}
    {{- $gracePeriod = tpl $gracePeriod $rootCtx -}}
  {{- end -}}

  {{- $gracePeriod -}}
{{- end -}}
