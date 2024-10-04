{{/* Service - ipFamily */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.ipFamily" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.ipFamily" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- with $objectData.ipFamilyPolicy -}}
    {{- $famPolicy := tpl . $rootCtx -}}

    {{- $stacks := (list "SingleStack" "PreferDualStack" "RequireDualStack") -}}
    {{- if not (mustHas $famPolicy $stacks) -}}
      {{- fail (printf "Service - Expected [ipFamilyPolicy] to be one of [%s], but got [%s]" (join ", " $stacks) $famPolicy) -}}
    {{- end }}
ipFamilyPolicy: {{ $famPolicy }}
  {{- end -}}

  {{- if and $objectData.ipFamilies (not (kindIs "slice" $objectData.ipFamilies)) -}}
    {{- fail (printf "Service - Expected [ipFamilies] to be a list, but got a [%s]" (kindOf $objectData.ipFamilies)) -}}
  {{- end -}}

  {{- with $objectData.ipFamilies }}
ipFamilies:
    {{- range . }}
      {{- $ipFam := tpl . $rootCtx -}}

      {{- $stacks := (list "IPv4" "IPv6") -}}
      {{- if not (mustHas $ipFam $stacks) -}}
        {{- fail (printf "Service - Expected [ipFamilies] to be one of [%s], but got [%s]" (join ", " $stacks) $ipFam) -}}
      {{- end }}
  - {{ $ipFam }}
    {{- end -}}
  {{- end -}}
{{- end -}}
