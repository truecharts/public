{{/* Job Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.job" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData: The object data to be used to render the Job.
*/}}

{{- define "tc.v1.common.class.job" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- include "tc.v1.common.lib.workload.jobValidation" (dict "objectData" $objectData) }}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Job") }}
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
  {{- include "tc.v1.common.lib.workload.jobSpec" (dict "rootCtx" $rootCtx "objectData" $objectData) | indent 2 }}
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
{{- end -}}
