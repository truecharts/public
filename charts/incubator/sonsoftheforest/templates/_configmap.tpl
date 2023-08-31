{{/* Define the configmap */}}
{{- define "sonsoftheforest.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $sonsoftheforest := .Values.sonsoftheforest -}}

sonsoftheforest-config:
  enabled: true
  data:
    dedicatedserver.cfg: |
      {{ $sonsoftheforest | toJson }}

{{- end -}}
