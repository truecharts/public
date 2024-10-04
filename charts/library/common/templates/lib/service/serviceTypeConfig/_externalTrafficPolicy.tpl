{{/* Service - externalTrafficPolicy */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.externalTrafficPolicy" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.externalTrafficPolicy" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

  {{- with $objectData.externalTrafficPolicy }}
    {{- $policy := tpl . $rootCtx -}}
    {{- $policies := (list "Cluster" "Local") -}}

    {{- if not (mustHas $policy $policies) -}}
      {{- fail (printf "Service - Expected [externalTrafficPolicy] to be one of [%s], but got [%s]" (join ", " $policies) $policy) -}}
    {{- end }}
externalTrafficPolicy: {{ $policy }}
  {{- end -}}

{{- end -}}
