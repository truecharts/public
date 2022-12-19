{{- define "ix.v1.common.loader.apply" -}}

  {{- include "ix.v1.common.spawner.externalInterface" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.certificate" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.imagePullSecret" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.serviceAccount" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.rbac" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.configmap" . | nindent 0 -}}

  {{- if .Values.controller.enabled -}}
    {{- if eq .Values.controller.type "Deployment" -}}
      {{- include "ix.v1.common.deployment" . | nindent 0 -}}
    {{- else if eq .Values.controller.type "DaemonSet" -}}
      {{- include "ix.v1.common.daemonset" . | nindent 0 -}}
    {{- else if eq .Values.controller.type "StatefulSet" -}}
      {{- include "ix.v1.common.statefulset" . | nindent 0 -}}
    {{- else -}}
      {{- fail (printf "Not a valid controller.type (%s). Valid options are Deployment, DaemonSet, StatefulSet" .Values.controller.type) -}}
    {{- end -}}
  {{- end -}}

  {{- include "ix.v1.common.spawner.service" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.pvc" . | nindent 0 -}}

  {{- include "ix.v1.common.spawner.portal" . | nindent 0 -}}

  {{- include "ix.v1.common.util.envCheckDupes" (dict "root" .) -}}

  {{- include "ix.v1.common.util.cleanupEnvsForCheck" (dict "root" .) -}}
  {{- if .Values.envsForDupeCheck -}}
    {{- fail "Failed to cleanup <envsForDupeCheck> key." -}}
  {{- end -}}
{{- end -}}
