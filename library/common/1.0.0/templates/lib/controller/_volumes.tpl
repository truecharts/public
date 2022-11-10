{{/*
Volumes included by the controller.
*/}}
{{- define "ix.v1.common.controller.volumes" -}}
{{- $persistenceDefault := "pvc" -}}
{{- range $index, $persistence := .Values.persistence }}
{{- if $persistence.enabled }}
  {{/* If persistence type is not defined, fallback to $persistenceDefault */}}
  {{- if not $persistence.type }}
    {{ $_ := set $persistence "type" $persistenceDefault }}
  {{- end }}
- name: {{ tpl ( toString $index ) $ }}
  {{/* PVC */}}
  {{- if eq ($persistence.type | lower) "pvc" }}
    {{- $pvcName := (include "ix.v1.common.names.fullname" $) -}}
    {{- if $persistence.existingClaim }}
      {{/* Always prefer existingClaim if it set */}}
      {{- $pvcName = $persistence.existingClaim -}}
    {{- else -}}
      {{/* Otherwise refer to the PVC name */}}
      {{- if $persistence.nameOverride -}}
        {{- if not (eq $persistence.nameOverride "-") -}}
          {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $) $persistence.nameOverride) -}}
        {{- end -}}
      {{- else -}}
        {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $) $index) -}}
      {{- end -}}
      {{- if $persistence.forceName -}}
        {{- $pvcName = $persistence.forceName }}
      {{- end -}}
    {{- end }}
  persistentVolumeClaim:
    claimName: {{ tpl $pvcName $ }}
  {{/* emptyDir */}}
  {{- else if eq ($persistence.type | lower) "emptydir" }}
    {{- $emptyDir := dict -}}
    {{- with $persistence.medium -}}
        {{- $_ := set $emptyDir "medium" "Memory" -}}
    {{- end }}
    {{/*
    If the `SizeMemoryBackedVolumes` feature gate is enabled,
    you can specify a size for memory backed volumes.
    */}}
    {{- with $persistence.sizeLimit -}}
        {{- $_ := set $emptyDir "sizeLimit" . -}}
    {{- end }}
  emptyDir: {{- tpl (toYaml $emptyDir) $ | nindent 4 }}
  {{- else if or (eq ($persistence.type | lower) "configmap") (eq ($persistence.type | lower) "secret") }}
    {{- $objectName := (required (printf "objectName not set for persistence item %s" $index) $persistence.objectName) }}
    {{- $objectName = tpl $objectName $ }}
    {{/* configMap */}}
    {{- if eq ($persistence.type | lower) "configmap" }}
  configMap:
    name: {{ $objectName }}
    {{- else }}
    {{/* secret */}}
  secret:
    secretName: {{ $objectName }}
    {{- end }}
    {{- with $persistence.defaultMode }}
    defaultMode: {{ tpl . $ }}
    {{- end }}
    {{- with $persistence.items }}
    items:
      {{- tpl (toYaml .) $ | nindent 6 }}
    {{- end }}
  {{- else if eq ($persistence.type | lower) "hostpath" }}
  {{/* hostPath */}}
  hostPath:
    path: {{ required (printf "hostPath not set on item %s" $index) $persistence.hostPath }}
    {{- with $persistence.hostPathType }}
    type: {{ tpl . $ }}
    {{- end }}
  {{- else if eq ($persistence.type | lower) "nfs" }}
  nfs:
    server: {{ required (printf "NFS Server not set on item %s" $index) $persistence.server }}
    path: {{ required (printf "NFS Path not set on item %s" $index) $persistence.path }}
  {{/* ix-volumes */}}
  {{- else if eq ($persistence.type | lower) "ix-volumes" }}
  {{/* TODO: Implement ix-volumes */}}
  {{/* Custom, in case we want to add something once */}}
  {{- else if eq ($persistence.type | lower) "custom" }}
    {{- tpl ( toYaml $persistence.volumeSpec ) $ | nindent 2 }}
  {{- else }}
    {{- fail (printf "Not a valid persistence.type (%s)" $persistence.type) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
