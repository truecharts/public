{{- define "ix.v1.common.controller.volumes.secret" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $objectName := tpl (required (printf "objectName not set for persistence item %s" (toString $index)) $vol.objectName) $root }}
- name: {{ $index }}
  secret:
    secretName: {{ $objectName }}
  {{- with $vol.defaultMode }}
    {{- $defMode := tpl (toString .) $root -}}
    {{- if (mustRegexMatch "^[0-9]{4}$" $defMode) }} {{/* TODO: Document that "0700" equals to 448 in octal, k8s accepts both */}}
    defaultMode: {{ $defMode }} {{/* TODO: But because when octal values pass from go variables they covert to octal, we require them as string to avoid confusion */}}
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
