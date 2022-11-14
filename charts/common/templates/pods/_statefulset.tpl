{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the common library.
*/}}
{{- define "tc.common.statefulset" }}
{{- $values := .Values }}
{{- $releaseName := .Release.Name }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "tc.common.names.fullname" . }}
  {{- with (merge (.Values.controller.labels | default dict) (include "tc.common.labels" $ | fromYaml)) }}
  labels: {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  {{- with (merge (.Values.controller.annotations | default dict) (include "tc.common.annotations" $ | fromYaml) (include "tc.common.annotations.workload" $ | fromYaml)) }}
  annotations: {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  replicas: {{ .Values.controller.replicas }}
  {{- $strategy := default "RollingUpdate" .Values.controller.strategy }}
  {{- if and (ne $strategy "OnDelete") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for StatefulSet (%s)" $strategy) }}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- if and (eq $strategy "RollingUpdate") .Values.controller.rollingUpdate.partition }}
    rollingUpdate:
      partition: {{ .Values.controller.rollingUpdate.partition }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "tc.common.labels.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "tc.common.names.fullname" . }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- tpl ( toYaml . ) $ | nindent 8 }}
      {{- end }}
      labels:
        {{- include "tc.common.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- tpl ( toYaml . ) $ | nindent 8 }}
        {{- end }}
    spec:
      {{- include "tc.common.controller.pod" . | nindent 6 }}
  volumeClaimTemplates:
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
    - metadata:
        name: {{ tpl ( toString $index ) $ }}
      spec:
        accessModes:
          - {{ tpl ( $vct.accessMode | default "ReadWriteOnce" ) $ | quote }}
        resources:
          requests:
            storage: {{ tpl ( $vct.size | default "999Gi" ) $ | quote }}
        {{ include "tc.common.storage.storageClassName" ( dict "persistence" $vct "global" $) }}
    {{- end }}
{{- end }}
