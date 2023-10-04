{{/* Define the configmap */}}
{{- define "ring.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $ring := .Values.ring -}}

ring-config:
  enabled: true
  data:
    config.json: |
      {{ $ring | toJson }}

{{- end -}}
