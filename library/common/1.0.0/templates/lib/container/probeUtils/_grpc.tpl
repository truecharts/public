{{- define "ix.v1.common.container.probes.grpc" -}}
  {{- $probe := .probe -}}
  {{- $root := .root -}}

grpc:
  port: {{ $probe.port }}

  {{- include "ix.v1.common.container.probes.timeouts" (dict "probeSpec" $probe.spec "probeName" $probe.name) }}
{{- end -}}
