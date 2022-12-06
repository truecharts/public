{{- define "ix.v1.common.controller.volumes.ixVols" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root }}
- name: {{ tpl (toString $index) $root }}

{{- end -}}
