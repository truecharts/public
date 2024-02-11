{{/* Define the configmap */}}
{{- define "rcon_cli_web.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $servers := .Values.rcon_cli_web.servers -}}

rcon-config:
  enabled: true
  data:
    rcon.yaml: |
     {{- toYaml $servers | nindent 2 }}
{{- end -}}
