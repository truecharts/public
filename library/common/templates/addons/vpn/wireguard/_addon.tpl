{{/*
Template to render Wireguard addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "tc.v1.common.addon.wireguard" -}}
  {{/* Append the Wireguard container to the additionalContainers */}}
  {{- $container := fromYaml (include "tc.v1.common.addon.wireguard.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "wireguard" $container -}}
  {{- end -}}
{{- end -}}
