{{/*
Main entrypoint for the common library chart. It will render all underlying templates based on the provided values.
*/}}
{{- define "common.all" -}}
  {{- /* Merge the local chart values and the common chart defaults */ -}}
  {{- include "common.values.setup" . }}

  {{- /* Build the templates */ -}}
  {{- include "common.pvc" . }}
  {{- print "---" | nindent 0 -}}
  {{- if .Values.serviceAccount.create -}}
    {{- include "common.serviceAccount" . }}
    {{- print "---" | nindent 0 -}}
  {{- end -}}
  {{- if eq .Values.controllerType "deployment" }}
    {{- include "common.deployment" . | nindent 0 }}
  {{ else if eq .Values.controllerType "daemonset" }}
    {{- include "common.daemonset" . | nindent 0 }}
  {{ else if eq .Values.controllerType "statefulset"  }}
    {{- include "common.statefulset" . | nindent 0 }}
  {{- end -}}
  {{ include "common.services" . | nindent 0 }}
  {{ include "common.ingress" .  | nindent 0 }}
  {{ include "common.resources.portal" .  | nindent 0 }}
  {{ include "common.storage.permissions" .  | nindent 0 }}

{{- end -}}
