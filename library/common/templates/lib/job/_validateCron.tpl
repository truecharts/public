{{- define "ix.v1.common.validate.cronJob" -}}
  {{- $root := .root -}}
  {{- $job := .job -}}

  {{- $default := $root.Values.global.defaults.job.cron -}}
  {{- $cron := $job.cron -}}
  {{- $name := $job.nameOverride -}}

  {{- if not $cron.schedule -}}
    {{- fail (printf "<cron.schedule> is required in <job> (%s)" $name) -}}
  {{- end -}}

  {{- if not (kindIs "string" $cron.schedule) -}}
    {{- fail (printf "<cron.schedule> must be a string in <job> (%s)" $name) -}}
  {{- end -}}

  {{- with $cron.timezone -}}
    {{- if not (kindIs "string" .) -}}
      {{- fail (printf "<cron.timezone> must be a string in <job> (%s). Leave empty to use the default (%s)" $name $root.Values.TZ) -}}
    {{- end -}}
  {{- end -}}

  {{- with $cron.concurrencyPolicy -}}
    {{- if not (mustHas . (list "Allow" "Forbid" "Replace")) -}}
      {{- fail (printf "Invalid option (%s) for <cron.concurrencyPolicy> in <job> (%s). Valid options are Allow, Forbid, Replace. Leave empty to use the default (%s)" . $name $default.concurrencyPolicy) -}}
    {{- end -}}
  {{- end -}}

  {{- with $cron.failedJobsHistoryLimit -}}
    {{- if or (not (mustHas (kindOf .) (list "int" "float64"))) (lt (int .) 0) -}}
      {{- fail (printf "<cron.failedJobsHistoryLimit> (%d) in <job> (%s) must be a positive integer. Leave empty to use (%d)" (int .) $name (int $default.failedJobsHistoryLimit)) -}}
    {{- end -}}
  {{- end -}}

  {{- with $cron.successfulJobsHistoryLimit -}}
    {{- if or (not (mustHas (kindOf .) (list "int" "float64"))) (lt (int .) 0) -}}
      {{- fail (printf "<cron.successfulJobsHistoryLimit> (%d) in <job> (%s) must be a positive integer. Leave empty to use (%d)" (int .) $name (int $default.successfulJobsHistoryLimit)) -}}
    {{- end -}}
  {{- end -}}

  {{- if hasKey $cron "startingDeadlineSeconds" -}}
    {{- if $cron.startingDeadlineSeconds -}}
      {{- if or (not (mustHas (kindOf $cron.startingDeadlineSeconds) (list "int" "float64"))) (lt (int $cron.startingDeadlineSeconds) 0) -}}
        {{- fail (printf "<cron.startingDeadlineSeconds> (%d) in <job> (%s) must be a positive integer." (int $cron.startingDeadlineSeconds) $name) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $cron.startingDeadlineSeconds) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <cron.startingDeadlineSeconds> (%d) in <job> (%s) is not allowed." (int $cron.startingDeadlineSeconds) $name) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
