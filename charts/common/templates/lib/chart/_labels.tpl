{{/* Common labels shared across objects */}}
{{- define "tc.common.labels" -}}
helm.sh/chart: {{ include "tc.common.names.chart" . }}
{{ include "tc.common.labels.selectorLabels" . }}
{{- if .Chart.AppVersion }}
helm-revision: "{{ .Release.Revision }}"
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.global.labels }}
  {{- range $k, $v := . }}
    {{- $name := $k }}
    {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
{{- end }}
{{- end -}}

{{/* Selector labels shared across objects */}}
{{- define "tc.common.labels.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tc.common.names.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
