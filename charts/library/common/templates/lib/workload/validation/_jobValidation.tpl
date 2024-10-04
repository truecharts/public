{{/* Job Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.jobValidation" (dict "objectData" $objectData) -}}
rootCtx: The root context of the chart.
objectData:
  completionMode: The completionMode of the object.
  completions: The completions of the object.
  parallelism: The parallelism of the object.
*/}}
{{- define "tc.v1.common.lib.workload.jobValidation" -}}
  {{- $objectData := .objectData -}}

  {{- if $objectData.completionMode -}}
    {{- $completionMode := $objectData.completionMode -}}

    {{- if not (mustHas $completionMode (list "Indexed" "NonIndexed")) -}}
      {{- fail (printf "Job - Expected [completionMode] to be one of [Indexed, NonIndexed], but got [%v]" $completionMode) -}}
    {{- end -}}

    {{- if eq $completionMode "Indexed" -}}
      {{- if not $objectData.completions -}}
        {{- fail "Job - Expected [completions] to be set when [completionMode] is set to [Indexed]" -}}
      {{- end -}}

      {{- if not $objectData.parallelism -}}
        {{- fail "Job - Expected [parallelism] to be set when [completionMode] is set to [Indexed]" -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}

{{- end -}}
