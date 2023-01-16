{{/*
This template serves as the blueprint for the StatefulSet objects that are created
within the common library.
*/}}
{{- define "ix.v1.common.statefulset" }}
---
apiVersion: {{ include "ix.v1.common.capabilities.statefulset.apiVersion" $ }}
kind: StatefulSet
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
  selector:
    matchLabels:
      {{- include "ix.v1.common.labels.selectorLabels" . | nindent 6 }}
  serviceName: {{ include "ix.v1.common.names.fullname" . }}
  {{- $strategy := default "RollingUpdate" .Values.controller.strategy -}}
  {{- if not (mustHas $strategy (list "OnDelete" "RollingUpdate")) -}}
    {{- fail (printf "Not a valid strategy type for Deployment (%s)" $strategy) -}}
  {{- end }}
  updateStrategy:
    type: {{ $strategy }}
    {{- $rollingUpdate := .Values.controller.rollingUpdate -}}
    {{- if and (eq $strategy "RollingUpdate") (or $rollingUpdate.partition $rollingUpdate.unavailable) }}
    rollingUpdate:
      {{- with $rollingUpdate.unavailable }}
      maxUnavailable: {{ . }}
      {{- end -}}
      {{- with $rollingUpdate.partition }}
      partition: {{ . }}
      {{- end -}}
    {{- end -}}
  {{- if .Values.volumeClaimTemplates }}
  volumeClaimTemplates:
    {{- range $index, $vct := .Values.volumeClaimTemplates }}
  - metadata:
      name: {{ tpl (toString $index) $ }}
    spec:
      {{- with (include "ix.v1.common.storage.storageClassName" (dict "persistence" $vct "root" $)) | trim }}
      storageClassName: {{ . }}
      {{- end }}
      accessModes:
        - {{ tpl ($vct.accessMode | default $.Values.global.defaults.accessMode) $ }}
      resources:
        requests:
          storage: {{ tpl ($vct.size | default $.Values.global.defaults.VCTSize) $ | quote }}
    {{- end -}}
  {{- end -}}
{{- end }}
{{/*TODO: unittests*/}}
