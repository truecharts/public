{{/* StatefulSet Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.statefulsetValidation" (dict "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  strategy: The strategy of the object.
  rollingUpdate: The rollingUpdate of the object.
*/}}
{{- define "tc.v1.common.lib.workload.statefulsetValidation" -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.strategy -}}
    {{- $strategy := $objectData.strategy -}}

    {{- $strategies := (list "OnDelete" "RollingUpdate") -}}
    {{- if not (mustHas $strategy $strategies) -}}
      {{- fail (printf "StatefulSet - Expected [strategy] to be one of [%s], but got [%v]" (join ", " $strategies) $strategy) -}}
    {{- end -}}

  {{- end -}}

  {{- if $objectData.rollingUpdate -}}
    {{- $rollUp := $objectData.rollingUpdate -}}

    {{- if and $rollUp (not (kindIs "map" $rollUp)) -}}
      {{- fail (printf "StatefulSet - Expected [rollingUpdate] to be a dictionary, but got [%v]" (kindOf $rollUp)) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
