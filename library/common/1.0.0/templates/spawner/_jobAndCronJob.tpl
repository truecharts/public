{{- define "ix.v1.common.spawner.jobAndCronJob" -}}
  {{- $jobs := dict -}}

  {{- if mustHas .Values.controller.type (list "Job" "CronJob") -}}
    {{- $jobValues := dict -}}

    {{/* Controller holds Job/CronJob Configuration */}}
    {{- $jobValues = $.Values.controller -}}

    {{/* If it's CronJob prepare the cron dict with enabled forced */}}
    {{- if eq $.Values.controller.type "CronJob" -}}
      {{- $_ := set $jobValues "cron" $.Values.controller -}}
      {{- $_ := set $jobValues.cron "enabled" true -}}
    {{- end -}}

    {{/* Enable the Job/CronJob and create a podSpec */}}
    {{- $_ := set $jobValues "enabled" true -}}
    {{- $_ := set $jobValues "podSpec" dict -}}

    {{/* Add labels/annotations if any. */}}
    {{- range $key := (list "labels" "annotations") -}}
      {{- if hasKey $.Values.controller $key -}}
        {{- $_ := set $jobValues $key (get $.Values.controller $key) -}}
      {{- end -}}
    {{- end -}}

    {{/* Add the .Values as the main container */}}
    {{- $_ := set $jobValues.podSpec "containers" dict -}}
    {{- $_ := set $jobValues.podSpec.containers "main" .Values -}}
    {{- $_ := set $jobValues.podSpec.containers.main "enabled" "true" -}}

    {{/* Add additional containers if any */}}
    {{- range $name, $container := .Values.additionalContainers -}}
      {{- if $container.enabled -}}
        {{- $_ := set $jobValues.podSpec.containers $name $container -}}
      {{- end -}}
    {{- end -}}

    {{/* Remove probes and lifecycle as they are not supported on Jobs/Crons */}}
    {{- $_ := unset $jobValues.podSpec.containers.main "probes" -}}
    {{- $_ := unset $jobValues.podSpec.containers.main "lifecycle" -}}

    {{- if not $jobValues.nameOverride -}}
      {{- $_ := set $jobValues "nameOverride" (include "ix.v1.common.names.fullname" $) -}}
    {{- end -}}
    {{/* Add $jobValues to a "main" $job, now the spawner has the "usual" format */}}
    {{- $_ := set $jobs "main" $jobValues -}}

  {{- else -}}

    {{/* If it's not "standalone" Use the jobs dict */}}
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
