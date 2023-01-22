{{/*
The OpenVPN credentials secrets to be included.
*/}}
{{- define "tc.v1.common.addon.openvpn.secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "ix.v1.common.names.fullname" $ }}-openvpn
data:
  VPN_AUTH: {{ ( printf "%v;%v" .Values.addons.vpn.openvpn.username .Values.addons.vpn.openvpn.password ) | b64enc }}
{{- end -}}
