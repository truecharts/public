{{/* Returns termination */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.termination" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.termination" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $termination := (dict "messagePath" "" "messagePolicy" "") -}}

  {{- with $objectData.termination -}}
    {{- with .messagePath -}}
      {{- $_ := set $termination "messagePath" (tpl . $rootCtx) -}}
    {{- end -}}

    {{- with .messagePolicy -}}

      {{- $policy := (tpl . $rootCtx) -}}

      {{- $policies := (list "File" "FallbackToLogsOnError") -}}
      {{- if not (mustHas $policy $policies) -}}
        {{- fail (printf "Container - Expected [termination.messagePolicy] to be one of [%s], but got [%s]" (join ", " $policies) $policy) -}}
      {{- end -}}

      {{- $_ := set $termination "messagePolicy" $policy -}}
    {{- end -}}

  {{- end -}}

  {{- $termination | toJson -}}
{{- end -}}
