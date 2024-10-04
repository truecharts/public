{{/* Metadata Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.podDisruptionBudget.validation" (dict "objectData" $objectData "caller" $caller) -}}
objectData:
  labels: The labels of the configmap.
  annotations: The annotations of the configmap.
  data: The data of the configmap.
*/}}

{{- define "tc.v1.common.lib.podDisruptionBudget.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if and $objectData.targetSelector (not (kindIs "string" $objectData.targetSelector)) -}}
    {{- fail (printf "Pod Disruption Budget - Expected [targetSelector] to be [string], but got [%s]" (kindOf $objectData.targetSelector)) -}}
  {{- end -}}

  {{- if and (not $objectData.targetSelector) (not $objectData.customLabels) -}}
    {{- fail (printf "Pod Disruption Budget - Expected one of [targetSelector, customLabels] to be defined in [podDisruptionBudget.%s]" $objectData.shortName) -}}
  {{- end -}}

  {{- if and $objectData.targetSelector $objectData.customLabels -}}
    {{- fail (printf "Pod Disruption Budget - Expected only one of [targetSelector, customLabels] to be defined in [podDisruptionBudget.%s]" $objectData.shortName) -}}
  {{- end -}}

  {{- with $objectData.unhealthyPodEvictionPolicy -}}
    {{- $policies := (list "IfHealthyBudget" "AlwaysAllow") -}}
    {{- if not (mustHas (tpl . $rootCtx) $policies) -}}
      {{- fail (printf "Pod Disruption Budget - Expected [unhealthyPodEvictionPolicy] to be one of [%s], but got [%s]" (join ", " $policies) .) -}}
    {{- end -}}
  {{- end -}}

  {{- $hasKey := false -}}
  {{- $keys := (list "minAvailable" "maxUnavailable") -}}
  {{- range $key := $keys -}}
    {{- if hasKey $objectData $key -}}
      {{- $hasKey = true -}}
      {{- if kindIs "invalid" (get $objectData $key) -}}
        {{- fail (printf "Pod Disruption Budget - Expected the defined key [%v] in [podDisruptionBudget.%s] to not be empty" $key $objectData.shortName) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if and ($objectData.minAvailable) ($objectData.maxUnavailable) -}}
    {{- fail (printf "Pod Disruption Budget - Expected one of [%s] to be defined in [podDisruptionBudget.%s], but got both" (join ", " $keys) $objectData.shortName) -}}
  {{- end -}}

  {{- if not $hasKey -}}
    {{- fail (printf "Pod Disruption Budget - Expected at least one of [%s] to be defined in [podDisruptionBudget.%s]" (join ", " $keys) $objectData.shortName) -}}
  {{- end -}}

{{- end -}}
