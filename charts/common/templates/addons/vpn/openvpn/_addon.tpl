{{/*
Template to render OpenVPN addon. It will add the container to the list of additionalContainers
and add a credentials secret if speciffied.
*/}}
{{- define "tc.common.addon.openvpn" -}}
  {{/* Append the openVPN container to the additionalContainers */}}
  {{- $container := include "tc.common.addon.openvpn.container" . | fromYaml -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-openvpn" $container -}}
  {{- end -}}

  {{/* Include the secret if not empty */}}
  {{- $secret := include "tc.common.addon.openvpn.secret" . -}}
  {{- if $secret -}}
    {{- $secret | nindent 0 -}}
  {{- end -}}
{{- end -}}
