{{- define "ix.v1.common.controller.volumes.hostPath" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root }}
- name: {{ $index }}
  hostPath:
    path: {{ required (printf "hostPath not set on item %s" $index) $vol.hostPath }}
  {{- with $vol.hostPathType }}
    type: {{ tpl . $root }}
  {{- end -}}
{{- end -}}
