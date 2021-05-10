{{/*
DNS Configuration
*/}}
{{- define "common.networking.dnsConfiguration" }}
{{ if .Values.dnsPolicy }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{ end }}
{{ if .Values.dnsConfig }}
dnsConfig:
  {{ toYaml .Values.dnsConfig | nindent 2 }}
{{ end }}
{{- end }}
