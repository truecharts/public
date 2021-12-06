{{/*
Expand the name of the chart.
*/}}
{{- define "common.names.name" -}}
{{- $values := (.common | default dict) -}}
{{- $name := (default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-") }}
{{- if hasKey $values "nameSuffix" -}}
  {{- $name = (printf "%v-%v" $name $values.nameSuffix) -}}
{{ end -}}
{{- print $name -}}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "common.names.fullname" -}}
{{- $values := (.common | default dict) -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- $name = (.Release.Name | trunc 63 | trimSuffix "-") }}
{{- else }}
{{- $name = (printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-") }}
{{- end }}
{{- if hasKey $values "nameSuffix" -}}
  {{- $name = (printf "%v-%v" $name $values.nameSuffix) -}}
{{ end -}}
{{- print $name -}}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common.names.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Determine service account name for deployment or statefulset.
*/}}
{{- define "common.names.serviceAccountName" -}}
{{- if .Values.serviceAccountNameOverride }}
{{- .Values.serviceAccountNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-service-account" (include "common.names.releaseName" .) | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}


{{/*
Determine release name
This will add a suffix to the release name if nameSuffix is set
*/}}
{{- define "common.names.releaseName" -}}
{{- $values := (.common | default dict) -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- printf "%v-%v" .Release.Name $values.nameSuffix -}}
{{- else -}}
  {{- print .Release.Name -}}
{{ end -}}
{{- end -}}
