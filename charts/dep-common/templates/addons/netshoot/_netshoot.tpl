{{/*
Template to render netshoot addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "common.addon.netshoot" -}}
{{- if .Values.addons.netshoot.enabled -}}
  {{/* Append the netshoot container to the additionalContainers */}}
  {{- $container := include "common.addon.netshoot.container" . | fromYaml -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-netshoot" $container -}}
  {{- end -}}
{{- end -}}
{{- end -}}
