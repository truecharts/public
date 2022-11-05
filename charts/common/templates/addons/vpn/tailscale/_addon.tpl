{{/*
Template to render Tailscale addon. It will add the container to the list of additionalContainers.
*/}}

{{- define "tc.common.addon.tailscale" -}}
  {{/* Append the Tailscale container to the additionalContainers */}}
  {{- $container := fromYaml (include "tc.common.addon.tailscale.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-tailscale" $container -}}
    {{- include "tailscale.secret" . -}}
    {{- $_ := set .Values.persistence (printf "%v-%v" .Release.Name "tailscale" ) (include "tailscale.addon.persistence" . | fromYaml) -}}
  {{- end -}}
{{- end -}}
