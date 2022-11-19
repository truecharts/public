{{- define "ix.v1.common.controller.volumes.nfs" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- if not $vol.path  -}}
    {{- fail (printf "NFS Path not set on item %s" $index) -}}
  {{- else if not (hasPrefix "/" $vol.path ) -}}
    {{- fail (printf "NFS path (%s) on (%s) must start with a forward slash -> / <-" $vol.path $index) -}}
  {{- end }}
- name: {{ $index }}
  nfs:
    server: {{ required (printf "NFS Server not set on item %s" $index) $vol.server }}
    path: {{ $vol.path }}
{{- end -}}
