{{/* Define the secret */}}
{{- define "splunk.secret" -}}

{{- $splunkSecret := printf "%s-splunk-config" (include "tc.v1.common.lib.chart.names.fullname" .) }}
{{- $argList := list -}}

{{- if .Values.splunk.acceptLicense -}}
  {{- $argList = append $argList "--accept-license" -}}
{{- end -}}

{{- with .Values.splunk.extraArgs -}}
  {{- range . -}}
    {{- $argList = append $argList . -}}
  {{- end -}}
{{- end }}

enabled: true
data:
  {{- with $argList }}
  SPLUNK_START_ARGS: {{ join " " . | quote }}
  {{- end }}

  {{- with .Values.splunk.password }}
  SPLUNK_PASSWORD: {{ . }}
  {{- end }}
{{- end -}}
