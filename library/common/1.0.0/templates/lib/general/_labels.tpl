{{/* Common labels shared across objects */}}
{{- define "ix.v1.common.labels" -}}
helm.sh/chart: {{ include "ix.v1.common.names.chart" . }}
{{ include "ix.v1.common.labels.selectorLabels" . }}
  {{- if .Chart.AppVersion }}
helm-revision: {{ .Release.Revision | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
  {{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
  {{- include "ix.v1.common.util.labels.render" (dict "root" . "labels" .Values.global.labels) -}}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{/* TODO: Check why "app" and "release" are needed (ported from the current common) */}}
{{- define "ix.v1.common.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ix.v1.common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: {{ include "ix.v1.common.names.name" . }}
release: {{ .Release.Name }}
{{- end -}}
