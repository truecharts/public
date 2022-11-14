{{/*
Volumes included by the controller.
*/}}
{{- define "tc.common.controller.volumes" -}}
{{- range $index, $persistence := .Values.persistence }}
{{- if $persistence.enabled }}
- name: {{ tpl ( toString $index ) $ }}
  {{- if eq (default "pvc" $persistence.type) "pvc" }}
    {{- $pvcName := (include "tc.common.names.fullname" $) -}}
    {{- if $persistence.existingClaim }}
      {{/* Always prefer an existingClaim if that is set */}}
      {{- $pvcName = $persistence.existingClaim -}}
    {{- else -}}
      {{/* Otherwise refer to the PVC name */}}
      {{- if $persistence.nameOverride -}}
        {{- if not (eq $persistence.nameOverride "-") -}}
          {{- $pvcName = (printf "%s-%s" (include "tc.common.names.fullname" $) $persistence.nameOverride) -}}
        {{- end -}}
      {{- else -}}
        {{- $pvcName = (printf "%s-%s" (include "tc.common.names.fullname" $) $index) -}}
      {{- end -}}
      {{- if $persistence.forceName -}}
        {{- $pvcName = $persistence.forceName -}}
      {{- end -}}
    {{- end }}
  persistentVolumeClaim:
    claimName: {{ tpl $pvcName $ }}
  {{- else if eq $persistence.type "emptyDir" }}
    {{- $emptyDir := dict -}}
    {{- with $persistence.medium -}}
      {{- $_ := set $emptyDir "medium" . -}}
    {{- end -}}
    {{- with $persistence.sizeLimit -}}
      {{- $_ := set $emptyDir "sizeLimit" . -}}
    {{- end }}
  emptyDir: {{- tpl ( toYaml $emptyDir ) $ | nindent 4 }}
  {{- else if or (eq $persistence.type "configMap") (eq $persistence.type "secret") }}
    {{- $objectName := (required (printf "objectName not set for persistence item %s" $index) $persistence.objectName) }}
    {{- $objectName = tpl $objectName $ }}
    {{- if eq $persistence.type "configMap" }}
  configMap:
    name: {{ $objectName }}
    {{- else }}
  secret:
    secretName: {{ $objectName }}
    {{- end }}
    {{- with $persistence.defaultMode }}
    defaultMode: {{ tpl . $ }}
    {{- end }}
    {{- with $persistence.items }}
    items:
      {{- tpl ( toYaml . ) $ | nindent 6 }}
    {{- end }}
  {{- else if eq $persistence.type "hostPath" }}
  hostPath:
    path: {{ required "hostPath not set" $persistence.hostPath }}
    {{- with $persistence.hostPathType }}
    type: {{ tpl  . $ }}
    {{- end }}
  {{- else if eq $persistence.type "nfs" }}
  nfs:
    server: {{ required "server not set" $persistence.server }}
    path: {{ required "path not set" $persistence.path }}
  {{- else if eq $persistence.type "custom" }}
    {{- tpl ( toYaml $persistence.volumeSpec ) $ | nindent 2 }}
  {{- else }}
    {{- fail (printf "Not a valid persistence.type (%s)" $persistence.type) }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}
