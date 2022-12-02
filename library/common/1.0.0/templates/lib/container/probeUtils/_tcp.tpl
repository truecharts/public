{{- define "ix.v1.common.container.probes.tcp" -}}
  {{- $probe := .probe -}}
  {{- $root := .root -}}

tcpSocket:
  port: {{ $probe.port }}

  {{- include "ix.v1.common.container.probes.timeouts" (dict "probeSpec" $probe.spec "probeName" $probe.name) }}
{{- end -}}
