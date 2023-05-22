{{/* Returns Host PID */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.hostPID" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.hostPID" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $hostPID := false -}}

  {{/* Initialize from the "global" option */}}
  {{- if (kindIs "bool" $rootCtx.Values.podOptions.hostPID) -}}
    {{- $hostPID = $rootCtx.Values.podOptions.hostPID -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- if (kindIs "bool" $objectData.podSpec.hostPID) -}}
    {{- $hostPID = $objectData.podSpec.hostPID -}}
  {{- end -}}

  {{- $hostPID -}}
{{- end -}}
