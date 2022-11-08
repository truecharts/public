{{/*
These annotations will be shared on all objects
Rendered under ".metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations" -}}
  {{- with .Values.global.annotations -}}
    {{- range $k, $v := . }}
{{ $k }}: {{ tpl $v $ | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
These annotations will be applied to all "workload" "spec" objects
Rendered under ".spec.template.metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations.workload.spec" -}}
  {{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.ixExternalInterfacesConfigurationNames }}
  {{- end }}
{{- end -}}

{{/*
These annotations will be applied to all "workload" objects
Rendered under ".metadata.annotations"
*/}}
{{- define "ix.v1.common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}

{{/*
Workloads = Deployment, ReplicaSet, StatefulSet, DaemonSet, Job, CronJob, etc
*/}}
