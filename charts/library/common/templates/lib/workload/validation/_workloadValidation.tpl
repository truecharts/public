{{/* Workload Basic Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.workload.primaryValidation" $ -}}
*/}}
{{- define "tc.v1.common.lib.workload.primaryValidation" -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{/* Go over workload */}}
  {{- range $name, $workload := .Values.workload -}}

    {{/* If workload is enabled */}}
    {{- if $workload.enabled -}}

      {{- $types := (list "Deployment" "StatefulSet" "DaemonSet" "Job" "CronJob") -}}
      {{- if not (mustHas $workload.type $types) -}}
        {{- fail (printf "Workload - Expected [type] to be one of [%s], but got [%s]" (join ", " $types) $workload.type) -}}
      {{- end -}}

      {{- $hasEnabled = true -}}

      {{/* And workload is primary */}}
      {{- if $workload.primary -}}
        {{/* Fail if there is already a primary workload */}}
        {{- if $hasPrimary -}}
          {{- fail "Workload - Only one workload can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}

  {{/* Require at one primary workload, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Workload - One enabled workload must be primary" -}}
  {{- end -}}

{{- end -}}
