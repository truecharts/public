{{- define "ix.v1.common.controller.volumes.pvc" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $pvcName := (include "ix.v1.common.names.fullname" $root) -}}
  {{- if $vol.existingClaim -}} {{/* Always prefer existingClaim if it set */}}
    {{- $pvcName = $vol.existingClaim -}}
  {{- else -}} {{/* Else use nameOverride */}}
    {{- if $vol.nameOverride -}}
      {{- if not (eq $vol.nameOverride "-") -}}
        {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $root) $vol.nameOverride) -}}
      {{- end -}}
    {{- else -}} {{/* Else generate the PVC name from fullname + volume name */}}
      {{- $pvcName = (printf "%s-%s" (include "ix.v1.common.names.fullname" $root) $index) -}}
    {{- end -}}
    {{- with $vol.forceName -}}
      {{- $pvcName = . -}}
    {{- end -}}
  {{- end }}
- name: {{ $index }}
  persistentVolumeClaim:
    claimName: {{ tpl $pvcName $root }}
{{- end -}}
