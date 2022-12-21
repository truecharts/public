{{- define "ix.v1.common.runtimeClassName" -}}
  {{- $root := .root -}}
  {{- if hasKey $root.Values.global "ixChartContext" -}}
    {{- if $root.Values.global.ixChartContext.addNvidiaRuntimeClass -}}
      {{- print $root.Values.global.ixChartContext.nvidiaRuntimeClassName -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
