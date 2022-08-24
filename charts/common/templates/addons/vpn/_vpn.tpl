{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.common.addon.vpn" -}}
{{- if ne "disabled" .Values.addons.vpn.type -}}
  {{- if eq "openvpn" .Values.addons.vpn.type -}}
    {{- include "tc.common.addon.openvpn" . }}
  {{- end -}}

  {{- if eq "wireguard" .Values.addons.vpn.type -}}
    {{- include "tc.common.addon.wireguard" . }}
  {{- end -}}

  {{- if eq "tailscale" .Values.addons.vpn.type -}}
    {{- include "tc.common.addon.tailscale" . }}
  {{- end -}}

  {{- if ne "tailscale" .Values.addons.vpn.type -}}
    {{- $_ := set .Values.persistence "vpnconfig" .Values.addons.vpn.configFile -}}
  {{- end -}}

{{- end -}}
{{- end -}}
