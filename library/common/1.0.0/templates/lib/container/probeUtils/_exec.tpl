{{/* Returns exec for the probe */}}
{{- define "ix.v1.common.container.probes.exec" -}}
  {{- $probe := .probe -}}
  {{- $root := .root -}}

  {{- if not $probe.command -}}
    {{- fail (printf "No commands were defined for EXEC type on probe (%s)" $probe.name) -}}
  {{- end }}

exec:
  command:
  {{- include "ix.v1.common.container.command" (dict "commands" $probe.command "root" $root) | trim | nindent 4 }}
  {{- include "ix.v1.common.container.probes.timeouts" (dict "probeSpec" $probe.spec "probeName" $probe.name) }}
{{- end -}}
