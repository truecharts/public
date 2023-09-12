{{/* Define the configmap */}}
{{- define "watcharr.configmaps" -}}

watcharr-env:
  enabled: true
  data:
    .env: |
      # empty
{{- end -}}
