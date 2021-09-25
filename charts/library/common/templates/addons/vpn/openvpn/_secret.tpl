{{/*
The OpenVPN credentials secrets to be included.
*/}}
{{- define "common.addon.openvpn.secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "common.names.fullname" $ }}-openvpn
  labels:
  {{- include "common.labels" $ | nindent 4 }}
data:
  {{- $vpnauth := "" }}
  {{- if .Values.addons.vpn.openvpn.username }}
    {{- $vpnauth = ( printf "%v;%v" .Values.addons.vpn.openvpn.username .Values.addons.vpn.openvpn.password ) }}
  {{- else }}
    {{- $vpnauth = .Values.addons.vpn.openvpn.password }}
  {{- end }}
  VPN_AUTH: {{ $vpnauth | b64enc }}
{{- end -}}
