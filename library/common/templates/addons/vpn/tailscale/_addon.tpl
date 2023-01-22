{{/*
Template to render Tailscale addon. It will add the container to the list of additionalContainers.
*/}}

{{- define "tc.v1.common.addon.tailscale" -}}
  {{/* Append the Tailscale container to the additionalContainers */}}
  {{- $container := (include "tc.v1.common.addon.tailscale.container" . | fromYaml) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "tailscale" $container -}}
    {{- include "tailscale.secret" . -}}
    {{- $_ := set .Values.persistence (printf "%v-%v" .Release.Name "tailscale" ) (include "tailscale.addon.persistence" . | fromYaml) -}}
  {{- end -}}
{{- end -}}
