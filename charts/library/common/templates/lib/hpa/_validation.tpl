{{- define "tc.v1.common.lib.hpa.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $minReplicas := 1 -}}
  {{- with $objectData.minReplicas -}}
    {{- if not (mustHas (kindOf $objectData.minReplicas) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Expected [hpa.%s.minReplicas] to be an integer, but got [%s]" $objectData.name (kindOf $objectData.minReplicas)) -}}
    {{- end -}}
    {{- $minReplicas = $objectData.minReplicas -}}
  {{- end -}}

  {{- $maxReplicas := 3 -}}
  {{- with $objectData.maxReplicas -}}
    {{- if not (mustHas (kindOf $objectData.maxReplicas) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Expected [hpa.%s.maxReplicas] to be an integer, but got [%s]" $objectData.name (kindOf $objectData.maxReplicas)) -}}
    {{- end -}}
    {{- $maxReplicas = $objectData.maxReplicas -}}
  {{- end -}}

  {{- if lt $maxReplicas $minReplicas -}}
    {{- fail (printf "Expected [hpa.%s.minReplicas] to be less than [hpa.%s.maxReplicas], but got [%d] and [%d]" $objectData.name $objectData.name $minReplicas $maxReplicas) -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.hpa.validation.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "mode" "up") -}}
  {{- include "tc.v1.common.lib.hpa.validation.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "mode" "down") -}}

{{- end -}}

{{- define "tc.v1.common.lib.hpa.validation.behavior" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $mode := .mode -}}

  {{- $key := ternary "scaleUp" "scaleDown" (eq $mode "up") -}}
  {{- $data := get $objectData.behavior $key -}}

  {{- if $data -}}
    {{- if $data.selectPolicy -}}
      {{- $validSelectPolicies := list "Max" "Min" "Disabled" -}}
      {{- if not (mustHas $data.selectPolicy $validSelectPolicies) -}}
        {{- fail (printf "Expected [hpa.%s.behavior.%s.selectPolicy] to be one of [%s], but got [%s]" $objectData.name $key (join ", " $validSelectPolicies) $data.selectPolicy) -}}
      {{- end -}}
    {{- end -}}

    {{- if not (mustHas (kindOf $data.stabilizationWindowSeconds) (list "int" "int64" "float64")) -}}
      {{- fail (printf "Expected [hpa.%s.behavior.%s.stabilizationWindowSeconds] to be an integer, but got [%s]" $objectData.name $key (kindOf $data.stabilizationWindowSeconds)) -}}
    {{- end -}}

    {{- if $data.policies -}}
      {{- if not (kindIs "slice" $data.policies) -}}
        {{- fail (printf "Expected [hpa.%s.behavior.%s.policies] to be a list, but got [%s]" $objectData.name $key (kindOf $data.policies)) -}}
      {{- end -}}

      {{- $validPolicies := list "Pods" "Percent" -}}
      {{- range $idx, $policy := $data.policies -}}
        {{- if not (kindIs "map" $policy) -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d] to be a map, but got [%s]" $objectData.name $key $idx (kindOf $policy)) -}}
        {{- end -}}

        {{- if not (mustHas $policy.type $validPolicies) -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d.type] to be one of [%s], but got [%s]" $objectData.name $key $idx (join ", " $validPolicies) $policy.type) -}}
        {{- end -}}

        {{- if not (mustHas (kindOf $policy.value) (list "int" "int64" "float64")) -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d.value] to be an integer, but got [%s]" $objectData.name $key $idx (kindOf $policy.value)) -}}
        {{- end -}}

        {{- if not (mustHas (kindOf $policy.periodSeconds) (list "int" "int64" "float64")) -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d.periodSeconds] to be an integer, but got [%s]" $objectData.name $key $idx (kindOf $policy.periodSeconds)) -}}
        {{- end -}}

        {{- if le $policy.value 0 -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d.value] to be greater than 0, but got [%v]" $objectData.name $key $idx $policy.value) -}}
        {{- end -}}

        {{- if or (lt $policy.periodSeconds 1) (gt $policy.periodSeconds 1800) -}}
          {{- fail (printf "Expected [hpa.%s.behavior.%s.policies.%d.periodSeconds] to be between 1 and 1800, but got [%v]" $objectData.name $key $idx $policy.periodSeconds) -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
