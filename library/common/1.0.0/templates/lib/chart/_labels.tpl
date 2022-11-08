{{/* Common labels shared across objects */}}
{{- define "ix.v1.common.labels" -}}
helm.sh/chart: {{ include "ix.v1.common.names.chart" . }}
{{ include "ix.v1.common.labels.selectorLabels" . }}
{{- if .Chart.AppVersion }}
helm-revision: {{ .Release.Revision | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.labels }}
  {{- range $k, $v := . }}
{{ $k }}: {{ tpl $v $ | quote }}
    {{- end }}
{{- end }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "ix.v1.common.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ix.v1.common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
