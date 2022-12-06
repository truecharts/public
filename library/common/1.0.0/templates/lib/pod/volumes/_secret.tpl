{{- define "ix.v1.common.controller.volumes.secret" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $objectName := tpl (required (printf "objectName not set for persistence item %s" (toString $index)) $vol.objectName) $root }}
- name: {{ $index }}
  secret:
    secretName: {{ $objectName }}
  {{- with $vol.defaultMode }}
    defaultMode: {{ tpl (toString .) $root }}
  {{- end -}}
  {{- with $vol.items }}
    items:
    {{- range . }}
      - key: {{ tpl (required (printf "No key was given for persistence item %s" (toString $index)) .key) $root }}
        path: {{ tpl (required (printf "No path was given for persistence item %s" (toString $index)) .path) $root }}
    {{- end -}}
  {{- end -}}
{{- end -}}
