{{/*
Retrieve host path from ix volumes based on dataset name
*/}}
{{- define "retrieveHostPathFromiXVolume" -}}
{{- range $index, $hostPathConfiguration := $.ixVolumes }}
{{- $dsName := base $hostPathConfiguration.hostPath -}}
{{- if eq $.datasetName $dsName -}}
{{- $hostPathConfiguration.hostPath -}}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Define appVolumeMounts for container
*/}}
{{- define "configuredAppVolumeMounts" -}}
{{- if and .Values.appVolumesEnabled .Values.appVolumeMounts }}
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
{{- define "configuredAppVolumes" -}}
{{- if and .Values.appVolumesEnabled .Values.appVolumeMounts }}
{{- range $name, $av := .Values.appVolumeMounts -}}
{{- if $av.enabled }}
- name: {{ $name }}
  {{- if or $av.emptyDir $.Values.emptyDirVolumes }}
  emptyDir: {}
  {{- else }}
  hostPath:
    {{ if $av.hostPathEnabled }}
    path: {{ required "hostPath not set" $av.hostPath }}
    {{- else }}
    {{- $volDict := dict "datasetName" $av.datasetName "ixVolumes" $.Values.ixVolumes -}}
    path: {{ include "retrieveHostPathFromiXVolume" $volDict }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
