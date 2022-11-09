{{/*
The pod definition included in the controller.
*/}}
{{- define "ix.v1.common.controller.pod" -}}
  {{- with (include "ix.v1.common.controller.volumes" . | trim) }}
volumes:
    {{- . | nindent 2 }}
  {{- end }}
{{- end -}}
