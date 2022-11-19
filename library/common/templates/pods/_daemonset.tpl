{{/*
This template serves as the blueprint for the DaemonSet objects that are created
within the common library.
*/}}
{{- define "ix.v1.common.daemonset" }}
---
apiVersion: {{ include "ix.v1.common.capabilities.daemonset.apiVersion" $ }}
kind: DaemonSet
metadata:
  name: {{ include "ix.v1.common.names.fullname" . }}
  labels:
  annotations:
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
  {{- $strategy := default "RollingUpdate" .Values.controller.strategy -}}
  {{- if not (mustHas $strategy (list "OnDelete" "RollingUpdate")) -}}
    {{- fail (printf "Not a valid strategy type for Daemonset (%s)" $strategy) -}}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- $rollingUpdate := .Values.controller.rollingUpdate -}}
    {{- if and (eq $strategy "RollingUpdate") (or $rollingUpdate.surge $rollingUpdate.unavailable) }}
    rollingUpdate:
      {{- with $rollingUpdate.unavailable }}
      maxUnavailable: {{ . }}
      {{- end -}}
      {{- with $rollingUpdate.surge }}
      maxSurge: {{ . }}
      {{- end -}}
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
{{/*TODO: unittests*/}}
