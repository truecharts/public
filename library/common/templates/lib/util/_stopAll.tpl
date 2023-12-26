{{- define "tc.v1.common.lib.util.stopAll" -}}
  {{- $rootCtx := . -}}

  {{- $stop := "" -}}
  {{- if $rootCtx.Values.global.stopAll -}}
    {{- $stop = true -}}
  {{- end -}}

  {{- with $rootCtx.Values.global.ixChartContext -}}
    {{- if .isStopped -}}
      {{- $stop = true -}}
    {{- end -}}
    {{/* Useful for cases like external-service */}}
    {{- if $rootCtx.Values.global.ignoreIsStopped -}}
      {{- $stop = "" -}}
    {{- end -}}
  {{- end -}}

  {{- $stop -}}
{{- end -}}
