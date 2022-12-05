{{/* Returns the terminationMessagePath for the container */}}
{{- define "ix.v1.common.container.termination.messagePath" -}}
  {{- tpl .Values.termination.messagePath $ }}
{{- end -}}

{{/* Returns the terminationMessagePolicy for the container */}}
{{- define "ix.v1.common.container.termination.messagePolicy" -}}
  {{- $policy := (tpl .Values.termination.messagePolicy $) -}}
  {{- with $policy -}}
    {{- if not (mustHas . (list "File" "FallbackToLogsOnError")) }}
      {{- fail "Not valid option for messagePolicy" -}}
    {{- end }}
    {{- $policy }}
  {{- end -}}
{{- end -}}
