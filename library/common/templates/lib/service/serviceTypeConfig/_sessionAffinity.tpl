{{/* Service - Session Affinity */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.service.sessionAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData: The service object data
*/}}

{{- define "tc.v1.common.lib.service.sessionAffinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- with $objectData.sessionAffinity -}}
    {{- $affinity := tpl . $rootCtx -}}
    {{- $affinities := (list "ClientIP" "None") -}}
    {{- if not (mustHas $affinity $affinities) -}}
      {{- fail (printf "Service - Expected [sessionAffinity] to be one of [%s], but got [%s]" (join ", " $affinities) $affinity) -}}
    {{- end }}
sessionAffinity: {{ $affinity }}
    {{- if eq $affinity "ClientIP" -}}
      {{- with $objectData.sessionAffinityConfig -}}
        {{- with .clientIP -}}

          {{- $timeout := .timeoutSeconds -}}
          {{- if kindIs "string" $timeout -}}
            {{- $timeout = tpl $timeout $rootCtx -}}
          {{- end -}}

          {{- $timeout = int $timeout -}}
          {{- if and $timeout (mustHas (kindOf $timeout) (list "float64" "int64" "int")) -}}
            {{- if or (lt $timeout 0) (gt $timeout 86400) -}}
              {{- fail (printf "Service - Expected [sessionAffinityConfig.clientIP.timeoutSeconds] to be between [0 - 86400], but got [%v]" $timeout) -}}
            {{- end }}
sessionAffinityConfig:
  clientIP:
    timeoutSeconds: {{ $timeout }}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
