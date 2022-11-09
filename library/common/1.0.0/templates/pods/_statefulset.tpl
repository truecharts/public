{{/*
This template serves as the blueprint for the Deployment objects that are created
within the common library.
*/}}
{{- define "ix.v1.common.statefulset" }}
---
apiVersion: {{ include "ix.v1.common.capabilities.statefulset.apiVersion" $ }}
kind: StatefulSet
metadata:
  name: {{ include "ix.v1.common.names.fullname" . }}
  labels:
  annotations:
spec:
{{- end }}
