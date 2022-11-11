{{/* Volumes included by the controller. */}}
{{- define "ix.v1.common.controller.volumes" -}}
{{- $persistenceDefault := "pvc" -}}
{{- range $index, $persistence := .Values.persistence }}
{{- if $persistence.enabled }}
  {{- if not $persistence.type }} {{/* If persistence type is not defined, fallback to $persistenceDefault */}}
    {{ $_ := set $persistence "type" $persistenceDefault }}
  {{- end }}
- name: {{ tpl ( toString $index ) $ }}
  {{- if eq ($persistence.type | lower) "pvc" }} {{/* PVC */}}
    {{- $pvcName := (include "ix.v1.common.names.fullname" $) -}}
    {{- if $persistence.existingClaim }} {{/* Always prefer existingClaim if it set */}}
      {{- $pvcName = $persistence.existingClaim -}}
    {{- else -}} {{/* Else use nameOverride */}}
      {{- if $persistence.nameOverride -}}
        {{- if not (eq $persistence.nameOverride "-") -}}
          {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $) $persistence.nameOverride) -}}
        {{- end -}}
      {{- else -}} {{/* Else generate the PVC name from fullname + volume name */}}
        {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $) $index) -}}
      {{- end -}}
      {{- if $persistence.forceName -}}
        {{- $pvcName = $persistence.forceName }}
      {{- end -}}
    {{- end }}
  persistentVolumeClaim:
    claimName: {{ tpl $pvcName $ }}
  {{- else if eq ($persistence.type | lower) "emptydir" }} {{/* emptyDir */}}
    {{- if not (or $persistence.medium $persistence.sizeLimit) }}
  emptyDir: {}
    {{- else }}
  emptyDir:
      {{- with $persistence.medium }}
      {{- if eq ((tpl . $) | lower) "memory" }}
    medium: Memory
        {{- else }}
          {{- fail "You can only set medium as (Memory)" }}
        {{- end }}
      {{- end }}
      {{- with $persistence.sizeLimit }}
    sizeLimit: {{ tpl . $ }}
      {{- end }}
    {{- end }}
  {{- else if or (eq ($persistence.type | lower) "configmap") (eq ($persistence.type | lower) "secret") }}
    {{- $objectName := (required (printf "objectName not set for persistence item %s" (toString $index)) $persistence.objectName) }}
    {{- $objectName = tpl $objectName $ }}
    {{- if eq ($persistence.type | lower) "configmap" }} {{/* configMap */}}
  configMap:
    name: {{ $objectName }}
    {{- else }} {{/* secret */}}
  secret:
    secretName: {{ $objectName }}
    {{- end }}
    {{- with $persistence.defaultMode }}
    defaultMode: {{ tpl (toString .) $ }}
    {{- end }}
    {{- with $persistence.items }}
    items:
      {{- range . }}
      - key: {{ tpl (required (printf "No key was given for persistence item %s" (toString $index)) .key) $ }}
        path: {{ tpl (required (printf "No path was given for persistence item %s" (toString $index)) .path) $ }}
      {{- end }}
    {{- end }}
  {{- else if eq ($persistence.type | lower) "hostpath" }} {{/* hostPath */}}
  hostPath:
    path: {{ required (printf "hostPath not set on item %s" $index) $persistence.hostPath }}
    {{- with $persistence.hostPathType }}
    type: {{ tpl . $ }}
    {{- end }}
  {{- else if eq ($persistence.type | lower) "nfs" }}
  nfs:
    server: {{ required (printf "NFS Server not set on item %s" $index) $persistence.server }}
    path: {{ required (printf "NFS Path not set on item %s" $index) $persistence.path }}
  {{- else if eq ($persistence.type | lower) "ix-volumes" }} {{/* ix-volumes */}}
  {{/* TODO: Implement ix-volumes */}}
  {{- else if eq ($persistence.type | lower) "custom" }} {{/* Custom, in case we want to add something once */}}
    {{- tpl ( toYaml $persistence.volumeSpec ) $ | nindent 2 }}
  {{- else }}
    {{- fail (printf "Not a valid persistence.type (%s)" $persistence.type) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{/*
For emptyDir:
If the `SizeMemoryBackedVolumes` feature gate is enabled,
you can specify a size for memory backed volumes.
*/}}
