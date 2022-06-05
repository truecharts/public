{{/*
The OpenVPN credentials secrets to be included.
*/}}
{{- define "tc.common.addon.openvpn.secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ include "tc.common.names.fullname" $ }}-openvpn
  labels:
  {{- include "tc.common.labels" $ | nindent 4 }}
data:
  VPN_AUTH: {{ ( printf "%v;%v" .Values.addons.vpn.openvpn.username .Values.addons.vpn.openvpn.password ) | b64enc }}
{{- end -}}
