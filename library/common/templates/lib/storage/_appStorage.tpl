{{/*
Define appVolumeMounts for container
*/}}
{{- define "common.storage.configuredAppVolumeMounts" -}}
{{- if .Values.appVolumeMounts }}
{{- range $name, $avm := .Values.appVolumeMounts -}}
{{- if $avm.enabled }}
- name: {{ $name }}
  mountPath: {{ $avm.mountPath }}
  {{- if $avm.subPath }}
  subPath: {{ $avm.subPath }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Define hostPath for appVolumes
*/}}
{{- define "common.storage.configuredAppVolumes" -}}
{{- if .Values.appVolumeMounts }}
{{- range $name, $av := .Values.appVolumeMounts -}}
{{- if $av.enabled }}
- name: {{ $name }}
  {{- if $av.emptyDir }}
  emptyDir: {}
  {{- else }}
  hostPath:
    {{ if $av.hostPathEnabled }}
    path: {{ required "hostPath not set" $av.hostPath }}
    {{- else }}
    {{- $volDict := dict "datasetName" $av.datasetName "ixVolumes" $.Values.ixVolumes -}}
    path: {{ include "common.storage.retrieveHostPathFromiXVolume" $volDict }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
