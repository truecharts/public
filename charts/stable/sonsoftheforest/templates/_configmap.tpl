{{/* Define the configmap */}}
{{- define "sonsoftheforest.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $server := .Values.sonsoftheforest.server -}}

sonsoftheforest-dscfg:
  enabled: true
  data:
    dedicatedserver.cfg: |
      {{ $server | toJson }}

{{- end -}}
