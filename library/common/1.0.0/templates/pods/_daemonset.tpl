{{/*
This template serves as the blueprint for the Deployment objects that are created
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
{{- end }}
