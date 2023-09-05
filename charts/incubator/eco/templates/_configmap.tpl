{{/* Define the configmap */}}
{{- define "eco.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $network := .Values.eco.network -}}

eco-network:
  enabled: true
  data:
    Network.eco: |
      {{ $network | toJson }}

{{- end -}}
