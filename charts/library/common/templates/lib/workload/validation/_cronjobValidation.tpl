{{/* CronJob Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.cronjobValidation" (dict "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  completionMode: The completionMode of the object.
  completions: The completions of the object.
  parallelism: The parallelism of the object.
*/}}
{{- define "tc.v1.common.lib.workload.cronjobValidation" -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.concurrencyPolicy -}}
    {{- $concurrencyPolicy := $objectData.concurrencyPolicy -}}

    {{- $policies := (list "Allow" "Forbid" "Replace") -}}
    {{- if not (mustHas $concurrencyPolicy $policies) -}}
      {{- fail (printf "CronJob - Expected [concurrencyPolicy] to be one of [%s], but got [%v]" (join ", " $policies) $concurrencyPolicy) -}}
    {{- end -}}

  {{- end -}}

  {{- if not $objectData.schedule -}}
    {{- fail "CronJob - Expected non-empty [schedule]" -}}
  {{- end -}}

  {{/* CronJob contains a job inside, so we validate job values too */}}
  {{- include "tc.v1.common.lib.workload.jobValidation" (dict "objectData" $objectData) -}}
{{- end -}}
