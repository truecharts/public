{{/* schedule Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.velero.schedule" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the schedule.
  labels: The labels of the schedule.
  annotations: The annotations of the schedule.
  namespace: The namespace of the schedule. (Optional)
*/}}

{{- define "tc.v1.common.class.velero.schedule" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: velero.io/v1
kind: Schedule
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Schedule") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  schedule: {{ $objectData.schedule | quote }}
  {{- if (kindIs "bool" $objectData.useOwnerReferencesInBackup) }}
  useOwnerReferencesInBackup: {{ $objectData.useOwnerReferencesInBackup }}
  {{- end -}}
  {{- with $objectData.template }}
  template:
    {{- toYaml . | nindent 4 }}
  {{- end -}}
{{- end -}}
