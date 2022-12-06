{{- define "ix.v1.common.controller.volumes.nfs" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root }}
- name: {{ tpl (toString $index) $root }}
  nfs:
    server: {{ required (printf "NFS Server not set on item %s" $index) $vol.server }}
    path: {{ required (printf "NFS Path not set on item %s" $index) $vol.path }}
{{- end -}}
