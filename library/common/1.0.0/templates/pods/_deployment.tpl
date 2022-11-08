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
  labels:
  annotations:
spec:
{{- end }}
