{{/* Define the configmap */}}
{{- define "eco.configmaps" -}}

{{- $network := .Values.eco.network -}}

eco-network:
  enabled: true
  data:
    Network.eco: |
      {{ $network | toJson }}

{{- end -}}
