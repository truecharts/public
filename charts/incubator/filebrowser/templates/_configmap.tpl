{{- define "focalboard.configmap" -}}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-install
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  .filebrowser.json: |
    {{- tpl .Values.config $ | nindent 4 }}
