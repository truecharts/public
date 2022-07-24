{{/*
Return the appropriate apiVersion for DaemonSet objects.
*/}}
{{- define "common.capabilities.daemonset.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for Deployment objects.
*/}}
{{- define "common.capabilities.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for StatefulSet objects.
*/}}
{{- define "common.capabilities.statefulset.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for StatefulSet objects.
*/}}
{{- define "common.capabilities.cronjob.apiVersion" -}}
{{- print "batch/v1beta1" -}}
{{- end -}}
