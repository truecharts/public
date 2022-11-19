{{/* Returns grpc for the probe */}}
{{- define "ix.v1.common.container.probes.grpc" -}}
  {{- $probe := .probe -}}
  {{- $containerName := .containerName -}}
  {{- $root := .root -}}

  {{- if not $probe.port -}}
    {{- fail (printf "<port> must be defined for <grpc> probe types in probe (%s) in (%s) container." $probe.name $containerName) -}}
  {{- end }}

grpc:
  port: {{ $probe.port }}

  {{- include "ix.v1.common.container.probes.timeouts"  (dict "probeSpec" $probe.spec
                                                              "probeName" $probe.name
                                                              "root" $root
                                                              "containerName" $containerName) }}
{{- end -}}
