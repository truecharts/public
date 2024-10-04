{{/* StatefulSet Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.deployment" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData: The object data to be used to render the StatefulSet.
*/}}

{{- define "tc.v1.common.class.statefulset" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- include "tc.v1.common.lib.workload.statefulsetValidation" (dict "objectData" $objectData) }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "StatefulSet") }}
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
  {{- include "tc.v1.common.lib.workload.statefulsetSpec" (dict "rootCtx" $rootCtx "objectData" $objectData) | indent 2 }}
  selector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $objectData.shortName) | trim | nindent 6 }}
  template:
    metadata:
        {{- $labels := (mustMerge ($objectData.podSpec.labels | default dict)
                                  (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)
                                  (include "tc.v1.common.lib.metadata.podLabels" (dict "rootCtx" $rootCtx "objectData" $objectData) | fromYaml)
                                  (include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $objectData.shortName) | fromYaml)) -}}
        {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
      labels:
        {{- . | nindent 8 }}
        {{- end -}}
        {{- $annotations := (mustMerge ($objectData.podSpec.annotations | default dict)
                                        (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)
                                        (include "tc.v1.common.lib.metadata.podAnnotations" $rootCtx | fromYaml)) -}}
        {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
      annotations:
        {{- . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "tc.v1.common.lib.workload.pod" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 6 }}
  {{- with (include "tc.v1.common.lib.storage.volumeClaimTemplates" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
  volumeClaimTemplates:
    {{- . | nindent 4 }}
  {{- end }}
{{- end -}}
