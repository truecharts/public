{{/* Define the configmap */}}
{{- define "eco.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $eco := .Values.eco -}}

eco-config:
  enabled: true
  data:
    Network.eco: |
      {{ $eco | toJson }}

{{- end -}}
