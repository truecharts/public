{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "common.addon.vpn" -}}
{{- if ne "disabled" .Values.addons.vpn.type -}}
  {{- if eq "openvpn" .Values.addons.vpn.type -}}
    {{- include "common.addon.openvpn" . }}
  {{- end -}}

  {{- if eq "wireguard" .Values.addons.vpn.type -}}
    {{- include "common.addon.wireguard" . }}
  {{- end -}}

  {{/* Include the configmap if not empty */}}
  {{- $configmap := include "common.addon.vpn.configmap" . -}}
  {{- if $configmap -}}
    {{- $configmap | nindent 0 -}}
  {{- end -}}

  {{- $_ := set .Values.persistence "vpnConfig" .Values.addons.vpn.configFile -}}

  {{/* Append the vpn scripts volume to the volumes */}}
  {{- $scriptVolume := include "common.addon.vpn.scriptsVolumeSpec" . | fromYaml -}}
  {{- if $scriptVolume -}}
    {{- $_ := set .Values.persistence "vpnscript" (dict "enabled" "true" "mountPath" "-" "type" "custom" "volumeSpec" $scriptVolume) -}}
  {{- end -}}

  {{/* Append the vpn config volume to the volumes */}}
  {{- $configVolume := include "common.addon.vpn.configVolumeSpec" . | fromYaml }}
  {{ if $configVolume -}}
    {{- $_ := set .Values.persistence "vpnconfig" (dict "enabled" "true" "mountPath" "-" "type" "custom" "volumeSpec" $configVolume) -}}
  {{- end -}}

{{- end -}}
{{- end -}}
