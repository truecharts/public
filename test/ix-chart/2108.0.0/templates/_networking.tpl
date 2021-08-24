{{/*
DNS Configuration
*/}}
{{- define "dnsConfiguration" }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{- if .Values.dnsConfig }}
dnsConfig:
  {{- toYaml .Values.dnsConfig | nindent 2 }}
{{- end }}
{{- end }}
