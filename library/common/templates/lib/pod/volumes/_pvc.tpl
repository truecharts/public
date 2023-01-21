{{- define "ix.v1.common.controller.volumes.pvc" -}}
  {{- $index := .index -}}
  {{- $vol := .volume -}}
  {{- $root := .root -}}
  {{- $pvcName := include "ix.v1.common.names.volume.pvc" (dict "index" $index "root" $root "pvcVolValues" $vol) }}
- name: {{ $index }}
  persistentVolumeClaim:
    claimName: {{ tpl $pvcName $root }}
{{- end -}}
