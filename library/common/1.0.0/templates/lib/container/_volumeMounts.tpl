{{/* Volume Mounts included by the container. */}}
{{- define "ix.v1.common.container.volumeMounts" -}}
  {{- range $name, $item := .Values.persistence -}}
    {{- if $item.enabled -}}
      {{- if not $item.noMount -}}
        {{- include "ix.v1.common.container.volumeMount" (dict "root" $ "item" $item "name" $name) | nindent 0 -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

{{/* TODO: write tests when statefulset is ready */}}
  {{- if eq .Values.controller.type "statefulset" -}}
    {{- range $index, $vct := .Values.volumeClaimTemplates -}}
      {{- include "ix.v1.common.container.volumeMount" (dict "root" $ "item" $vct "name" (toString $index)) | nindent 0  -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.container.volumeMount" -}}
  {{- $root := .root -}}
  {{- $item := .item -}}
  {{- $name := .name -}}

  {{- if not $item.mountPath -}} {{/* Make sure that we have a mountPath */}}
    {{- fail "<mountPath> must be defined, alternatively use the <noMount> flag." -}}
  {{- end -}}
- mountPath: {{ tpl $item.mountPath $root }}
  name: {{ tpl $name $root }}
  {{- with $item.subPath }}
  subPath: {{ tpl . $root }}
  {{- end -}}
  {{- if (hasKey $item "readOnly") -}}
    {{- if or (eq $item.readOnly true) (eq $item.readOnly false) }}
  readOnly: {{ $item.readOnly }}
    {{- else -}}
      {{- fail (printf "<readOnly> cannot be empty on item (%s)" $name) -}}
    {{- end -}}
  {{- end -}}
  {{- with $item.mountPropagation }}
  mountPropagation: {{ tpl . $root }}
  {{- end -}}
{{- end -}}
