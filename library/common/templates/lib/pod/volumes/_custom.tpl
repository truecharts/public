{{- define "ix.v1.common.controller.volumes.custom" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- if not $vol.volumeSpec -}}
    {{- fail (printf "You have defined custom persistence type but no <volumeSpec> was given on item (%s)" $index) -}}
  {{- end }}
- name: {{ $index }}
  {{- tpl ( toYaml $vol.volumeSpec ) $root | nindent 2 -}}
{{- end -}}
