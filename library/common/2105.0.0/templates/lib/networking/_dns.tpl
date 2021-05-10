{{/*
DNS Configuration
*/}}
{{- define "common.networking.dnsConfiguration" }}
dnsPolicy: {{ .Values.dnsPolicy }}
{{- if .Values.dnsConfig }}
dnsConfig:
  {{- toYaml .Values.dnsConfig | nindent 2 }}
{{- end }}
{{- end }}
