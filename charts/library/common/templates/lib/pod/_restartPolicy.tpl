{{/* Returns Restart Policy */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.restartPolicy" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.restartPolicy" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $policy := "Always" -}}

  {{/* Initialize from the "defaults" */}}
  {{- with $rootCtx.Values.podOptions.restartPolicy -}}
    {{- $policy = tpl . $rootCtx -}}
  {{- end -}}

  {{/* Override from the pod values, if defined */}}
  {{- with $objectData.podSpec.restartPolicy -}}
    {{- $policy = tpl . $rootCtx -}}
  {{- end -}}

  {{- $policies := (list "Never" "Always" "OnFailure") -}}
  {{- if not (mustHas $policy $policies) -}}
    {{- fail (printf "Expected [restartPolicy] to be one of [%s] but got [%s]" (join ", " $policies) $policy) -}}
  {{- end -}}

  {{- $types := (list "Deployment" "DaemonSet" "StatefulSet") -}}
  {{- if and (ne "Always" $policy) (mustHas $objectData.type $types) -}}
    {{- fail (printf "Expected [restartPolicy] to be [Always] for [%s] but got [%s]" $objectData.type $policy) -}}
  {{- end -}}

  {{- $policy -}}
{{- end -}}
