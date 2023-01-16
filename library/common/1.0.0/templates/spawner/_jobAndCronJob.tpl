{{- define "ix.v1.common.spawner.jobAndCronJob" -}}
  {{- range $jobName, $job := .Values.jobs -}}
    {{- if $job.enabled -}}

      {{- $jobValues := $job -}}
      {{- if not $jobValues.nameOverride -}}
        {{- $_ := set $jobValues "nameOverride" $jobName -}}
      {{- end -}}

      {{- if hasKey $job "cron" -}}
        {{- if $job.cron.enabled -}}
          {{- include "ix.v1.common.class.cronJob" (dict "root" $ "job" $jobValues) -}}
        {{- end -}}
      {{- else -}}
        {{- include "ix.v1.common.class.job" (dict "root" $ "job" $jobValues) -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
