{{/*
Return the appropriate apiVersion for controllers
*/}}
{{- define "ix.v1.common.capabilities.controller.apiVersion" -}}
  {{- if eq .Values.controller.type "deployment" -}}
    {{- print "apps/v1" -}}
  {{- else if eq .Values.controller.type "daemonset" -}}
    {{- print "apps/v1" -}}
  {{- else if eq .Values.controller.type "statefulset" -}}
    {{- print "apps/v1" -}}
  {{- else -}}
    {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) -}}
  {{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for CronJob
*/}}
{{- define "ix.v1.common.capabilities.cronJob.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Job
*/}}
{{- define "ix.v1.common.capabilities.job.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}
