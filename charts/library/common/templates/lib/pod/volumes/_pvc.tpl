{{/* Returns PVC Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.pvc" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.pvc" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $pvcName := include "tc.v1.common.lib.storage.pvc.name" (dict "rootCtx" $rootCtx "objectName" $objectData.shortName "objectData" $objectData) -}}
  {{- with $objectData.existingClaim -}}
    {{- $pvcName = tpl . $rootCtx -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  persistentVolumeClaim:
    claimName: {{ $pvcName }}
{{- end -}}
