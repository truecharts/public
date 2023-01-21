{{- define "ix.v1.common.controller.volumes.hostPath" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}

  {{- include "ix.v1.common.controller.volumes.hostPath.validation" (dict "volume" $vol "root" $root) -}} {{/* hostPath validation (if enabled) */}}
  {{- if not $vol.hostPath -}}
    {{- fail (printf "hostPath not set on item (%s)" $index) -}}
  {{- else if not (hasPrefix "/" $vol.hostPath) -}}
    {{- fail (printf "Host path (%s) on item (%s) must start with a forward slash -> / <-" $vol.hostPath $index) -}}
  {{- end }}
- name: {{ $index }}
  hostPath:
    path: {{ $vol.hostPath }}
  {{- with $vol.hostPathType -}}
    {{- $type := (tpl . $root) -}}
    {{- include "ix.v1.common.controller.hostPathType.validation" (dict "index" $index "type" $type) }}
    type: {{ $type }}
  {{- end -}}
{{- end -}}
