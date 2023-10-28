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
  {{- end -}}

  {{- $stop -}}
{{- end -}}
