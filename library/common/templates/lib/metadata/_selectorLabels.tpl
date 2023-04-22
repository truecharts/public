{{/* Labels that are used on selectors */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" $objectType "objectName" $objectName) }}
podName is the "shortName" of the pod. The one you define in the .Values.workload
*/}}
{{- define "tc.v1.common.lib.metadata.selectorLabels" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectType := .objectType -}}
  {{- $objectName := .objectName }}

{{- if and $objectType $objectName }}
{{ printf "%s.name" $objectType }}: {{ $objectName }}
{{- end }}
app.kubernetes.io/name: {{ include "tc.v1.common.lib.chart.names.name" $rootCtx }}
app.kubernetes.io/instance: {{ $rootCtx.Release.Name }}
{{- end -}}
