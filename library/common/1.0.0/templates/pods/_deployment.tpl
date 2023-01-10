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
  {{- $labels := (mustMerge (default dict .Values.controller.labels) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge (default dict .Values.controller.annotations) (include "ix.v1.common.annotations" $ | fromYaml) (include "ix.v1.common.annotations.workload.spec" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  replicas: {{ .Values.controller.replicas }}
  {{- $strategy := default "Recreate" .Values.controller.strategy }}
  {{- if not (mustHas $strategy (list "Recreate" "RollingUpdate")) }}
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
      {{- with (mustMerge (include "ix.v1.common.labels.selectorLabels" . | fromYaml) (include "ix.v1.common.annotations.workload" . | fromYaml) (include "ix.v1.common.podAnnotations" . | fromYaml)) }}
      annotations:
        {{- . | toYaml | trim | nindent 8 }}
      {{- end -}}
      {{- with (mustMerge (include "ix.v1.common.labels.selectorLabels" . | fromYaml) (include "ix.v1.common.podLabels" . | fromYaml)) }}
      labels:
        {{- . | toYaml | trim | nindent 8 }}
      {{- end }}
    spec:
      {{- include "ix.v1.common.controller.pod" $ | trim | nindent 6 }}
{{- end }}
