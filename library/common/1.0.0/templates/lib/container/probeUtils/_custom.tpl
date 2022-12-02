{{- define "ix.v1.common.container.probes.custom" -}}
  {{- $probe := .probe -}}
  {{- $root := .root -}}

{{- $probe.spec | toYaml }}
{{- end -}}
