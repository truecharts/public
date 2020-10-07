{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "ix-chart.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "ix-chart.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ix-chart.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "ix-chart.labels" -}}
helm.sh/chart: {{ include "ix-chart.chart" . }}
{{ include "ix-chart.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "ix-chart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ix-chart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "ix-chart.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "ix-chart.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

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
{{- printf "%s" .Values.restartPolicy }}
{{- else }}
{{- printf "%s" .Values.jobRestartPolicy }}
{{- end }}
{{- end }}
