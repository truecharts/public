{{- define "tc.v1.common.lib.priorityclass.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $validPolicies := (list "PreemptLowerPriority" "Never") -}}
  {{- if $objectData.preemptionPolicy -}}
    {{- if not (mustHas $objectData.preemptionPolicy $validPolicies) -}}
      {{- fail (printf "Priority Class - Expected [preemptionPolicy] to be one of [%s], but got [%s]" (join ", " $validPolicies) $objectData.preemptionPolicy) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
