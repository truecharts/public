{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "zammad.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "zammad.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "zammad.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "zammad.labels" -}}
helm.sh/chart: {{ include "zammad.chart" . }}
{{ include "zammad.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "zammad.selectorLabels" -}}
app.kubernetes.io/name: {{ include "zammad.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "zammad.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "zammad.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
autowizard secret name
*/}}
{{- define "zammad.autowizardSecretName" -}}
{{- if .Values.secrets.autowizard.useExisting -}}
{{ .Values.secrets.autowizard.secretName }}
{{- else -}}
{{ template "zammad.fullname" . }}-{{ .Values.secrets.autowizard.secretName }}
{{- end -}}
{{- end -}}

{{/*
elasticsearch secret name
*/}}
{{- define "zammad.elasticsearchSecretName" -}}
{{- if .Values.secrets.elasticsearch.useExisting -}}
{{ .Values.secrets.elasticsearch.secretName }}
{{- else -}}
{{ template "zammad.fullname" . }}-{{ .Values.secrets.elasticsearch.secretName }}
{{- end -}}
{{- end -}}

{{/*
postgresql secret name
*/}}
{{- define "zammad.postgresqlSecretName" -}}
{{- if .Values.secrets.postgresql.useExisting -}}
{{ .Values.secrets.postgresql.secretName }}
{{- else -}}
{{ template "zammad.fullname" . }}-{{ .Values.secrets.postgresql.secretName }}
{{- end -}}
{{- end -}}

{{/*
redis secret name
*/}}
{{- define "zammad.redisSecretName" -}}
{{- if .Values.secrets.redis.useExisting -}}
{{ .Values.secrets.redis.secretName }}
{{- else -}}
{{ template "zammad.fullname" . }}-{{ .Values.secrets.redis.secretName }}
{{- end -}}
{{- end -}}
