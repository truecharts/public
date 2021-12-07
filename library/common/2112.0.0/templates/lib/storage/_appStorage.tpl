{{/*
Define appVolumeMounts for container
*/}}
{{- define "common.storage.configureAppVolumeMountsInContainer" -}}
{{- include "common.schema.validateKeys" (dict "values" . "checkKeys" (list "appVolumeMounts")) -}}
{{- $appVolumeMounts := .appVolumeMounts -}}
{{- if $appVolumeMounts -}}
{{ range $name, $avm := $appVolumeMounts }}
{{- if (default true $avm.enabled) -}}
{{ if $avm.containerNameOverride }}
{{ $name = $avm.containerNameOverride }}
{{ end }}
- name: {{ $name }}
  mountPath: {{ $avm.mountPath }}
  {{ if $avm.subPath }}
  subPath: {{ $avm.subPath }}
  {{ end }}
  {{ if $avm.readOnly }}
  readOnly: {{ $avm.readOnly }}
  {{ end }}
{{- end -}}
{{ end }}
{{- end -}}
{{- end -}}


{{/*
Define hostPath for appVolumes
*/}}
{{- define "common.storage.configureAppVolumes" -}}
{{- include "common.schema.validateKeys" (dict "values" . "checkKeys" (list "appVolumeMounts")) -}}
{{- $values := . -}}
{{- if $values.appVolumeMounts -}}
{{- range $name, $av := $values.appVolumeMounts -}}
{{ if (default true $av.enabled) }}
- name: {{ $name }}
  {{ if or $av.emptyDir $.emptyDirVolumes }}
  emptyDir: {}
  {{- else -}}
  hostPath:
    {{ if $av.hostPathEnabled }}
    path: {{ required "hostPath not set" $av.hostPath }}
    {{ else }}
    {{- include "common.schema.validateKeys" (dict "values" $values "checkKeys" (list "ixVolumes")) -}}
    {{- include "common.schema.validateKeys" (dict "values" $av "checkKeys" (list "datasetName")) -}}
    {{- $volDict := dict "datasetName" $av.datasetName "ixVolumes" $values.ixVolumes -}}
    path: {{ include "common.storage.retrieveHostPathFromiXVolume" $volDict }}
    {{ end }}
  {{ end }}
{{ end }}
{{- end -}}
{{- end -}}
{{- end -}}


{{/*
Get all volumes configuration
*/}}
{{- define "common.storage.allAppVolumes" -}}
{{- $appVolumeMounts := .appVolumeMounts -}}
{{- if $appVolumeMounts -}}
volumes: {{- include "common.storage.configureAppVolumes" . | nindent 2 -}}
{{- end -}}
{{- end -}}


{{/*
Get all container volume moutns configuration
*/}}
{{- define "common.storage.allContainerVolumeMounts" -}}
{{- $appVolumeMounts := .appVolumeMounts -}}
{{- if $appVolumeMounts -}}
volumeMounts: {{- include "common.storage.configureAppVolumeMountsInContainer" . | nindent 2 -}}
{{- end -}}
{{- end -}}
