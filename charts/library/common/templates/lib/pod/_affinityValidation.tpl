{{- define "tc.v1.common.lib.pod.affinity.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.podAffinity -}}
    {{- include "tc.v1.common.lib.pod.affinity.validation.podAffinityOrPodAntiAffinity" (dict "rootCtx" $rootCtx "data" $objectData.podAffinity "key" "podAffinity") -}}
  {{- end -}}

  {{- if $objectData.podAntiAffinity -}}
    {{- include "tc.v1.common.lib.pod.affinity.validation.podAffinityOrPodAntiAffinity" (dict "rootCtx" $rootCtx "data" $objectData.podAntiAffinity "key" "podAntiAffinity") -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.affinity.validation.podAffinityOrPodAntiAffinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data -}}
  {{- $key := .key -}}

  {{- if $data -}}
    {{- if and (not $data.requiredDuringSchedulingIgnoredDuringExecution) (not $data.preferredDuringSchedulingIgnoredDuringExecution) -}}
      {{- fail (printf "Affinity - Expected at least one of requiredDuringSchedulingIgnoredDuringExecution or preferredDuringSchedulingIgnoredDuringExecution in [affinity.%s]" $key) -}}
    {{- end -}}

    {{- if $data.requiredDuringSchedulingIgnoredDuringExecution -}}
      {{- $itemData := $data.requiredDuringSchedulingIgnoredDuringExecution -}}
      {{- if not (kindIs "slice" $itemData) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.requiredDuringSchedulingIgnoredDuringExecution] to be a slice but got [%s]" $key (kindOf $itemData)) -}}
      {{- end -}}

      {{- range $idx, $item := $itemData -}}
        {{- include "tc.v1.common.lib.pod.affinity.validation.podAffinityTerm" (dict "rootCtx" $rootCtx "data" $item "key" (printf "%s.requiredDuringSchedulingIgnoredDuringExecution.%d" $key $idx)) -}}
      {{- end -}}
    {{- end -}}

    {{- if $data.preferredDuringSchedulingIgnoredDuringExecution -}}
      {{- $itemData := $data.preferredDuringSchedulingIgnoredDuringExecution -}}

      {{- if not (kindIs "slice" $itemData) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.preferredDuringSchedulingIgnoredDuringExecution] to be a slice but got [%s]" $key (kindOf $itemData)) -}}
      {{- end -}}

      {{- range $idx, $item := $itemData -}}
        {{- if not (mustHas (kindOf $item.weight) (list "int" "int64" "float64")) -}}
          {{- fail (printf "Affinity - Expected [affinity.%s.preferredDuringSchedulingIgnoredDuringExecution.%d.weight] to be a number but got [%s]" $key $idx (kindOf $item.weight)) -}}
        {{- end -}}

        {{- if or (gt ($item.weight | int) 100) (lt ($item.weight | int) 0) -}}
          {{- fail (printf "Affinity - Expected [affinity.%s.preferredDuringSchedulingIgnoredDuringExecution.%d.weight] to be between 0 and 100 but got [%d]" $key $idx ($item.weight | int)) -}}
        {{- end -}}

        {{- if not $item.podAffinityTerm -}}
          {{- fail (printf "Affinity - Expected [affinity.%s.preferredDuringSchedulingIgnoredDuringExecution.%d.podAffinityTerm] to be defined" $key $idx) -}}
        {{- end -}}

        {{- include "tc.v1.common.lib.pod.affinity.validation.podAffinityTerm" (dict "rootCtx" $rootCtx "data" $item.podAffinityTerm "key" (printf "%s.preferredDuringSchedulingIgnoredDuringExecution.%d.podAffinityTerm" $key $idx)) -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.affinity.validation.podAffinityTerm" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data -}}
  {{- $key := .key -}}

  {{- if not (kindIs "string" $data.topologyKey) -}}
    {{- fail (printf "Affinity - Expected [affinity.%s.topologyKey] to be a string but got [%s]" $key (kindOf $data.topologyKey)) -}}
  {{- end -}}

  {{- if $data.matchLabelKeys -}}
    {{- if not (kindIs "slice" $data.matchLabelKeys) -}}
      {{- fail (printf "Affinity - Expected [affinity.%s.matchLabelKeys] to be a slice but got [%s]" $key (kindOf $data.matchLabelKeys)) -}}
    {{- end -}}

    {{- range $idx, $value := $data.matchLabelKeys -}}
      {{- if not (kindIs "string" $value) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchLabelKeys.%d] to be a string but got [%s]" $key $idx (kindOf $value)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.mismatchLabelKeys -}}
    {{- if not (kindIs "slice" $data.mismatchLabelKeys) -}}
      {{- fail (printf "Affinity - Expected [affinity.%s.mismatchLabelKeys] to be a slice but got [%s]" $key (kindOf $data.mismatchLabelKeys)) -}}
    {{- end -}}

    {{- range $idx, $value := $data.mismatchLabelKeys -}}
      {{- if not (kindIs "string" $value) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.mismatchLabelKeys.%d] to be a string but got [%s]" $key $idx (kindOf $value)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.namespaces -}}
    {{- if not (kindIs "slice" $data.namespaces) -}}
      {{- fail (printf "Affinity - Expected [affinity.%s.namespaces] to be a slice but got [%s]" $key (kindOf $data.namespaces)) -}}
    {{- end -}}

    {{- range $idx, $value := $data.namespaces -}}
      {{- if not (kindIs "string" $value) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.namespaces.%d] to be a string but got [%s]" $key $idx (kindOf $value)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.labelSelector -}}
    {{- include "tc.v1.common.lib.pod.affinity.validation.labelSelector" (dict "rootCtx" $rootCtx "key" (printf "%s.labelSelector" $key) "data" $data.labelSelector) -}}
  {{- end -}}

  {{- if $data.namespaceSelector -}}
    {{- include "tc.v1.common.lib.pod.affinity.validation.labelSelector" (dict "rootCtx" $rootCtx "key" (printf "%s.namespaceSelector" $key) "data" $data.namespaceSelector) -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.affinity.validation.labelSelector" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $key := .key -}}
  {{- $data := .data -}}

  {{- if not (kindIs "map" $data) -}}
    {{- fail (printf "Affinity - Expected [affinity.%s] to be a map but got [%s]" $key (kindOf $data)) -}}
  {{- end -}}

  {{- if $data.matchLabels -}}
    {{- if not (kindIs "map" $data.matchLabels) -}}
      {{- fail (printf "Affinity - Expected [affinity.%s.matchLabels] to be a map but got [%s]" $key (kindOf $data.matchLabels)) -}}
    {{- end -}}

    {{- range $key, $value := $data.matchLabels -}}
      {{- if not (kindIs "string" $value) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchLabels.%s] to be a string but got [%s]" $key $key (kindOf $value)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $data.matchExpressions }}
    {{- if not (kindIs "slice" $data.matchExpressions) -}}
      {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions] to be a slice but got [%s]" $key (kindOf $data.matchExpressions)) -}}
    {{- end -}}

    {{- $validOperators := list "In" "NotIn" "Exists" "DoesNotExist" -}}
    {{- range $idx, $exp := $data.matchExpressions -}}
      {{- if not (kindIs "map" $exp) -}}
        {{- fail (printf "Affinity - Expected item of [affinity.%s.matchExpressions.%d] to be a map but got [%s]" $key $idx (kindOf $exp)) -}}
      {{- end -}}

      {{- if not (mustHas $exp.operator $validOperators) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.operator] to be one of [%s] but got [%s]" $key $idx (join ", " $validOperators) $exp.operator) -}}
      {{- end -}}

      {{- if not (kindIs "string" $exp.key) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.key] to be a string but got [%s]" $key $idx (kindOf $exp.key)) -}}
      {{- end -}}

      {{- if and (mustHas $exp.operator (list "In" "NotIn")) (not (kindIs "slice" $exp.values)) -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.values] to be a slice but got [%s]" $key $idx (kindOf $exp.values)) -}}
      {{- end -}}

      {{- if and (mustHas $exp.operator (list "Exists" "DoesNotExist")) $exp.values -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.values] to be empty when operator is Exists or DoesNotExist but got [%v]" $key $idx ($exp.values)) -}}
      {{- else if not $exp.values -}}
        {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.values] to be defined when operator is In or NotIn but got [%s]" $key $idx (kindOf $exp.values)) -}}
      {{- end -}}

      {{- range $vIdx, $value := $exp.values -}}
        {{- if not (kindIs "string" $value) -}}
          {{- fail (printf "Affinity - Expected [affinity.%s.matchExpressions.%d.values.%d] to be a string but got [%s]" $key $idx $vIdx (kindOf $value)) -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
