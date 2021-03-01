{{/*
Define appVolumeMounts for container
*/}}
{{- define "common.storage.configureAppVolumeMountsInContainer" -}}
{{ range $name, $avm := . }}
{{- if (default true $avm.enabled) -}}
{{ if $avm.name }}
{{ $name = $avm.name }}
{{ end }}
- name: {{ $name }}
  mountPath: {{ $avm.mountPath }}
  {{ if $avm.subPath }}
  subPath: {{ $avm.subPath }}
  {{ end }}
{{- end -}}
{{ end }}
{{- end -}}


{{/*
Define hostPath for appVolumes
*/}}
{{- define "common.storage.configureAppVolumes" -}}
{{- range $name, $av := $.volMounts -}}
{{ if (default true $av.enabled) }}
{{ if $av.name }}
{{ $name = $av.name }}
{{ end }}
- name: {{ $name }}
  {{ if $av.emptyDir }}
  emptyDir: {}
  {{- else -}}
  hostPath:
    {{ if $av.hostPathEnabled }}
    path: {{ required "hostPath not set" $av.hostPath }}
    {{ else }}
    {{- $ixVolDict := dict "datasetName" $av.datasetName "ixVolumes" $.ixVolumes -}}
    path: {{ include "common.storage.retrieveHostPathFromiXVolume" $ixVolDict }}
    {{ end }}
  {{ end }}
{{ end }}
{{- end -}}
{{- end -}}


{{/*
Get all volumes configuration
*/}}
{{- define "common.storage.allAppVolumes" -}}

{{- $volDict := dict "volMounts" .Values.appVolumeMounts "ixVolumes" .Values.ixVolumes -}}
{{- $volExtraDict := dict "volMounts" .Values.appExtraVolumeMounts "ixVolumes" .Values.ixVolumes -}}

{{- if .Values.appVolumeMounts -}}
{{- include "common.storage.configureAppVolumes" $volDict | nindent 0 -}}
{{- end -}}
{{- if .Values.appExtraVolumeMounts -}}
{{- include "common.storage.configureAppVolumes" $volExtraDict | nindent 0 -}}
{{- end -}}

{{- end -}}


{{/*
Get all container volume moutns configuration
*/}}
{{- define "common.storage.allContainerVolumeMounts" -}}

{{- if .Values.appVolumeMounts -}}
{{- include "common.storage.configureAppVolumeMountsInContainer" .Values.appVolumeMounts | nindent 0 -}}
{{- end -}}
{{- if .Values.appExtraVolumeMounts -}}
{{- include "common.storage.configureAppVolumeMountsInContainer" .Values.appExtraVolumeMounts | nindent 0 -}}
{{- end -}}

{{- end -}}
