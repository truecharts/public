{{/*
This template serves as a blueprint for horizontal pod autoscaler objects that are created
using the common library.
*/}}
{{- define "tc.v1.common.class.hpa" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $_ := set $objectData "updatePolicy" ($objectData.updatePolicy | default dict) -}}
  {{- $_ := set $objectData "resourcePolicy" ($objectData.resourcePolicy | default dict) }}
---
apiVersion: {{ include "tc.v1.common.capabilities.hpa.apiVersion" $ }}
kind: HorizontalPodAutoscaler
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "hpa") }}
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
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ $objectData.workload.type }}
    name: {{ $objectData.name }}
  minReplicas: {{ $objectData.minReplicas | default 1 }}
  maxReplicas: {{ $objectData.maxReplicas | default 3 }}
  {{- with $objectData.metrics }}
  metrics:
    {{- $objectData.metrics | toYaml | nindent 4 }}
  {{- end -}}

  {{- with $objectData.behavior }}
  behavior:
    {{- $objectData.behavior | toYaml | nindent 4 }}
  {{- end -}}
{{- end -}}
