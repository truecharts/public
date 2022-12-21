{{- define "ix.v1.common.controller.volumes.hostPath" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}

  {{- include "ix.v1.common.controller.volumes.hostPath.validation" (dict "volume" $vol "root" $root) }} {{/* hostPath validation (if enabled) */}}
- name: {{ $index }}
  hostPath:
    path: {{ required (printf "hostPath not set on item %s" $index) $vol.hostPath }}
  {{- with $vol.hostPathType -}}
    {{- $type := (tpl . $root) -}}
    {{- include "ix.v1.common.controller.hostPathType.validation" (dict "index" $index "type" $type) }}
    type: {{ $type }}
  {{- end -}}
{{- end -}}
