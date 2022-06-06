{{/* Volumes included by the controller */}}
{{- define "tc.common.controller.volumeMounts" -}}
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
- mountPath: {{ tpl $mountPath $ }}
  name: {{ tpl $index $ }}
      {{- with $item.subPath }}
  subPath: {{ tpl . $ }}
      {{- end }}
      {{- with $item.readOnly }}
  readOnly: {{ . }}
      {{- end }}
      {{- with $item.mountPropagation }}
  mountPropagation: {{ tpl . $ }}
      {{- end }}
    {{- end }}
  {{- end }}
  {{- end }}

  {{- if eq .Values.controller.type "statefulset" }}
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
- mountPath: {{ $vct.mountPath }}
  name: {{ tpl ( toString $index ) $ }}
      {{- if $vct.subPath }}
  subPath: {{ $vct.subPath }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end -}}
