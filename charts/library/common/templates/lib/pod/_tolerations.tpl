{{/* Returns Tolerations */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.tolerations" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.tolerations" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $tolerations := list -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.tolerations -}}
    {{- $tolerations = . -}}
  {{- end -}}

  {{/* Override from the "pod" option */}}
  {{- with $objectData.podSpec.tolerations -}}
    {{- $tolerations = . -}}
  {{- end -}}

  {{- range $tolerations -}}
    {{/* Expand values */}}
    {{- $operator := (tpl (.operator | default "") $rootCtx) -}}
    {{- $key := (tpl (.key | default "") $rootCtx) -}}
    {{- $value := (tpl (.value | default "") $rootCtx) -}}
    {{- $effect := (tpl (.effect | default "") $rootCtx) -}}
    {{- $tolSeconds := .tolerationSeconds -}}

    {{- $operators := (list "Exists" "Equal") -}}
    {{- if not (mustHas $operator $operators) -}}
      {{- fail (printf "Expected [tolerations.operator] to be one of [%s] but got [%s]" (join ", " $operators) $operator) -}}
    {{- end -}}

    {{- if and (eq $operator "Equal") (or (not $key) (not $value)) -}}
      {{- fail "Expected non-empty [tolerations.key] and [tolerations.value] with [tolerations.operator] set to [Equal]" -}}
    {{- end -}}

    {{- if and (eq $operator "Exists") $value -}}
      {{- fail (printf "Expected empty [tolerations.value] with [tolerations.operator] set to [Exists], but got [%s]" $value) -}}
    {{- end -}}

    {{- $effects := (list "NoExecute" "NoSchedule" "PreferNoSchedule") -}}
    {{- if and $effect (not (mustHas $effect $effects)) -}}
      {{- fail (printf "Expected [tolerations.effect] to be one of [%s], but got [%s]" (join ", " $effects) $effect) -}}
    {{- end -}}

    {{- if and (not (kindIs "invalid" $tolSeconds)) (not (mustHas (kindOf $tolSeconds) (list "int" "int64" "float64"))) -}}
      {{- fail (printf "Expected [tolerations.tolerationSeconds] to be a number, but got [%v]" $tolSeconds) -}}
    {{- end }}
- operator: {{ $operator }}
    {{- with $key }}
  key: {{ $key }}
    {{- end -}}
    {{- with $effect }}
  effect: {{ $effect }}
    {{- end -}}
    {{- with $value }}
  value: {{ . }}
    {{- end -}}
    {{- if (mustHas (kindOf $tolSeconds) (list "int" "int64" "float64")) }}
  tolerationSeconds: {{ $tolSeconds }}
    {{- end -}}

  {{- end -}}
{{- end -}}
