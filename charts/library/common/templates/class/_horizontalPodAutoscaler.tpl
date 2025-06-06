{{/*
This template serves as a blueprint for horizontal pod autoscaler objects that are created
using the common library.
*/}}
{{- define "tc.v1.common.class.hpa" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "VPA") }}
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
  minReplicas: {{ $objectData.minReplicas }}
  maxReplicas: {{ $objectData.maxReplicas }}

  {{- with $objectData.metrics }}
  metrics:
    {{- $objectData.metrics | toYaml | nindent 4 }}
  {{- end -}}

  {{- if $objectData.behavior }}
  behavior:
    {{- if $objectData.behavior.scaleUp }}
    scaleUp:
      {{- include "tc.v1.common.class.hpa.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "mode" "up") | nindent 4 }}
    {{- end -}}
    {{- if $objectData.behavior.scaleDown }}
    scaleDown:
      {{- include "tc.v1.common.class.hpa.behavior" (dict "objectData" $objectData "rootCtx" $rootCtx "mode" "down") | nindent 4 }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.behavior" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $mode := .mode -}}

  {{- $key := ternary "scaleUp" "scaleDown" (eq $mode "up") -}}
  {{- $behavior := get $objectData.behavior $key -}}

  {{- $defaultStabilizationWindowSeconds := ternary 0 300 (eq $mode "up") }}
  selectPolicy: {{ $behavior.selectPolicy | default "Max" }}
  stabilizationWindowSeconds: {{ $behavior.stabilizationWindowSeconds | default $defaultStabilizationWindowSeconds }}
  {{- if $behavior.policies }}
  policies:
    {{- range $idx, $policy := $behavior.policies }}
    - type: {{ $policy.type }}
      value: {{ $policy.value }}
      periodSeconds: {{ $policy.periodSeconds }}
    {{- end }}
  {{- end -}}

{{- end -}}
