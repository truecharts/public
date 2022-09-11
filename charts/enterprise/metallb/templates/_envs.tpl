{{/* Define the configmap */}}
{{- define "metallb.controller.envs" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: controllerenvs
data:
  {{- if and .Values.speaker.enabled .Values.speaker.memberlist.enabled }}
  METALLB_ML_SECRET_NAME: {{ include "tc.common.names.fullname" . }}-memberlist
  METALLB_DEPLOYMENT: {{ include "tc.common.names.fullname" . }}
  {{- end }}
  {{- if .Values.speaker.frr.enabled }}
  METALLB_BGP_TYPE: frr
  {{- end }}
{{- end -}}
