{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.gluetun" -}}
{{- if ne "disabled" .Values.addons.vpn.type -}}
  {{- if .Values.addons.vpn.config -}}
    {{/* Append the vpn config secret to the secrets */}}
    {{- $secret := include "tc.v1.common.addon.gluetun.secret" . | fromYaml -}}
    {{- if $secret -}}
      {{- $_ := set .Values.secret "vpnconfig" $secret -}}
    {{- end -}}
  {{- end }}

  {{- if or .Values.addons.vpn.configFile .Values.addons.vpn.config .Values.addons.vpn.existingSecret -}}
    {{/* Append the vpn config to the persistence */}}
    {{- $configper := include "tc.v1.common.addon.gluetun.volume.config" . | fromYaml -}}
    {{- if $configper -}}
      {{- $_ := set .Values.persistence "vpnconfig" $configper -}}
    {{- end -}}
  {{- end -}}

  {{/* Ensure target Selector defaults to main pod even if unset */}}
  {{- $targetSelector := list "main" -}}
  {{- if $.Values.addons.vpn.targetSelector -}}
    {{- $targetSelector = $.Values.addons.vpn.targetSelector -}}
  {{- end -}}

  {{/* Append the vpn container to the containers */}}
  {{- range $targetSelector -}}
    {{- $container := dict -}}
    {{- $containerModify := dict -}}
      {{- $container = $.Values.addons.vpn.gluetun.container -}}
      {{- $containerModify = include "tc.v1.common.addon.gluetun.containerModify" $ | fromYaml -}}
    {{- if $container.enabled -}}
      {{- range $targetSelector -}}
        {{- $mergedContainer := mustMergeOverwrite $container $containerModify -}}
        {{- $workload := get $.Values.workload . -}}
        {{- $_ := set $workload.podSpec.containers "vpn" $mergedContainer -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}
