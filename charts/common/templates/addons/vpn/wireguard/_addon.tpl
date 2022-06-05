{{/*
Template to render Wireguard addon. It will add the container to the list of additionalContainers.
*/}}
*/}}
{{- define "tc.common.addon.wireguard" -}}
  {{/* Append the Wireguard container to the additionalContainers */}}
  {{- $container := fromYaml (include "tc.common.addon.wireguard.container" .) -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-wireguard" $container -}}
  {{- end -}}
{{- end -}}
