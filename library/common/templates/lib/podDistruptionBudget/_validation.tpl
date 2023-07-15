{{/* Metadata Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.podDisruptionBudget.validation" (dict "objectData" $objectData "caller" $caller) -}}
objectData:
  labels: The labels of the configmap.
  annotations: The annotations of the configmap.
  data: The data of the configmap.
*/}}

{{- define "tc.v1.common.lib.podDisruptionBudget.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $caller := .caller -}}

  {{- with $objectData.unhealthyPodEvictionPolicy -}}
    {{- $policies := (list "IfHealthyBudget" "AlwaysAllow") -}}
    {{- if not (mustHas . $policies) -}}
      {{- fail (printf "Pod Disruption Budget - Expected <unhealthyPodEvictionPolicy> to be one of [%s], but got [%s]" (join ", " $policies) .) -}}
    {{- end -}}
  {{- end -}}

  {{- $keys := (list "minAvailable" "maxUnavailable") -}}
  {{- range $key := $keys -}}
    {{- if hasKey $key $objectData -}}
      {{- if kindIs "invalid" (get $objectData $key) -}}
        {{- fail (printf "Pod Disruption Budget - Expected the defined key [%v] in <podDisruptionBudget.%s> to not be empty" $key $key) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
