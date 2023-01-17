{{- define "ix.v1.common.spawner.jobAndCronJob" -}}
  {{- $jobs := dict -}}

  {{- if eq .Values.controller.type "Job" -}}
    {{- $jobValues := dict -}}

    {{- $_ := set $jobValues "enabled" true -}}
    {{- $_ := set $jobValues "podSpec" dict -}}

    {{- range $key := (list "cron" "labels" "annotations") -}}
      {{- if hasKey $.Values $key -}}
        {{- $_ := set $jobValues $key (get $.Values $key) -}}
      {{- end -}}
    {{- end -}}

    {{- $_ := set $jobValues.podSpec "containers" dict -}}
    {{- $_ := set $jobValues.podSpec.containers "main" .Values -}}
    {{- $_ := set $jobValues.podSpec.containers.main "enabled" "true" -}}

    {{- $_ := unset $jobValues.podSpec.containers.main "probes" -}}
    {{- $_ := unset $jobValues.podSpec.containers.main "lifecycle" -}}

    {{- if not $jobValues.nameOverride -}}
      {{- $_ := set $jobValues "nameOverride" (include "ix.v1.common.names.fullname" $) -}}
    {{- end -}}

    {{- $_ := set $jobs "main" $jobValues -}}
  {{- else -}}
    {{- $jobs = .Values.jobs -}}
  {{- end -}}

  {{- range $jobName, $job := $jobs -}}
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
