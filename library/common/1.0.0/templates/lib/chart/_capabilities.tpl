{{/* Return the appropriate apiVersion for deployment */}}
{{- define "ix.v1.common.capabilities.deployment.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for statefulset */}}
{{- define "ix.v1.common.capabilities.statefulset.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for daemonset */}}
{{- define "ix.v1.common.capabilities.daemonset.apiVersion" -}}
  {{- print "apps/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for CronJob */}}
{{- define "ix.v1.common.capabilities.cronJob.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Job */}}
{{- define "ix.v1.common.capabilities.job.apiVersion" -}}
  {{- print "batch/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Job */}}
{{- define "ix.v1.common.capabilities.serviceAccount.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for clusterRole */}}
{{- define "ix.v1.common.capabilities.clusterRole.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for role */}}
{{- define "ix.v1.common.capabilities.role.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for roleBinding */}}
{{- define "ix.v1.common.capabilities.roleBinding.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for clusterRoleBinding */}}
{{- define "ix.v1.common.capabilities.clusterRoleBinding.apiVersion" -}}
  {{- print "rbac.authorization.k8s.io/v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for service */}}
{{- define "ix.v1.common.capabilities.service.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}

{{/* Return the appropriate apiVersion for endpoints */}}
{{- define "ix.v1.common.capabilities.endpoints.apiVersion" -}}
  {{- print "v1" -}}
{{- end -}}
