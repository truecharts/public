{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.tailscale" -}}
{{- if ne "disabled" .Values.addons.vpn.type -}}
  {{- if .Values.addons.vpn.config -}}
    {{/* Append the vpn config secret to the secrets */}}
    {{- $secret := include "tc.v1.common.addon.tailscale.secret" . | fromYaml -}}
    {{- if $secret -}}
      {{- $_ := set .Values.secret "vpnconfig" $secret -}}
    {{- end -}}
  {{- end }}

  {{- if or .Values.addons.vpn.configFile .Values.addons.vpn.config .Values.addons.vpn.existingSecret -}}
    {{/* Append the vpn config to the persistence */}}
    {{- $configper := include "tc.v1.common.addon.tailscale.volume.config" . | fromYaml -}}
    {{- if $configper -}}
      {{- $_ := set .Values.persistence "vpnconfig" $configper -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.addons.vpn.configFolder -}}
    {{/* Append the vpn folder to the persistence */}}
    {{- $folderper := include "tc.v1.common.addon.tailscale.volume.folder" . | fromYaml -}}
    {{- if $folderper -}}
      {{- $_ := set .Values.persistence "vpnfolder" $folderper -}}
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

    {{/* FIXME: https://github.com/tailscale/tailscale/issues/8188 */}}
    {{- $_ := set $.Values.podOptions "automountServiceAccountToken" true -}}
    {{- $container = $.Values.addons.vpn.tailscale.container -}}
    {{- $containerModify = include "tc.v1.common.addon.tailscale.containerModify" $ | fromYaml -}}

    {{- if $container.enabled -}}
      {{- range $targetSelector -}}
        {{- $mergedContainer := mustMergeOverwrite $container $containerModify -}}
        {{- $workload := get $.Values.workload . -}}
        {{- $_ := set $workload.podSpec.containers "vpn" $mergedContainer -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if eq "tailscale" $.Values.addons.vpn.type -}}
    {{/* Append the empty tailscale folder to the persistence */}}
    {{- $tailscaledir := include "tc.v1.common.addon.tailscale.volume.tailscale" . | fromYaml -}}
    {{- if $tailscaledir -}}
      {{- $_ := set .Values.persistence "tailscalestate" $tailscaledir -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
{{- end -}}
