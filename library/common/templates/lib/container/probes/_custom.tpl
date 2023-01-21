{{/* Returns a custom defined for the probe */}}
{{- define "ix.v1.common.container.probes.custom" -}}
  {{- $probe := .probe -}}
  {{- $containerName := .containerName -}}
  {{- $root := .root -}}

  {{- if not $probe.spec -}}
    {{- fail (printf "<spec> must be defined for <custom> probe types in probe (%s) in (%s) container." $probe.name $containerName) -}}
  {{- end }}
{{- $probe.spec | toYaml }}
{{- end -}}
