{{/*
Define appVolumeMounts for container
*/}}
{{- define "common.storage.configureAppVolumeMountsInContainer" -}}
{{- if and .Values.appVolumesEnabled .Values.appVolumeMounts }}
{{- range $name, $avm := .Values.appVolumeMounts -}}
{{- if (default true $avm.enabled) }}
{{- if $avm.containerNameOverride -}}
{{- $name = $avm.containerNameOverride -}}
{{- end -}}
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
{{- define "common.storage.configureAppVolumes" -}}
{{- if .Values.appVolumeMounts }}
{{- range $name, $av := .Values.appVolumeMounts -}}
{{- if (default true $av.enabled) }}
- name: {{ $name }}
  {{- if or $av.emptyDir $.Values.emptyDirVolumes }}
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
