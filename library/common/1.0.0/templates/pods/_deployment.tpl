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
  {{- $labels := merge (default dict .Values.controller.labels) (include "ix.v1.common.labels" $ | fromYaml) }}
  labels: {{- (toYaml $labels) | nindent 4 }}
  {{- $annotations := merge (default dict .Values.controller.annotations) (include "ix.v1.common.annotations" $ | fromYaml) (include "ix.v1.common.annotations.workload" $ | fromYaml ) }}
  annotations: {{- (toYaml $annotations) | nindent 4 }}
spec:
  revisionHistoryLimit: {{ .Values.controller.revisionHistoryLimit }}
{{- end }}
