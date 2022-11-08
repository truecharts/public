{{/*
These annotations will be shared on all objects
*/}}
{{- define "ix.common.annotations" -}}
  {{- with .Values.global.annotations -}}
    {{- range $k, $v := . }}
{{ $k }}: {{ tpl $v $ | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
These annotations will be applied to all workload "spec" objects
*/}}
{{- define "ix.common.annotations.workload.spec" -}}
  {{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.ixExternalInterfacesConfigurationNames }}
  {{- end }}
{{- end -}}

{{/*
These annotations will be applied to all workload objects
*/}}
{{- define "ix.common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}

{{/*
Workloads = Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, CronJob, etc
*/}}
