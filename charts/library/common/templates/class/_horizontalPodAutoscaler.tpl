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
  {{- if $objectData.metrics }}
  metrics:
    {{- include "tc.v1.common.class.hpa.metrics" (dict "objectData" $objectData "rootCtx" $rootCtx) | nindent 4 }}
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

{{- define "tc.v1.common.class.hpa.metrics" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- range $idx, $metric := $objectData.metrics }}
    {{- if eq $metric.type "Resource" }}
      {{- include "tc.v1.common.class.hpa.metrics.resource" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric) | nindent 6 }}
    {{- else if eq $metric.type "ContainerResource" }}
      {{- include "tc.v1.common.class.hpa.metrics.containerResource" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric) | nindent 6 }}
    {{- else if eq $metric.type "Pods" }}
      {{- include "tc.v1.common.class.hpa.metrics.pods" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric) | nindent 6 }}
    {{- else if eq $metric.type "Object" }}
      {{- include "tc.v1.common.class.hpa.metrics.object" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric) | nindent 6 }}
    {{- else if eq $metric.type "External" }}
      {{- include "tc.v1.common.class.hpa.metrics.external" (dict "objectData" $objectData "rootCtx" $rootCtx "metric" $metric) | nindent 6 }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.metrics.resource" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx }}
  - type: Resource
    resource:
      name: {{ .metric.resource.name }}
      target:
        type: {{ .metric.resource.target.type }}
        {{- if eq .metric.resource.target.type "AverageValue" }}
        averageValue: {{ .metric.resource.target.averageValue | quote }}
        {{- else if eq .metric.resource.target.type "Utilization" }}
        averageUtilization: {{ .metric.resource.target.averageUtilization }}
        {{- end -}}
        {{- with .metric.resource.target.value }}
        value: {{ . | quote }}
        {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.metrics.containerResource" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx }}
  - type: ContainerResource
    containerResource:
      name: {{ .metric.containerResource.name }}
      container: {{ .metric.containerResource.container}}
      target:
        type: {{ .metric.containerResource.target.type }}
        {{- if eq .metric.containerResource.target.type "AverageValue" }}
        averageValue: {{ .metric.containerResource.target.averageValue | quote }}
        {{- else if eq .metric.containerResource.target.type "Utilization" }}
        averageUtilization: {{ .metric.containerResource.target.averageUtilization }}
        {{- end -}}
        {{- with .metric.containerResource.target.value }}
        value: {{ . | quote }}
        {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.metrics.pods" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx }}
  - type: Pods
    pods:
      target:
        type: AverageValue
        averageValue: {{ .metric.pods.target.averageValue | quote }}
      metric:
        name: {{ .metric.pods.metric.name }}
        {{- if .metric.pods.metric.selector }}
        selector:
          matchLabels:
            {{- range $key, $value := .metric.pods.metric.selector.matchLabels }}
            {{ $key }}: {{ $value | quote }}
            {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.metrics.object" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx }}
  - type: Object
    object:
      target:
        type: {{ .metric.object.target.type }}
        {{- if eq .metric.object.target.type "Value" }}
        value: {{ .metric.object.target.value | quote }}
        {{- else if eq .metric.object.target.type "AverageValue" }}
        averageValue: {{ .metric.object.target.averageValue | quote }}
        {{- end }}
      describedObject:
        apiVersion: {{ .metric.object.describedObject.apiVersion }}
        kind: {{ .metric.object.describedObject.kind }}
        name: {{ .metric.object.describedObject.name }}
      metric:
        name: {{ .metric.object.metric.name }}
        {{- if .metric.object.metric.selector }}
        selector:
          matchLabels:
          {{- range $key, $value := .metric.object.metric.selector.matchLabels }}
            {{ $key }}: {{ $value | quote }}
          {{- end -}}
        {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.hpa.metrics.external" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx }}
  - type: External
    external:
      metric:
        name: {{ .metric.external.metric.name }}
        {{- if .metric.external.metric.selector }}
        selector:
          matchLabels:
          {{- range $key, $value := .metric.external.metric.selector.matchLabels }}
            {{ $key }}: {{ $value | quote }}
          {{- end -}}
        {{- end }}
      target:
        type: {{ .metric.external.target.type }}
        {{- if eq .metric.external.target.type "Value" }}
        value: {{ .metric.external.target.value | quote }}
        {{- else if eq .metric.external.target.type "AverageValue" }}
        averageValue: {{ .metric.external.target.averageValue | quote }}
        {{- end -}}
{{- end -}}
