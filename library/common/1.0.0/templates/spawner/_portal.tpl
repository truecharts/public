{{- define "ix.v1.common.spawner.portal" -}}
  {{- if .Values.portal -}}
    {{- if .Values.portal.enabled -}}
      {{- include "ix.v1.common.class.portal" (dict "root" $) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
