{{/*
Secondary entrypoint and primary loader for the common chart
*/}}
{{- define "tc.common.loader.apply" -}}

  {{/* Render the externalInterfaces */}}
  {{ include "tc.common.scale.externalInterfaces" .  | nindent 0 }}

  {{/* Enable code-server add-on if required */}}
  {{- if .Values.addons.codeserver.enabled }}
    {{- include "tc.common.addon.codeserver" . }}
  {{- end -}}

  {{/* Enable VPN add-on if required */}}
  {{- if ne "disabled" .Values.addons.vpn.type -}}
    {{- include "tc.common.addon.vpn" . }}
  {{- end -}}

  {{/* Build the configmaps */}}
  {{ include "tc.common.spawner.configmap" . | nindent 0 }}

  {{/* Build the secrets */}}
  {{ include "tc.common.spawner.secret" . | nindent 0 }}

  {{/* Build the templates */}}
  {{- include "tc.common.spawner.pvc" . }}

  {{ include "tc.common.spawner.serviceaccount" . | nindent 0 }}

  {{- if .Values.controller.enabled }}
    {{- if eq .Values.controller.type "deployment" }}
      {{- include "tc.common.deployment" . | nindent 0 }}
    {{ else if eq .Values.controller.type "daemonset" }}
      {{- include "tc.common.daemonset" . | nindent 0 }}
    {{ else if eq .Values.controller.type "statefulset"  }}
      {{- include "tc.common.statefulset" . | nindent 0 }}
    {{ else }}
      {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) }}
    {{- end -}}
 {{- end -}}

  {{ include "tc.common.spawner.rbac" . | nindent 0 }}

  {{ include "tc.common.spawner.hpa" . | nindent 0 }}

  {{ include "tc.common.spawner.service" . | nindent 0 }}

  {{ include "tc.common.spawner.ingress" .  | nindent 0 }}

  {{ include "tc.common.scale.portal" .  | nindent 0 }}

  {{ include "tc.common.spawner.networkpolicy" . | nindent 0 }}

{{- end -}}
