{{/*
Template to render code-server addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.netshoot" -}}
  {{- if .Values.addons.netshoot.enabled -}}
    {{- $targetSelector := list "main" -}}
    {{- if $.Values.addons.netshoot.targetSelector -}}
      {{- $targetSelector = $.Values.addons.netshoot.container.targetSelector -}}
    {{- end -}}
    {{- range $targetSelector -}}
      {{/* Append the code-server container to the workloads */}}
      {{- $workload := get $.Values.workload . -}}
      {{- $_ := set $workload.podSpec.containers "netshoot" $.Values.addons.netshoot.container -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
