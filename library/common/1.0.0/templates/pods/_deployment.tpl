{{/*
This template serves as the blueprint for the Deployment objects that are created
within the common library.
*/}}
{{- define "ix.v1.common.deployment" }}
---
apiVersion: {{ include "ix.v1.common.capabilities.deployment.apiVersion" $ }}
kind: Deployment
metadata:
  name: {{ include "ix.v1.common.names.fullname" . }}
  {{- with (merge (default dict .Values.controller.labels) (include "ix.v1.common.labels" $ | fromYaml)) }}
  labels: {{- tpl (toYaml .) $ | nindent 4 }}
  {{- end }}
  {{- with (merge (default dict .Values.controller.annotations) (include "ix.v1.common.annotations" $ | fromYaml) (include "ix.v1.common.annotations.workload" $ | fromYaml)) }}
  annotations: {{- tpl (toYaml .) $ | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  replicas: {{ .Values.controller.replicas }}
  {{- $strategy := default "Recreate" .Values.controller.strategy }}
  {{- if and (ne $strategy "Recreate") (ne $strategy "RollingUpdate") }}
    {{- fail (printf "Not a valid strategy type for Deployment (%s)" $strategy) }}
  {{- end }}
  strategy:
    type: {{ $strategy }}
    {{- $rollingUpdate := .Values.controller.rollingUpdate }}
    {{- if and (eq $strategy "RollingUpdate") (or $rollingUpdate.surge $rollingUpdate.unavailable) }}
    rollingUpdate:
      {{- with $rollingUpdate.unavailable }}
      maxUnavailable: {{ . }}
      {{- end }}
      {{- with $rollingUpdate.surge }}
      maxSurge: {{ . }}
      {{- end }}
    {{- end }}
  selector:
    matchLabels:
      {{- include "ix.v1.common.labels.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      annotations:
        {{- include "ix.v1.common.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podAnnotations }}
          {{- tpl (toYaml .) $ | nindent 8 }}
        {{- end }}
      labels:
        {{- include "ix.v1.common.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- tpl (toYaml .) $ | nindent 8 }}
        {{- end }}
  spec:
    {{- include "ix.v1.common.controller.pod" . | nindent 6 }}
{{- end }}
