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


  {{- $_ := set .Values.persistence "vpnconfig" .Values.addons.vpn.configFile -}}


{{- end -}}
{{- end -}}
