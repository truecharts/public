{{/* Define the secrets */}}
{{- define "dashy.config" -}}
configmap:
  dashy-config:
    enabled: true
    data:
      conf.yml: |
    {{- .Values.dashyConfig | toYaml | nindent 8 }}
{{- end -}}
