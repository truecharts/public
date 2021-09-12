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

  {{- $_ := set .Values.persistence "vpnconfig" .Values.addons.vpn.configFile -}}


{{- end -}}
{{- end -}}
