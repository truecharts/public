{{/*
Secondary entrypoint and primary loader for the common chart
*/}}
{{- define "common.postSetup" -}}
  {{- /* Render the externalInterfaces */ -}}
  {{ include "common.classes.externalInterfaces" .  | nindent 0 }}

  {{- /* Enable code-server add-on if required */ -}}
  {{- if .Values.addons.codeserver.enabled }}
    {{- include "common.addon.codeserver" . }}
  {{- end -}}

  {{- /* Enable VPN add-on if required */ -}}
  {{- if ne "disabled" .Values.addons.vpn.type -}}
    {{- include "common.addon.vpn" . }}
  {{- end -}}

  {{- /* Enable promtail add-on if required */ -}}
  {{- if .Values.addons.promtail.enabled }}
    {{- include "common.addon.promtail" . }}
  {{- end -}}

  {{- /* Enable netshoot add-on if required */ -}}
  {{- if .Values.addons.netshoot.enabled }}
    {{- include "common.addon.netshoot" . }}
  {{- end -}}

  {{- /* Build the confimap */ -}}
  {{ include "common.configmap" . | nindent 0 }}

  {{- /* Build the templates */ -}}
  {{- include "common.pvc" . }}

  {{- include "common.serviceAccount" . }}

  {{- if .Values.controller.enabled }}
    {{- if eq .Values.controller.type "deployment" }}
      {{- include "common.deployment" . | nindent 0 }}
    {{ else if eq .Values.controller.type "daemonset" }}
      {{- include "common.daemonset" . | nindent 0 }}
    {{ else if eq .Values.controller.type "statefulset"  }}
      {{- include "common.statefulset" . | nindent 0 }}
    {{ else }}
      {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) }}
    {{- end -}}
 {{- end -}}

  {{ include "common.rbac" . | nindent 0 }}

  {{ include "common.hpa" . | nindent 0 }}

  {{ include "common.service" . | nindent 0 }}

  {{ include "common.ingress" .  | nindent 0 }}

  {{- if .Values.secret -}}
    {{ include "common.secret" .  | nindent 0 }}
  {{- end -}}

  {{ include "common.configmap.portal" .  | nindent 0 }}

  {{ include "common.networkpolicy" . | nindent 0 }}
{{- end -}}
