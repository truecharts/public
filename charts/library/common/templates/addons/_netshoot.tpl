{{/*
Template to render code-server addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.netshoot" -}}
  {{- $netshoot := $.Values.addons.netshoot -}}
  {{- if $netshoot.enabled -}}
    {{- $targetSelector := list "main" -}}
    {{- if $netshoot.targetSelector -}}
      {{- $targetSelector = $netshoot.targetSelector -}}
    {{- end -}}

    {{- range $targetSelector -}}
      {{/* Append the code-server container to the workloads */}}
      {{- $workload := get $.Values.workload . -}}
      {{- $_ := set $workload.podSpec.containers "netshoot" $.Values.addons.netshoot.container -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
