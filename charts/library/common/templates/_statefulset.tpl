{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the common library.
*/}}
{{- define "common.statefulset" }}
{{- $releaseName := .Release.Name }}
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: {{ include "common.names.fullname" . }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
    {{- with .Values.controller.labels }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with .Values.controller.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
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
      {{- include "common.labels.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "common.names.fullname" . }}
  template:
    metadata:
      {{- with .Values.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "common.labels.selectorLabels" . | nindent 8 }}
        {{- with .Values.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- include "common.controller.pod" . | nindent 6 }}
  volumeClaimTemplates:
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
    {{- $vctname := $index }}
    {{- if $vct.name }}
    {{- $vctname := $vct.name }}
    {{- end }}
    - metadata:
        name: {{ $vctname }}
      spec:
        accessModes:
          - {{ required (printf "accessMode is required for vCT %v" $vct.name) $vct.accessMode  | quote }}
        resources:
          requests:
            storage: {{ required (printf "size is required for PVC %v" $vct.name) $vct.size | quote }}
        {{- if $vct.storageClass }}
        storageClassName: {{ if (eq "-" $vct.storageClass) }}""{{- else if (eq "SCALE-ZFS" $vct.storageClass ) }}{{ ( printf "%v-%v"  "ix-storage-class" $releaseName ) }}{{- else }}{{ $vct.storageClass | quote }}{{- end }}
        {{- else if .Values.ixChartContext }}
        storageClassName: {{ printf "%v-%v"  "ix-storage-class" .Release.Name }}
        {{- end }}
    {{- end }}
{{- end }}
