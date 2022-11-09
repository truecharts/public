{{- define "ix.v1.common.loader.apply" -}}
  {{- if .Values.controller.enabled }}
    {{- if eq (.Values.controller.type | lower) "deployment" }}
      {{- include "ix.v1.common.deployment" . | nindent 0 }}
    {{ else if eq (.Values.controller.type | lower) "daemonset" }}
      {{- include "ix.v1.common.daemonset" . | nindent 0 }}
    {{ else if eq (.Values.controller.type | lower) "statefulset"  }}
      {{- include "ix.v1.common.statefulset" . | nindent 0 }}
    {{ else }}
      {{- fail (printf "Not a valid controller.type (%s)" .Values.controller.type) }}
    {{- end -}}
 {{- end -}}
{{- end -}}
