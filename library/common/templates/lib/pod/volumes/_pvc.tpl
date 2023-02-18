{{/* Returns PVC Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.pvc" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.pvc" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $pvcName := (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectData.shortName) -}}
  {{- with $objectData.existingClaim -}}
    {{- $pvcName = tpl . $rootCtx -}}
  {{- end }}
- name: {{ $objectData.shortName }}
  persistentVolumeClaim:
    claimName: {{ $pvcName }}
{{- end -}}
