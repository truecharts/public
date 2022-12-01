{{/* Volume Mounts included by the container. */}}
{{- define "ix.v1.common.container.volumeMounts" -}}
  {{- range $index, $item := .Values.persistence -}}
    {{- if $item.enabled -}}
      {{- if not $item.noMount -}}
        {{- if not $item.mountPath -}} {{/* Make sure that we have a mountPath */}}
          {{- fail "<mountPath> must be defined, alternatively use the <noMount> flag." -}}
        {{- end }}
- mountPath: {{ tpl $item.mountPath $ }}
  name: {{ tpl $index $ }}
        {{- with $item.subPath }}
  subPath: {{ tpl . $ }}
        {{- end -}}
        {{- if (hasKey $item "readOnly") }}
  readOnly: {{ $item.readOnly }}
        {{- end -}}
        {{- with $item.mountPropagation }}
  mountPropagation: {{ tpl . $ }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end }}

{{/* TODO: write tests when statefulset is ready */}}
  {{- if eq .Values.controller.type "statefulset" -}}
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
      {{- if not $vct.mountPath -}} {{/* Make sure that we have a mountPath */}}
        {{- fail "<mountPath> must be defined, alternatively use the <noMount> flag." -}}
      {{- end -}}
- mountPath: {{ $vct.mountPath }}
  name: {{ tpl (toString $index) $ }}
      {{- with $vct.subPath }}
  subPath: {{ tpl . $ }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
