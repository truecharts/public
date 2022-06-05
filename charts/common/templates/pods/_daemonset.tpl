{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the common library.
*/}}
{{- define "tc.common.daemonset" }}
---
apiVersion: apps/v1
kind: DaemonSet
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
  selector:
    matchLabels:
      {{- include "tc.common.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      annotations:
      {{- include "tc.common.annotations.workload.spec" . | nindent 8 }}
      {{- with .Values.podAnnotations }}
        {{- tpl ( toYaml . ) $ | nindent 8 }}
      {{- end }}
      labels:
        {{- include "tc.common.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- tpl ( toYaml . ) $ | nindent 8 }}
        {{- end }}
    spec:
      {{- include "tc.common.controller.pod" . | nindent 6 }}
{{- end }}
