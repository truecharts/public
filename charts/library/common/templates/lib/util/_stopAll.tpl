{{- define "tc.v1.common.lib.util.stopAll" -}}
  {{- $rootCtx := . -}}

  {{- $stop := "" -}}
  {{- if $rootCtx.Values.global.stopAll -}}
    {{- $stop = true -}}
  {{- end -}}

  {{- $stop -}}
{{- end -}}
