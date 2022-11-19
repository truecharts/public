{{/* The pod definition included in the controller. */}}
{{- define "ix.v1.common.controller.pod" -}}
{{- with (include "ix.v1.common.container.podSecurityContext" (dict "podSecCont" .Values.podSecurityContext) | trim) }}
securityContext:
  {{- . | nindent 2 }}
{{- end }}
containers:
  {{- include "ix.v1.common.controller.mainContainer" . | nindent 2 }}
{{- with (include "ix.v1.common.controller.volumes" . | trim) }}
volumes:
    {{- . | nindent 2 }}
{{- end }}
{{- end -}}
