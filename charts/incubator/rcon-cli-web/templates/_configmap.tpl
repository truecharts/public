{{/* Define the configmap */}}
{{- define "rcon_cli_web.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $servers := .Values.rcon_cli_web.servers -}}
{{- $logs := .Values.persistence.logs.mountPath -}}

rcon-config:
  enabled: true
  data:
    rcon.yaml: |
    {{- range $server := $servers -}}
     {{ $server.name }}:
      address: {{ $server.address_port }}
      password: {{ $server.password }}
      type: {{ $server.type }}
      timeout: {{ $server.timeout }}
      log: {{- printf "%s/rcon-%s.log" $logs $server.name -}}
      {{- end -}}
{{- end -}}
