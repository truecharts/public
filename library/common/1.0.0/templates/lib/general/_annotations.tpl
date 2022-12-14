{{/* Workloads = Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, CronJob, etc */}}

{{/*
These annotations will be shared on all objects
Rendered under ".metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations" -}}
  {{- include "ix.v1.common.util.annotations.render" (dict "root" . "annotations" .Values.global.annotations) -}}
{{- end -}}

{{/*
These annotations will be applied to all "workload" "spec" objects
Rendered under ".spec.template.metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations.workload.spec" -}}
  {{- if .Values.ixExternalInterfacesConfiguration -}}
    {{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.ixExternalInterfacesConfigurationNames }}
    {{- else -}}
      {{- fail "There are externalInterfaces defined, but key <ixExternalInterfaceConfigurationNames> is empty." -}}
    {{- end }}
  {{- end -}}
{{- end -}}

{{/*
These annotations will be applied to all "workload" objects
Rendered under ".metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}
