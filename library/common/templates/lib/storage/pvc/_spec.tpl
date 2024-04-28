{{/* Returns Persitant Volume Claim Spec*/}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.pvc.spec" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.storage.pvc.spec" -}}
{{- $rootCtx := .rootCtx -}}
{{- $objectData := .objectData -}}

{{- $size := $rootCtx.Values.global.fallbackDefaults.pvcSize -}}
{{- with $objectData.size -}}
  {{- $size = tpl . $rootCtx -}}
{{- end }}

accessModes:
  {{- include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "PVC") | trim | nindent 2 }}
resources:
  requests:
    storage: {{ $size }}
  {{- with $objectData.volumeName }}
volumeName: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.storage.storageClassName" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "PVC") | trim) }}
storageClassName: {{ . }}
  {{- end -}}
  {{- with $objectData.dataSource -}}
    {{- $sourceName := .name -}}
    {{- if eq .kind "PersistentVolumeClaim" -}}
      {{- with get $rootCtx.persistence $sourceName -}}
        {{- $sourceName := (include "tc.v1.common.lib.storage.pvc.name" (dict "rootCtx" $rootCtx "objectName" $sourceName "objectData" .)) -}}
      {{- end -}}
    {{- end }}
dataSource:
  kind: {{ .kind }}
  name: {{ $sourceName }}
  {{- end -}}

{{- with $objectData.dataSourceRef }}
dataSourceRef:
  kind: {{ .kind }}
  name: {{ .name }}
  apiGroup: {{ .apiGroup }}
{{- end -}}
{{- end -}}
