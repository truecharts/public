{{/* Returns the job spec, used in both job and cronJob */}}
{{- define "ix.v1.common.lib.job" -}}
  {{- $root := .root -}}
  {{- $job := .job -}}

  {{- $default := $root.Values.global.defaults.job -}}

  {{- include "ix.v1.common.validate.job" (dict "root" $root "job" $job) -}}

  {{- $backoffLimit := $default.backoffLimit -}}
  {{- if mustHas (kindOf $job.backoffLimit) (list "int" "float64") -}}
    {{- $backoffLimit = $job.backoffLimit -}}
  {{- end }}
backoffLimit: {{ $backoffLimit }}
{{- with $job.ttlSecondsAfterFinished }}
ttlSecondsAfterFinished: {{ . }}
{{- end }}
{{- with $job.activeDeadlineSeconds }}
activeDeadlineSeconds: {{ . }}
{{- end }}
{{- with $job.parallelism }}
parallelism: {{ . }}
{{- end }}
{{- with $job.completions }}
completions: {{ . }}
{{- end }}
completionMode: {{ $job.completionMode | default $default.completionMode }}
template:
  spec:
  {{/* TODO: create the job spec (containers) */}}
{{- end -}}
{{/* TODO: Unit Tests */}}
