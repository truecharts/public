{{- define "ix.v1.common.validate.job" -}}
  {{- $root := .root -}}
  {{- $job := .job -}}

  {{- $default := $root.Values.global.defaults.job -}}
  {{- $name := $job.nameOverride -}}

  {{- if hasKey $job "backoffLimit" -}}
    {{- if $job.backoffLimit -}}
      {{- if or (not (mustHas (kindOf $job.backoffLimit) (list "int" "float64"))) (lt (int $job.backoffLimit) 0) -}}
        {{- fail (printf "<backoffLimit> (%d) in <job> (%s) must be a positive integer. Leave empty to use the default (%d)" (int $job.backoffLimit) $name (int $default.backoffLimit)) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $job.backoffLimit) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <backoffLimit> (%d) in <job> (%s) is not allowed. Leave empty to use the default (%d)" (int $job.backoffLimit) $name (int $default.backoffLimit)) -}}
    {{- end -}}
  {{- end -}}

  {{- if hasKey $job "ttlSecondsAfterFinished" -}}
    {{- if $job.ttlSecondsAfterFinished -}}
      {{- if or (not (mustHas (kindOf $job.ttlSecondsAfterFinished ) (list "int" "float64"))) (lt (int $job.ttlSecondsAfterFinished) 0) -}}
        {{- fail (printf "<ttlSecondsAfterFinished> (%d) in <job> (%s) must be a positive integer." (int $job.ttlSecondsAfterFinished) $name) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $job.ttlSecondsAfterFinished) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <ttlSecondsAfterFinished> (%d) in <job> (%s) is not allowed." (int $job.ttlSecondsAfterFinished) $name) -}}
    {{- end -}}
  {{- end -}}

  {{- if hasKey $job "activeDeadlineSeconds" -}}
    {{- if $job.activeDeadlineSeconds -}}
      {{- if or (not (mustHas (kindOf $job.activeDeadlineSeconds) (list "int" "float64"))) (lt (int $job.activeDeadlineSeconds) 0) -}}
        {{- fail (printf "<activeDeadlineSeconds> (%d) in <job> (%s) must be a positive integer." (int $job.activeDeadlineSeconds) $name) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $job.activeDeadlineSeconds) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <activeDeadlineSeconds> (%d) in <job> (%s) is not allowed." (int $job.activeDeadlineSeconds) $name) -}}
    {{- end -}}
  {{- end -}}

  {{- if hasKey $job "parallelism" -}}
    {{- if $job.parallelism -}}
      {{- if or (not (mustHas (kindOf $job.parallelism) (list "int" "float64"))) (lt (int $job.parallelism) 0) -}}
        {{- fail (printf "<parallelism> (%d) in <job> (%s) must be a positive integer." (int $job.parallelism) $name) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $job.parallelism) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <parallelism> (%d) in <job> (%s) is not allowed." (int $job.parallelism) $name) -}}
    {{- end -}}
  {{- end -}}

  {{- if hasKey $job "completions" -}}
    {{- if $job.completions -}}
      {{- if or (not (mustHas (kindOf $job.completions) (list "int" "float64"))) (lt (int $job.completions) 0) -}}
        {{- fail (printf "<completions> (%d) in <job> (%s) must be a positive integer." (int $job.completions) $name) -}}
      {{- end -}}
    {{- else if not (kindIs "invalid" $job.completions) -}} {{/* Don't fail when type is "invalid". Just skip it */}}
      {{- fail (printf "Zero value in <completions> (%d) in <job> (%s) is not allowed." (int $job.completions) $name) -}}
    {{- end -}}
  {{- end -}}

  {{- with $job.completionMode -}}
    {{- if not (mustHas . (list "NonIndexed" "Indexed")) -}}
      {{- fail (printf "Invalid option (%s) for <completionMode> in <job> (%s). Valid options are NonIndexed and Indexed. Leave empty to use the default (%s)" . $name $default.completionMode) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
{{/* TODO: Unit Tests */}}
