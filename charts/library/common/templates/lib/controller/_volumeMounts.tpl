{{/* Volumes included by the controller */}}
{{- define "common.controller.volumeMounts" -}}
  {{- range $index, $item := .Values.persistence }}
  {{- if not $item.noMount }}
    {{- $mountPath := (printf "/%v" $index) -}}
    {{- if eq "hostPath" (default "pvc" $item.type) -}}
      {{- $mountPath = $item.hostPath -}}
    {{- end -}}
    {{- with $item.mountPath -}}
      {{- $mountPath = . -}}
    {{- end }}
    {{- if and $item.enabled (ne $mountPath "-") }}
- mountPath: {{ $mountPath }}
  name: {{ $index }}
      {{- with $item.subPath }}
  subPath: {{ . }}
      {{- end }}
      {{- with $item.readOnly }}
  readOnly: {{ . }}
      {{- end }}
      {{- with $item.mountPropagation }}
  mountPropagation: {{ . }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- end }}

  {{- if eq .Values.controller.type "statefulset" }}
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
    {{- $vctname := $index }}
    {{- if $vct.name }}
    {{- $vctname := $vct.name }}
    {{- end }}
    {{- if not $vct.noMount }}
- mountPath: {{ $vct.mountPath }}
  name: {{ $vctname }}
      {{- if $vct.subPath }}
  subPath: {{ $vct.subPath }}
      {{- end }}
    {{- end }}
    {{- end }}
  {{- end }}


{{- end -}}
