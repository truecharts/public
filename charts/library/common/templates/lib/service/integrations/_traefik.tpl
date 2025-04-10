{{- define "tc.v1.common.lib.service.integration.traefik" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $traefik := $objectData.integrations.traefik -}}

  {{- if $traefik.enabled -}}
    {{- include "tc.v1.common.lib.service.integration.traefik.validate" (dict "objectData" $objectData) -}}
    {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/service.serversscheme" "https" -}}
  {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.service.integration.traefik.validate" -}}
  {{- $objectData := .objectData -}}

{{- end -}}
