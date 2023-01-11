{{/* Returns the terminationMessagePath for the container */}}
{{- define "ix.v1.common.container.termination.messagePath" -}}
  {{- $msgPath := .msgPath -}}
  {{- $root := .root -}}
  {{- if $msgPath -}}
    {{- tpl $msgPath $root -}}
  {{- end -}}
{{- end -}}

{{/* Returns the terminationMessagePolicy for the container */}}
{{- define "ix.v1.common.container.termination.messagePolicy" -}}
  {{- $msgPolicy := .msgPolicy -}}
  {{- $root := .root -}}

  {{- $policy := "" -}}
  {{- if $msgPolicy -}}
    {{- $policy = (tpl $msgPolicy $root) -}}
  {{- end -}}

  {{- with $policy -}}
    {{- if not (mustHas . (list "File" "FallbackToLogsOnError")) }}
      {{- fail (printf "Not valid option for messagePolicy (%s). Valid options are FallbackToLogsOnError and File" $policy) -}}
    {{- end }}
    {{- $policy }}
  {{- end -}}
{{- end -}}
