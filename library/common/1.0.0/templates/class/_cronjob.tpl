{{- define "ix.v1.common.class.cronJob" -}}
  {{- $job := .job -}}
  {{- $root := .root -}}

  {{- $default := $root.Values.global.defaults.job.cron -}}
  {{- $jobName := include "ix.v1.common.names.jobAndCronJob" (dict "root" $root "jobValues" $job) -}}
  {{- include "ix.v1.common.validate.cronJob" (dict "root" $root "job" $job) -}}

  {{- $failLimit := $default.failedJobsHistoryLimit -}}
  {{- if (mustHas (kindOf $job.cron.failedJobsHistoryLimit) (list "int" "float64")) -}}
    {{- $failLimit = $job.cron.failedJobsHistoryLimit -}}
  {{- end -}}

  {{- $successLimit := $default.successfulJobsHistoryLimit -}}
  {{- if (mustHas (kindOf $job.cron.successfulJobsHistoryLimit) (list "int" "float64")) -}}
    {{- $successLimit = $job.cron.successfulJobsHistoryLimit -}}
  {{- end }}
---
apiVersion: {{ include "ix.v1.common.capabilities.cronJob.apiVersion" . }}
kind: CronJob
metadata:
  name: {{ $jobName }}
  {{- $labels := (mustMerge ($job.cron.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($job.cron.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  schedule: {{ $job.cron.schedule | quote }}
  timeZone: {{ $job.cron.timezone | default $root.Values.TZ }}
  concurrencyPolicy: {{ $job.cron.concurrencyPolicy | default $default.concurrencyPolicy }}
  failedJobsHistoryLimit: {{ $failLimit }}
  successfulJobsHistoryLimit: {{ $successLimit }}
  {{- with $job.cron.startingDeadLineSeconds }}
  startingDeadLineSeconds: {{ . }}
  {{- end }}
  jobTemplate:
    spec:
  {{- include "ix.v1.common.lib.job" (dict "root" $root "job" $job) | indent 6 -}}
{{- end -}}
{{/* TODO: Unit Tests */}}
