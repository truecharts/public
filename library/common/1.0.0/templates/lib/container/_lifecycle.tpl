{{/* Returns the lifecycle for the container */}}
{{- define "ix.v1.common.container.lifecycle" -}}
  {{- if (hasKey .Values.lifecycle "preStop") -}}
    {{- with .Values.lifecycle.preStop.command }}
      {{- print "preStop:" | nindent 0 }}
      {{- print "exec:" | nindent 2 }}
      {{- print "command:" | nindent 4 }}
      {{- include "ix.v1.common.container.command" (dict "commands" . "root" $) | trim | nindent 6 }}
    {{- else -}}
      {{- fail "No commands were given for preStop lifecycle hook" -}}
    {{- end -}}
  {{- end -}}
  {{- if (hasKey .Values.lifecycle "postStart") -}}
    {{- with .Values.lifecycle.postStart.command }}
      {{- print "postStart:" | nindent 0 }}
      {{- print "exec:" | nindent 2 }}
      {{- print "command:" | nindent 4 }}
      {{- include "ix.v1.common.container.command" (dict "commands" . "root" $) | trim | nindent 6 }}
    {{- else -}}
      {{- fail "No commands were given for postStart lifecycle hook" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
