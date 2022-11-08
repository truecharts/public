{{/*
Return the appropriate apiVersion for deployment
*/}}
{{- define "ix.v1.common.capabilities.deployment.apiVersion" -}}
    {{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for statefulset
*/}}
{{- define "ix.v1.common.capabilities.statefulset.apiVersion" -}}
    {{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for daemonset
*/}}
{{- define "ix.v1.common.capabilities.daemonset.apiVersion" -}}
    {{- print "apps/v1" -}}
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
