{{/*
Check if workload type is a deployment
*/}}
{{- define "workloadIsDeployment" }}
{{- if eq .Values.workloadType "Deployment" }}
{{- true -}}
{{- else }}
{{- false -}}
{{- end }}
{{- end }}

{{/*
Check if workload type is a cronjob
*/}}
{{- define "workloadIsCronJob" }}
{{- if eq .Values.workloadType "CronJob" }}
{{- true -}}
{{- else }}
{{- false -}}
{{- end }}
{{- end }}

{{/*
Get API Version based on workload type
*/}}
{{- define "apiVersion" -}}
{{- if eq (include "workloadIsDeployment" .) "true" }}
{{- printf "apps/v1" }}
{{- else if eq (include "workloadIsCronJob" .) "true" }}
{{- printf "batch/v1beta1" }}
{{- else }}
{{- printf "batch/v1" }}
{{- end }}
{{- end }}


{{/*
Get Restart policy based on workload type
*/}}
{{- define "restartPolicy" -}}
{{- if eq (include "workloadIsDeployment" .) "true" }}
{{- print "Always" }}
{{- else }}
{{- printf "%s" .Values.jobRestartPolicy }}
{{- end }}
{{- end }}


{{/*
Pod specification
*/}}
{{- define "podSepc" }}
restartPolicy: {{ template "restartPolicy" . }}
hostNetwork: {{ template "hostNetworkingConfiguration" . }}
containers:
- name: {{ .Chart.Name }}
  {{- include "volumeMountsConfiguration" . | indent 2}}
  securityContext:
    {{- toYaml .Values.securityContext | nindent 12 }}
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default "latest" }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  {{- include "containerCommand" . | indent 2 }}
  {{- include "containerArgs" . | indent 2 }}
  {{- include "containerEnvVariables" . | indent 2 }}
  {{- include "containerLivenssProbe" . | indent 2 }}
  {{- include "containerPorts" . | indent 2 }}
  {{- include "containerResourceConfiguration" . | indent 2 }}
{{- include "volumeConfiguration" . }}
{{- include "dnsConfiguration" . }}
{{- end }}


{{/*
Annotations for workload
*/}}
{{- define "workloadAnnotations" }}
rollme: {{ randAlphaNum 5 | quote }}
{{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.ixExternalInterfacesConfigurationNames }}
{{- end }}
{{- end }}


{{/*
Metadata for workload
*/}}
{{- define "commonMetadataWorkload" }}
labels:
  {{- include "ix-chart.selectorLabels" . | nindent 2 }}
annotations:
  {{- include "workloadAnnotations" . | nindent 2 }}
{{- end }}

{{/*
Deployment Spec
*/}}
{{- define "deploymentSpec" }}
strategy:
  {{- if and (eq .Values.updateStrategy "RollingUpdate") .Values.hostPortsList }}
  {{- fail "RollingUpdate is not allowed when host ports are specified" }}
  {{- end }}
  type: {{ .Values.updateStrategy }}
selector:
  matchLabels:
    {{- include "ix-chart.selectorLabels" . | nindent 4 }}
template:
  metadata:
    {{ include "commonMetadataWorkload" . | nindent 4 }}
  spec:
    {{- include "podSepc" . | indent 4 }}
{{- end }}


{{/*
Job Spec Common
*/}}
{{- define "jobSpecCommon" }}
metadata:
  {{ include "commonMetadataWorkload" . | nindent 4 }}
spec:
  {{- include "podSepc" . | indent 2 }}
{{- end }}


{{/*
Job Spec
*/}}
{{- define "jobSpec" }}
template:
{{ include "jobSpecCommon" . | nindent 2 }}
{{- end }}

{{/*
CronJob Spec
*/}}
{{- define "cronJobSpec" }}
schedule: {{ include "cronExpression" .Values.cronSchedule | quote }}
jobTemplate:
  spec:
    {{ include "jobSpec" . | nindent 4 }}
{{- end }}
