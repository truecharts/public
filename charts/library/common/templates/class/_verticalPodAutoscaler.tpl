{{/*
This template serves as a blueprint for horizontal pod autoscaler objects that are created
using the common library.
*/}}
{{- define "tc.v1.common.class.vpa" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

---
apiVersion: {{ include "tc.v1.common.capabilities.vpa.apiVersion" $ }}
kind: VerticalPodAutoscaler
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "VPA") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ $objectData.workload.type }}
    name: {{ $objectData.name }}
  updatePolicy:
    updateMode: {{ $objectData.updatePolicy.updateMode | default "auto" }}
  resourcePolicy:
    containerPolicies: {{- toYaml $objectData.resourcePolicy.containerPolicies | nindent 4 }}


{{- end -}}
