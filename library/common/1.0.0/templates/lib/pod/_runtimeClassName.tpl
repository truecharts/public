{{- define "ix.v1.common.runtimeClassName" -}}
  {{- $root := .root -}}
  {{- $runtime := .runtime -}}

  {{/* Override previous if a runtime is passed from the pod */}}
  {{- $runtimeName := "" -}}
  {{- with $root.Values.global.defaults.runtimeClassName -}}
    {{- $runtimeName = . -}}
  {{- end -}}

  {{/* Override previous if a runtime is passed from the pod */}}
  {{- with $runtime -}}
    {{- $runtimeName := . -}}
  {{- end -}}

 {{/* Override all previous if running in Scale and it's defined */}}
  {{- if hasKey $root.Values.global "ixChartContext" -}}
    {{- if $root.Values.global.ixChartContext.addNvidiaRuntimeClass -}}
      {{- $runtimeName = $root.Values.global.ixChartContext.nvidiaRuntimeClassName -}}
    {{- end -}}
  {{- end -}}

  {{/* Still check that any of the above applies before returning it */}}
  {{- if $runtimeName -}}
    {{- print $runtimeName -}}
  {{- end -}}
{{- end -}}
