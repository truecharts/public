
{{/*
Volumes included by the controller.
*/}}
{{- define "common.controller.volumeMounts" -}}
{{- range $index, $PVC := .Values.persistence }}
{{- if and ( $PVC.enabled ) ( $PVC.mountPath ) }}
- mountPath: {{ $PVC.mountPath }}
  name: {{ $index }}
{{- if $PVC.subPath }}
  subPath: {{ $PVC.subPath }}
{{- end }}
{{- end }}
{{- end }}


{{ range $name, $dmm := .Values.deviceMounts }}
{{- if $dmm.enabled -}}
{{ if $dmm.name }}
  {{ $name = $dmm.name }}
{{ end }}
- name: devicemount-{{ $name }}
  mountPath: {{ $dmm.devicePath }}
  {{ if $dmm.subPath }}
  subPath: {{ $dmm.subPath }}
  {{ end }}
{{- end -}}
{{ end }}

{{ range $name, $csm := .Values.customStorage }}
{{- if $csm.enabled -}}
{{ if $csm.name }}
  {{ $name = $csm.name }}
{{ end }}
- name: customstorage-{{ $name }}
  mountPath: {{ $csm.mountPath }}
  {{ if $csm.subPath }}
  subPath: {{ $csm.subPath }}
  {{ end }}
  {{ if $csm.readOnly }}
  readOnly: {{ $csm.readOnly }}
  {{ end }}
{{- end -}}
{{ end }}


{{- if .Values.additionalVolumeMounts }}
  {{- toYaml .Values.additionalVolumeMounts | nindent 0 }}
{{- end }}


{{- if eq .Values.controllerType "statefulset"  }}
{{- range $index, $vct := .Values.volumeClaimTemplates }}
- mountPath: {{ $vct.mountPath }}
  name: {{ $vct.name }}
{{- if $vct.subPath }}
  subPath: {{ $vct.subPath }}
{{- end }}
{{- end }}
{{- end }}

{{- end -}}
