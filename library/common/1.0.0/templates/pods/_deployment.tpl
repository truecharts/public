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
  {{- with (mustMerge (default dict .Values.controller.labels) (include "ix.v1.common.labels" $ | fromYaml)) }}
  labels: {{- tpl (toYaml .) $ | nindent 4 }}
  {{- end }}
  {{- with (mustMerge (default dict .Values.controller.annotations) (include "ix.v1.common.annotations" $ | fromYaml) (include "ix.v1.common.annotations.workload" $ | fromYaml)) }}
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
      {{- with (mustMerge (include "ix.v1.common.labels.selectorLabels" . | fromYaml) (include "ix.v1.common.podAnnotations" . | fromYaml)) }}
      annotations:
        {{- . | toYaml | trim | nindent 8 }}
      {{- end -}}
      {{- with (mustMerge (include "ix.v1.common.labels.selectorLabels" . | fromYaml) (include "ix.v1.common.podLabels" . | fromYaml)) }}
      labels:
        {{- . | toYaml | trim | nindent 8 }}
      {{- end }}
    spec:
      {{- include "ix.v1.common.controller.pod" . | trim | nindent 6 }}
{{- end }}
