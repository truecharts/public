{{- define "ix.v1.common.controller.volumes.configMap" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $objectName := tpl (required (printf "objectName not set for persistence item %s" (toString $index)) $vol.objectName) $root }}
- name: {{ tpl (toString $index) $root }}
  configMap:
    name: {{ $objectName }}
  {{- with $vol.defaultMode }}
    {{- $defMode := tpl (toString .) $root -}}
    {{- if (mustRegexMatch "^[0-9]{4}$" $defMode) }}
    defaultMode: {{ $defMode }}
    {{- else -}}
      {{- fail (printf "<defaultMode> (%s, converted to octal) is not valid format. Valid format is string with 4 digits <0777>." $defMode) -}}
    {{- end -}}
  {{- end -}}
  {{- with $vol.items }}
    items:
    {{- range . }}
      - key: {{ tpl (required (printf "No key was given for persistence item %s" (toString $index)) .key) $root }}
        path: {{ tpl (required (printf "No path was given for persistence item %s" (toString $index)) .path) $root }}
    {{- end -}}
  {{- end -}}
{{- end -}}
